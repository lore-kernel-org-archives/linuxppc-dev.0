Return-Path: <silicom@163.com>
Received: from m13-130.163.com (m13-130.163.com [220.181.13.130])
	by ozlabs.org (Postfix) with SMTP id 30A99DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 15:22:57 +1000 (EST)
Date: Fri, 13 Jul 2007 13:22:54 +0800 (CST)
From: silicom <silicom@163.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <165516780.1952051184304174471.JavaMail.coremail@bj163app130.163.com>
Subject: can anyone help me to test my ac97 driver
MIME-Version: 1.0
Content-Type: multipart/Alternative;
	boundary="----=_Part_199439_1166067786.1184304174470"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_199439_1166067786.1184304174470
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 Hi
    I have a simple oss ac97 playback driver for xilinx ml403 and linux2.6.17 kernel,but when I test it with a *.wav file with sample rate 44.1k, there is much noisy, and I want to know whether there's problem with my ml403 board or ac97 driver,could anyone be kind to help me test it on your board or point out my problem?
 
thanks
below is my code "xilinx_ac97_adapter.c"
#include <linux/module.h>
#include <linux/version.h>
#include <linux/string.h>
#include <linux/ctype.h>
#include <linux/ioport.h>
#include <linux/sched.h>
#include <linux/delay.h>
#include <linux/sound.h>
#include <linux/slab.h>
#include <linux/soundcard.h>
#include <asm/io.h>
#include <asm/dma.h>
#include <linux/init.h>
#include <linux/poll.h>
#include <linux/spinlock.h>
#include <linux/smp_lock.h>
#include <linux/sound.h>
#include <linux/ac97_codec.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/signal.h>
//#include <linux/wrapper.h>
#include <asm/uaccess.h>
#include <asm/hardirq.h>
#include "xparameters.h"
#include "xac97_l.h"
#include "xio.h"
#define XILINX_AC97
#define DRIVER_VERSION "1.00a"
#define AC97_BASEADDR XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR
#define AC97_HIGHADDR XPAR_OPB_AC97_CONTROLLER_REF_0_HIGHADDR
/* AC97 codec initialisation. */
static struct ac97_codec *xilinx_ac97_codec = NULL;
static int dev_audio = -1;
#define BUFFER_SIZE 32768
#define XILINX_AC97_PLAYBACK_INTERRUPT 7
struct xilinx_ac97_state {
    struct semaphore    open_sem;     /* Device access */
    struct semaphore    sem;             /* File access */
    spinlock_t        lock;        /* State */
    spinlock_t        ac97_lock;
    struct ac97_codec    *ac97;
    char            *buffer;
    int            multichannel;
    int            dsp;         /* OSS handle */
    int                     trigger;    /* mmap I/O trigger */
    int            halfFull;
    //    struct forte_channel    play;
    //    struct forte_channel    rec;
};
static struct xilinx_ac97_state *state;
static int halfEmpty;
static DECLARE_WAIT_QUEUE_HEAD(ac97_queue);
static int emptyTime;
static u16 xilinx_ac97_get(struct ac97_codec *dev, u8 reg);
static void xilinx_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);
static void xilinx_ac97_codec_wait(struct ac97_codec *dev);
static irqreturn_t xilinx_ac97_interrupt(int irq, void * dev_id, struct pt_regs *regs)
{
    disable_irq(XILINX_AC97_PLAYBACK_INTERRUPT);
    halfEmpty = 1;
    wake_up_interruptible(&ac97_queue);
    return IRQ_HANDLED;  
}
static u16 xilinx_ac97_get(struct ac97_codec *dev, u8 reg)
{
        return XAC97_ReadReg((u32)dev->private_data, reg);
}
static void xilinx_ac97_set(struct ac97_codec *dev, u8 reg, u16 data) {
        XAC97_WriteReg((u32)dev->private_data, reg, data);
}
static void xilinx_ac97_codec_wait(struct ac97_codec *dev) {
        XAC97_AwaitCodecReady((u32)dev->private_data);
}
/* OSS /dev/mixer file operation methods */
static int xilinx_ac97_open_mixdev(struct inode *inode, struct file *file)
{
    int minor = MINOR(inode->i_rdev);
    if (xilinx_ac97_codec && xilinx_ac97_codec->dev_mixer == minor) {
        file->private_data = xilinx_ac97_codec;
        return 0;
    }
    return -ENODEV;
}
static int xilinx_ac97_ioctl_mixdev(struct inode *inode,
                    struct file *file,
                    unsigned int cmd, unsigned long arg)
{
    struct ac97_codec *codec = (struct ac97_codec *) file->private_data;
    return codec->mixer_ioctl(codec, cmd, arg);
}
static /*const */ struct file_operations xilinx_ac97_mixer_fops = {
    owner:THIS_MODULE,
    llseek:no_llseek,
    ioctl:xilinx_ac97_ioctl_mixdev,
    open:xilinx_ac97_open_mixdev,
};
static int xilinx_ac97_open(struct inode *inode, struct file *file)
{
    u32 baseAddress;
    if (!state)
        BUG();
    if (!xilinx_ac97_codec)
        BUG();
  
    baseAddress = (u32)xilinx_ac97_codec->private_data;
    if (file->f_flags & O_NONBLOCK) {
        if (down_trylock (&state->open_sem)) {
            printk ("%s: returning -EAGAIN\n", __FUNCTION__);
            return -EAGAIN;
        }
    }
    else {
        if (down_interruptible (&state->open_sem)) {
            printk ("%s: returning -ERESTARTSYS\n", __FUNCTION__);
            return -ERESTARTSYS;
        }
    }
    file->private_data = state;
    printk ("%s: dsp opened by %d\n", __FUNCTION__, current->pid);
    state->buffer = (char *)kmalloc(BUFFER_SIZE, GFP_KERNEL);
    /** Reset AC97 **/                     //added by myself
    XAC97_WriteReg(baseAddress, AC97_Reset, 0);
    XAC97_Delay(1000);
  
    /** Wait for the ready signal **/
    XAC97_AwaitCodecReady(baseAddress);
    XAC97_WriteReg(baseAddress, AC97_PCM_DAC_Rate0, AC97_PCM_RATE_48000_HZ);
    XAC97_WriteReg(baseAddress, AC97_PCM_DAC_Rate1, AC97_PCM_RATE_48000_HZ);
    /** Clear FIFOs **/
    XAC97_ClearFifos(baseAddress);      
    XAC97_WriteReg(baseAddress, AC97_GeneralPurpose, 0x0000);
    XAC97_WriteReg(baseAddress, AC97_SerialConfig, 0x7000);
    /** Enable VRA Mode **/
    XAC97_WriteReg(baseAddress, AC97_ExtendedAudioStat, AC97_EXTENDED_AUDIO_CONTROL_VRA);
  
    if (file->f_mode & FMODE_WRITE) {
        printk(KERN_INFO "setting volume\n");
        /** Play Volume Settings **/
        XAC97_WriteReg(baseAddress, AC97_MasterVol, AC97_VOL_MAX);
        XAC97_WriteReg(baseAddress, AC97_AuxOutVol, AC97_VOL_MAX);
        XAC97_WriteReg(baseAddress, AC97_MasterVolMono, AC97_VOL_MAX);
        XAC97_WriteReg(baseAddress, AC97_PCBeepVol, AC97_VOL_MAX);
        XAC97_WriteReg(baseAddress, AC97_PCMOutVol, AC97_VOL_MAX);
         }
    //firstly disable interrupt
    disable_irq(XILINX_AC97_PLAYBACK_INTERRUPT);
    if(request_irq(XILINX_AC97_PLAYBACK_INTERRUPT,xilinx_ac97_interrupt,SA_INTERRUPT,"ac97",NULL))
    {
        printk(KERN_ALERT "cannot register interrupt handler\n");
    }  
    return 0;
}
static ssize_t
xilinx_ac97_write (struct file *file, const char *buffer, size_t bytes,
         loff_t *ppos)
{
    struct xilinx_ac97_state *state;
    unsigned int i = 0;// sz = 0;
    u32 baseAddress;
    char* sound_ptr;
    size_t words;
    ssize_t ret;
    int j;
     if (!access_ok (VERIFY_READ, buffer, bytes))
         return -EFAULT;
    state = (struct xilinx_ac97_state *) file->private_data;
    if (!state)
        BUG();
    if (!xilinx_ac97_codec)
        BUG();
    if (down_interruptible(&state->sem))
        return -ERESTARTSYS;
    baseAddress = (u32)xilinx_ac97_codec->private_data;
    size_t buffer_size =(size_t)BUFFER_SIZE;
    size_t tmp = bytes;
    bytes = min(tmp,buffer_size);
    if(XAC97_isInFIFOEmpty(baseAddress))
    emptyTime++;//there's some time when playback FIFO is empty,I don't know how to fix it
    if (copy_from_user(state->buffer, buffer, bytes)) {
        ret = -EFAULT;
        goto out;
    }
    words = bytes >> 1;
    sound_ptr = (char *)state->buffer;
    i = 0;
    while(i < words) {
        j = *sound_ptr;
        sound_ptr++;
        j |= (*sound_ptr)<<8;
        if(!XAC97_isInFIFOFull(baseAddress))
            XAC97_WriteFifo(baseAddress, j);
        else
        {
            halfEmpty = 0;
            enable_irq(XILINX_AC97_PLAYBACK_INTERRUPT);
            wait_event_interruptible(ac97_queue,halfEmpty != 0);
            XAC97_WriteFifo(baseAddress,j);
        }
        sound_ptr++;
        i++;
        j = 0;
    }
    ret = i << 1;
 out:
    up(&state->sem);
    return ret;
}
  
static ssize_t
xilinx_ac97_read (struct file *file, const char *buffer, size_t bytes,
         loff_t *ppos)
{
    struct xilinx_ac97_state *state;
    unsigned int i = 0;// sz = 0;
    u32 baseAddress;
    u32* sound_ptr;
    size_t words;
    if (ppos != &file->f_pos)
        return -ESPIPE;
    if (!access_ok (VERIFY_WRITE, buffer, bytes))
        return -EFAULT;
    state = (struct xilinx_ac97_state *) file->private_data;
    if (!state)
        BUG();
    if (!xilinx_ac97_codec)
        BUG();
    baseAddress = (u32)xilinx_ac97_codec->private_data;
    // Check if already opened for read?
    // Compute the number of words to transfer.
    words = bytes >> 2;
    sound_ptr = (u32*)buffer;
    i = 0;
    while(i < words && !XAC97_isOutFIFOEmpty(baseAddress)) {
        *sound_ptr = XAC97_mGetOutFifoData(baseAddress);
        sound_ptr++;
        i++;
    }
    // Return the number of bytes transferred.
    return i << 2;
}
         
static int
xilinx_ac97_release (struct inode *inode, struct file *file)
{
    u32 baseAddress;
    kfree(state->buffer);
    baseAddress = (u32)xilinx_ac97_codec->private_data;
    XAC97_ClearFifos(baseAddress);      
    XAC97_SoftReset(baseAddress);
    free_irq(XILINX_AC97_PLAYBACK_INTERRUPT,NULL);
    up (&state->open_sem);
    printk(KERN_ALERT "Empyt time is %d\n",emptyTime);
    emptyTime = 0;
    return 0;
}
static int
xilinx_ac97_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
         unsigned long arg)
{
    int ival=0, rd, wr;//ret, count, rval=0;
    struct xilinx_ac97_state *state;
    u32 baseAddress = (u32)xilinx_ac97_codec->private_data;
    state = (struct xilinx_ac97_state *)file->private_data;  
  
    if (file->f_mode & FMODE_WRITE)
        wr = 1;
    else
        wr = 0;
    if (file->f_mode & FMODE_READ)
        rd = 1;
    else
        rd = 0;
    switch(cmd){
    default:break;
    }
    return -EINVAL;
}
  
static /*const */ struct file_operations xilinx_ac97_audio_fops = {
    owner:THIS_MODULE,
    llseek:no_llseek,
    read:xilinx_ac97_read,
    write:xilinx_ac97_write,
    //    poll:xilinx_ac97_poll,
    ioctl:xilinx_ac97_ioctl,
    //    mmap:xilinx_ac97_mmap,
    open:xilinx_ac97_open,
    release:xilinx_ac97_release,
};
MODULE_AUTHOR("Xilinx");
MODULE_DESCRIPTION("Xilinx AC97 driver");
MODULE_LICENSE("GPL");
static int __init xilinx_ac97_init_module(void)
{
    struct ac97_codec *codec;
        u32 baseAddress;
    printk(KERN_INFO "Xilinx AC97 Audio, version "
           DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
        baseAddress = (u32)ioremap(AC97_BASEADDR,AC97_HIGHADDR-AC97_BASEADDR);
        printk(KERN_INFO "XAC97_HardReset\n");
    XAC97_HardReset(baseAddress);
        if ((codec = ac97_alloc_codec()) == NULL)
                return -ENOMEM;
        codec->private_data = (void *)baseAddress;
        codec->id = 0;
        codec->codec_read = xilinx_ac97_get;
        codec->codec_write = xilinx_ac97_set;
        codec->codec_wait = xilinx_ac97_codec_wait;
    if (!ac97_probe_codec(codec)) {
                printk(KERN_ERR "Failed to init Xilinx AC97");
                kfree(codec);
                return -ENODEV;    /* it didn't work */
        }
        XAC97_InitAudio((u32)codec->private_data,0);
    if ((codec->dev_mixer = register_sound_mixer(&xilinx_ac97_mixer_fops, -1)) < 0) {
        printk(KERN_ERR "xilinx_ac97_audio: couldn't register mixer!\n");
        kfree(codec);
        return -ENODEV;
    }
    if ((dev_audio = register_sound_dsp(&xilinx_ac97_audio_fops, -1)) < 0) {
        printk(KERN_ERR "xilinx_ac97_audio: couldn't register DSP device!\n");
        unregister_sound_mixer(xilinx_ac97_codec->dev_mixer);
        kfree(xilinx_ac97_codec);
        return -ENODEV;
    }
    xilinx_ac97_codec = codec;
    state = (struct xilinx_ac97_state *) kmalloc(sizeof(struct xilinx_ac97_state), GFP_KERNEL);
    init_MUTEX(&state->open_sem);
    init_MUTEX(&state->sem);
    return 0;
}
static void __exit xilinx_ac97_cleanup_module(void)
{
    unregister_sound_mixer(xilinx_ac97_codec->dev_mixer);
    ac97_release_codec(xilinx_ac97_codec);
    xilinx_ac97_codec = NULL;
    unregister_sound_dsp(dev_audio);
    dev_audio = -1;
}
module_init(xilinx_ac97_init_module);
module_exit(xilinx_ac97_cleanup_module);
/*
Local Variables:
c-basic-offset: 8
End:
*/
below is the test file "test_oss.c"
#include <fcntl.h>
#include <stdlib.h>
#include <linux/soundcard.h>
#include <sys/ioctl.h>
#define BUFFER_SIZE 1024
static int audio_fd;
void init_audio_device()
{
    int fmts;
      int init_channels;
      int speed;
      if ( (audio_fd = open("/dev/dsp", O_WRONLY)) == -1)
    {
            perror("open error\n");
            printf("soundcard open error");
            exit(1);
      }
    printf("successfully init soundcard\n\n");
}
int audio_close(void)
{
     if (audio_fd)
    {
        close(audio_fd);
             printf("the device has been closed!\n");
      }    
      return 0;
}
int audio_play(char *buf, int len)
{
    int temp;
    temp = write(audio_fd, buf, len);
    return temp;
}
int main()
{  
    init_audio_device();
    int fd = open("/root/********.wav",O_RDONLY);
    int len = 0;
    char buffer[BUFFER_SIZE];
    int i=0;
    char tempt;
    while(1)
    {
        len = read(fd,buffer,sizeof(buffer));
        if(len == 0)
        {
        printf("reach the end\n");
        break;
        }
        audio_play(buffer,len); 
    }
    audio_close();
    close(fd);
    return 0;
}
 
in the write process,firstly check whether playback FIFO is full,if not, then send PCM data to FIFO;else sleep until FIFO half-empty interrupt,in the interrupt handler,wake up write process,then go on send data to playback FIFO until full. 
  
------=_Part_199439_1166067786.1184304174470
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;</div><div>Hi<br>&nbsp;&nbsp;&nbsp; I have a simple oss ac97 pla=
yback driver for xilinx ml403 and linux2.6.17 kernel,but when I test it wit=
h a *.wav file with sample rate 44.1k, there is much noisy, and I want to k=
now whether there's problem with my ml403 board or ac97 driver,could anyone=
 be kind to help me test it on your board or point out my problem?<br>&nbsp=
;<br>thanks<br>below is my code "xilinx_ac97_adapter.c"<br>#include &lt;lin=
ux/module.h&gt;<br>#include &lt;linux/version.h&gt;<br>#include &lt;linux/s=
tring.h&gt;<br>#include &lt;linux/ctype.h&gt;<br>#include &lt;linux/ioport.=
h&gt;<br>#include &lt;linux/sched.h&gt;<br>#include &lt;linux/delay.h&gt;<b=
r>#include &lt;linux/sound.h&gt;<br>#include &lt;linux/slab.h&gt;<br>#inclu=
de &lt;linux/soundcard.h&gt;<br>#include &lt;asm/io.h&gt;<br>#include &lt;a=
sm/dma.h&gt;<br>#include &lt;linux/init.h&gt;<br>#include &lt;linux/poll.h&=
gt;<br>#include &lt;linux/spinlock.h&gt;<br>#include &lt;linux/smp_lock.h&g=
t;<br>#include &lt;linux/sound.h&gt;<br>#include &lt;linux/ac97_codec.h&gt;=
<br>#include &lt;linux/interrupt.h&gt;<br>#include &lt;linux/irq.h&gt;<br>#=
include &lt;linux/signal.h&gt;<br>//#include &lt;linux/wrapper.h&gt;<br>#in=
clude &lt;asm/uaccess.h&gt;<br>#include &lt;asm/hardirq.h&gt;<br>#include "=
xparameters.h"<br>#include "xac97_l.h"<br>#include "xio.h"<br>#define XILIN=
X_AC97<br><br>#define DRIVER_VERSION "1.00a"<br>#define AC97_BASEADDR XPAR_=
OPB_AC97_CONTROLLER_REF_0_BASEADDR<br>#define AC97_HIGHADDR XPAR_OPB_AC97_C=
ONTROLLER_REF_0_HIGHADDR<br>/* AC97 codec initialisation. */<br><br>static =
struct ac97_codec *xilinx_ac97_codec =3D NULL;<br>static int dev_audio =3D =
-1;<br>#define BUFFER_SIZE 32768<br>#define XILINX_AC97_PLAYBACK_INTERRUPT =
7<br><br>struct xilinx_ac97_state {<br>&nbsp;&nbsp;&nbsp; struct semaphore&=
nbsp;&nbsp;&nbsp; open_sem;&nbsp;&nbsp;&nbsp;&nbsp; /* Device access */<br>=
&nbsp;&nbsp;&nbsp; struct semaphore&nbsp;&nbsp;&nbsp; sem;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* File access */<b=
r>&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l=
ock;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* State */<br><br>&nbsp;&nb=
sp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ac97_lock;<b=
r>&nbsp;&nbsp;&nbsp; struct ac97_codec&nbsp;&nbsp;&nbsp; *ac97;<br>&nbsp;&n=
bsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; *buffer;<br>&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multichannel;<br>&nbsp;&nbsp;&nbsp; int&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* OSS handle */<br>&nbsp;&nbsp;&=
nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger;&nbsp;&nbsp;=
&nbsp; /* mmap I/O trigger */<br>&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; halfFull;<br>&nbsp;&nbsp;&nb=
sp; //&nbsp;&nbsp;&nbsp; struct forte_channel&nbsp;&nbsp;&nbsp; play;<br>&n=
bsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; struct forte_channel&nbsp;&nbsp;&nbsp=
; rec;<br>};<br>static struct xilinx_ac97_state *state;<br>static int halfE=
mpty;<br>static DECLARE_WAIT_QUEUE_HEAD(ac97_queue);<br>static int emptyTim=
e;<br>static u16 xilinx_ac97_get(struct ac97_codec *dev, u8 reg);<br>static=
 void xilinx_ac97_set(struct ac97_codec *dev, u8 reg, u16 data);<br>static =
void xilinx_ac97_codec_wait(struct ac97_codec *dev);<br>static irqreturn_t =
xilinx_ac97_interrupt(int irq, void * dev_id, struct pt_regs *regs)<br>{<br=
>&nbsp;&nbsp;&nbsp; disable_irq(XILINX_AC97_PLAYBACK_INTERRUPT);<br>&nbsp;&=
nbsp;&nbsp; halfEmpty =3D 1;<br>&nbsp;&nbsp;&nbsp; wake_up_interruptible(&a=
mp;ac97_queue);<br>&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;&nbsp;&nbsp; <br>}=
<br>static u16 xilinx_ac97_get(struct ac97_codec *dev, u8 reg)<br>{<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return XAC97_ReadReg((u32)dev-&gt;pr=
ivate_data, reg);<br>}<br><br>static void xilinx_ac97_set(struct ac97_codec=
 *dev, u8 reg, u16 data) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XA=
C97_WriteReg((u32)dev-&gt;private_data, reg, data);<br>}<br><br>static void=
 xilinx_ac97_codec_wait(struct ac97_codec *dev) {<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; XAC97_AwaitCodecReady((u32)dev-&gt;private_data);<br>}=
<br><br>/* OSS /dev/mixer file operation methods */<br><br>static int xilin=
x_ac97_open_mixdev(struct inode *inode, struct file *file)<br>{<br>&nbsp;&n=
bsp;&nbsp; int minor =3D MINOR(inode-&gt;i_rdev);<br>&nbsp;&nbsp;&nbsp; if =
(xilinx_ac97_codec &amp;&amp; xilinx_ac97_codec-&gt;dev_mixer =3D=3D minor)=
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data =3D =
xilinx_ac97_codec;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<=
br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; return -ENODEV;<br>}<br><br>s=
tatic int xilinx_ac97_ioctl_mixdev(struct inode *inode,<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct file *file,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int cmd, unsigned long arg)<br>{<br>&nbsp;&nbsp;&nbsp; =
struct ac97_codec *codec =3D (struct ac97_codec *) file-&gt;private_data;<b=
r>&nbsp;&nbsp;&nbsp; return codec-&gt;mixer_ioctl(codec, cmd, arg);<br>}<br=
><br>static /*const */ struct file_operations xilinx_ac97_mixer_fops =3D {<=
br>&nbsp;&nbsp;&nbsp; owner:THIS_MODULE,<br>&nbsp;&nbsp;&nbsp; llseek:no_ll=
seek,<br>&nbsp;&nbsp;&nbsp; ioctl:xilinx_ac97_ioctl_mixdev,<br>&nbsp;&nbsp;=
&nbsp; open:xilinx_ac97_open_mixdev,<br>};<br><br>static int xilinx_ac97_op=
en(struct inode *inode, struct file *file)<br>{<br>&nbsp;&nbsp;&nbsp; u32 b=
aseAddress;<br>&nbsp;&nbsp;&nbsp; if (!state)<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; BUG();<br><br>&nbsp;&nbsp;&nbsp; if (!xilinx_ac97_codec)<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>&nbsp;&nbsp; <br>&nb=
sp;&nbsp;&nbsp; baseAddress =3D (u32)xilinx_ac97_codec-&gt;private_data;<br=
>&nbsp;&nbsp;&nbsp; if (file-&gt;f_flags &amp; O_NONBLOCK) {<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (down_trylock (&amp;state-&gt;open_sem))=
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr=
intk ("%s: returning -EAGAIN\n", __FUNCTION__);<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EAGAIN;<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbs=
p; else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (down_interrupti=
ble (&amp;state-&gt;open_sem)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; printk ("%s: returning -ERESTARTSYS\n", __FUNCT=
ION__);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -ERESTARTSYS;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>=
&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; file-&gt;private_data =3D st=
ate;<br>&nbsp;&nbsp;&nbsp; printk ("%s: dsp opened by %d\n", __FUNCTION__, =
current-&gt;pid);<br>&nbsp;&nbsp;&nbsp; state-&gt;buffer =3D (char *)kmallo=
c(BUFFER_SIZE, GFP_KERNEL);<br>&nbsp;&nbsp;&nbsp; /** Reset AC97 **/&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //added by myself<br>&nbsp;&nbsp;&nb=
sp; XAC97_WriteReg(baseAddress, AC97_Reset, 0);<br>&nbsp;&nbsp;&nbsp; XAC97=
_Delay(1000);<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; /** Wait for the ready=
 signal **/<br>&nbsp;&nbsp;&nbsp; XAC97_AwaitCodecReady(baseAddress);<br>&n=
bsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC97_PCM_DAC_Rate0, AC97_PCM_R=
ATE_48000_HZ);<br>&nbsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC97_PCM_D=
AC_Rate1, AC97_PCM_RATE_48000_HZ);<br>&nbsp;&nbsp;&nbsp; /** Clear FIFOs **=
/<br>&nbsp;&nbsp;&nbsp; XAC97_ClearFifos(baseAddress);&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC97_Gen=
eralPurpose, 0x0000);<br>&nbsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC9=
7_SerialConfig, 0x7000);<br>&nbsp;&nbsp;&nbsp; /** Enable VRA Mode **/<br>&=
nbsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC97_ExtendedAudioStat, AC97_=
EXTENDED_AUDIO_CONTROL_VRA);<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (fil=
e-&gt;f_mode &amp; FMODE_WRITE) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; printk(KERN_INFO "setting volume\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /** Play Volume Settings **/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC97_MasterVol, AC97_VOL_MAX);<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC9=
7_AuxOutVol, AC97_VOL_MAX);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; X=
AC97_WriteReg(baseAddress, AC97_MasterVolMono, AC97_VOL_MAX);<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_WriteReg(baseAddress, AC97_PCBeepVol=
, AC97_VOL_MAX);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_WriteR=
eg(baseAddress, AC97_PCMOutVol, AC97_VOL_MAX);<br><br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; //firstly disable inter=
rupt<br>&nbsp;&nbsp;&nbsp; disable_irq(XILINX_AC97_PLAYBACK_INTERRUPT);<br>=
&nbsp;&nbsp;&nbsp; if(request_irq(XILINX_AC97_PLAYBACK_INTERRUPT,xilinx_ac9=
7_interrupt,SA_INTERRUPT,"ac97",NULL))<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ALERT "cannot register interr=
upt handler\n");<br>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;=
 return 0;<br>}<br><br>static ssize_t<br>xilinx_ac97_write (struct file *fi=
le, const char *buffer, size_t bytes,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; loff_t *ppos)<br>{<br>&nbsp;&nbsp;&nbsp; struct xilinx_ac97_=
state *state;<br>&nbsp;&nbsp;&nbsp; unsigned int i =3D 0;// sz =3D 0;<br>&n=
bsp;&nbsp;&nbsp; u32 baseAddress;<br>&nbsp;&nbsp;&nbsp; char* sound_ptr;<br=
>&nbsp;&nbsp;&nbsp; size_t words;<br>&nbsp;&nbsp;&nbsp; ssize_t ret;<br>&nb=
sp;&nbsp;&nbsp; int j;<br>&nbsp;&nbsp;&nbsp;&nbsp; if (!access_ok (VERIFY_R=
EAD, buffer, bytes))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EFAULT;<br>&nbsp;&nbsp;&nbsp; state =3D (struct xilinx_ac97_state *) =
file-&gt;private_data;<br><br>&nbsp;&nbsp;&nbsp; if (!state)<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br><br>&nbsp;&nbsp;&nbsp; if (!xilin=
x_ac97_codec)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br><br>&=
nbsp;&nbsp;&nbsp; if (down_interruptible(&amp;state-&gt;sem))<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ERESTARTSYS;<br><br>&nbsp;&nbsp;&n=
bsp; baseAddress =3D (u32)xilinx_ac97_codec-&gt;private_data;<br><br><br>&n=
bsp;&nbsp;&nbsp; size_t buffer_size =3D(size_t)BUFFER_SIZE;<br>&nbsp;&nbsp;=
&nbsp; size_t tmp =3D bytes;<br>&nbsp;&nbsp;&nbsp; bytes =3D min(tmp,buffer=
_size);<br><br>&nbsp;&nbsp;&nbsp; if(XAC97_isInFIFOEmpty(baseAddress))<br>&=
nbsp;&nbsp;&nbsp; emptyTime++;//there's some time when playback FIFO is emp=
ty,I don't know how to fix it<br>&nbsp;&nbsp;&nbsp; if (copy_from_user(stat=
e-&gt;buffer, buffer, bytes)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ret =3D -EFAULT;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;=
<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; words =3D bytes &gt;&gt;=
 1;<br>&nbsp;&nbsp;&nbsp; sound_ptr =3D (char *)state-&gt;buffer;<br>&nbsp;=
&nbsp;&nbsp; i =3D 0;<br>&nbsp;&nbsp;&nbsp; while(i &lt; words) {<br><br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D *sound_ptr;<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sound_ptr++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; j |=3D (*sound_ptr)&lt;&lt;8;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if(!XAC97_isInFIFOFull(baseAddress))<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_WriteFifo(baseAddress,=
 j);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; halfEmpty =3D 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_irq(XILINX_AC97_PLAYBACK_INTERRU=
PT);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wait_event_interruptible(ac97_queue,halfEmpty !=3D 0);<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_WriteFifo(baseAddre=
ss,j);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sound_ptr++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; i++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D 0;<br>&n=
bsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; ret =3D i &lt;&lt; 1;<br><br><=
br>&nbsp;out:<br>&nbsp;&nbsp;&nbsp; up(&amp;state-&gt;sem);<br><br>&nbsp;&n=
bsp;&nbsp; return ret;<br>}<br>&nbsp;&nbsp; <br>static ssize_t<br>xilinx_ac=
97_read (struct file *file, const char *buffer, size_t bytes,<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loff_t *ppos)<br>{<br>&nbsp;&nbsp;&n=
bsp; struct xilinx_ac97_state *state;<br>&nbsp;&nbsp;&nbsp; unsigned int i =
=3D 0;// sz =3D 0;<br>&nbsp;&nbsp;&nbsp; u32 baseAddress;<br>&nbsp;&nbsp;&n=
bsp; u32* sound_ptr;<br>&nbsp;&nbsp;&nbsp; size_t words;<br><br>&nbsp;&nbsp=
;&nbsp; if (ppos !=3D &amp;file-&gt;f_pos)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -ESPIPE;<br><br>&nbsp;&nbsp;&nbsp; if (!access_ok (VER=
IFY_WRITE, buffer, bytes))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EFAULT;<br><br>&nbsp;&nbsp;&nbsp; state =3D (struct xilinx_ac97_state=
 *) file-&gt;private_data;<br><br>&nbsp;&nbsp;&nbsp; if (!state)<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br><br>&nbsp;&nbsp;&nbsp; if (!x=
ilinx_ac97_codec)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br><=
br>&nbsp;&nbsp;&nbsp; baseAddress =3D (u32)xilinx_ac97_codec-&gt;private_da=
ta;<br><br>&nbsp;&nbsp;&nbsp; // Check if already opened for read?<br><br>&=
nbsp;&nbsp;&nbsp; // Compute the number of words to transfer.<br>&nbsp;&nbs=
p;&nbsp; words =3D bytes &gt;&gt; 2;<br>&nbsp;&nbsp;&nbsp; sound_ptr =3D (u=
32*)buffer;<br>&nbsp;&nbsp;&nbsp; i =3D 0;<br>&nbsp;&nbsp;&nbsp; while(i &l=
t; words &amp;&amp; !XAC97_isOutFIFOEmpty(baseAddress)) {<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *sound_ptr =3D XAC97_mGetOutFifoData(baseAddre=
ss);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sound_ptr++;<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbs=
p;&nbsp;&nbsp; // Return the number of bytes transferred.<br>&nbsp;&nbsp;&n=
bsp; return i &lt;&lt; 2;<br>}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <br>static int<br>xilinx_ac97_release (struct inode *inode, s=
truct file *file)<br>{<br>&nbsp;&nbsp;&nbsp; u32 baseAddress;<br><br>&nbsp;=
&nbsp;&nbsp; kfree(state-&gt;buffer);<br><br>&nbsp;&nbsp;&nbsp; baseAddress=
 =3D (u32)xilinx_ac97_codec-&gt;private_data;<br><br>&nbsp;&nbsp;&nbsp; XAC=
97_ClearFifos(baseAddress);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&=
nbsp;&nbsp; XAC97_SoftReset(baseAddress);<br>&nbsp;&nbsp;&nbsp; free_irq(XI=
LINX_AC97_PLAYBACK_INTERRUPT,NULL);<br><br>&nbsp;&nbsp;&nbsp; up (&amp;stat=
e-&gt;open_sem);<br>&nbsp;&nbsp;&nbsp; printk(KERN_ALERT "Empyt time is %d\=
n",emptyTime);<br>&nbsp;&nbsp;&nbsp; emptyTime =3D 0;<br>&nbsp;&nbsp;&nbsp;=
 return 0;<br>}<br><br>static int<br>xilinx_ac97_ioctl (struct inode *inode=
, struct file *file, unsigned int cmd,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; unsigned long arg)<br>{<br>&nbsp;&nbsp;&nbsp; int ival=3D0,=
 rd, wr;//ret, count, rval=3D0;<br>&nbsp;&nbsp;&nbsp; struct xilinx_ac97_st=
ate *state;<br>&nbsp;&nbsp;&nbsp; u32 baseAddress =3D (u32)xilinx_ac97_code=
c-&gt;private_data;<br><br>&nbsp;&nbsp;&nbsp; state =3D (struct xilinx_ac97=
_state *)file-&gt;private_data;&nbsp;&nbsp; <br>&nbsp;&nbsp; <br>&nbsp;&nbs=
p;&nbsp; if (file-&gt;f_mode &amp; FMODE_WRITE)<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; wr =3D 1;<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; wr =3D 0;<br><br>&nbsp;&nbsp;&nbsp; if (file-&gt=
;f_mode &amp; FMODE_READ)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rd =
=3D 1;<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; rd =3D 0;<br>&nbsp;&nbsp;&nbsp; switch(cmd){<br>&nbsp;&nbsp;&nbsp; def=
ault:break;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; return -EINVAL;<b=
r>}<br><br>&nbsp;&nbsp; <br>static /*const */ struct file_operations xilinx=
_ac97_audio_fops =3D {<br>&nbsp;&nbsp;&nbsp; owner:THIS_MODULE,<br>&nbsp;&n=
bsp;&nbsp; llseek:no_llseek,<br>&nbsp;&nbsp;&nbsp; read:xilinx_ac97_read,<b=
r>&nbsp;&nbsp;&nbsp; write:xilinx_ac97_write,<br>&nbsp;&nbsp;&nbsp; //&nbsp=
;&nbsp;&nbsp; poll:xilinx_ac97_poll,<br>&nbsp;&nbsp;&nbsp; ioctl:xilinx_ac9=
7_ioctl,<br>&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; mmap:xilinx_ac97_mmap,<=
br>&nbsp;&nbsp;&nbsp; open:xilinx_ac97_open,<br>&nbsp;&nbsp;&nbsp; release:=
xilinx_ac97_release,<br>};<br><br>MODULE_AUTHOR("Xilinx");<br>MODULE_DESCRI=
PTION("Xilinx AC97 driver");<br>MODULE_LICENSE("GPL");<br><br>static int __=
init xilinx_ac97_init_module(void)<br>{<br>&nbsp;&nbsp;&nbsp; struct ac97_c=
odec *codec;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 baseAddress;=
<br><br>&nbsp;&nbsp;&nbsp; printk(KERN_INFO "Xilinx AC97 Audio, version "<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_VERSI=
ON ", " __TIME__ " " __DATE__ "\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; baseAddress =3D (u32)ioremap(AC97_BASEADDR,AC97_HIGHADDR-AC97_BASEA=
DDR);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO "XAC97=
_HardReset\n");<br>&nbsp;&nbsp;&nbsp; XAC97_HardReset(baseAddress);<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((codec =3D ac97_alloc_codec()) =
=3D=3D NULL)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; codec-&gt;private_data =3D (void *)baseAddress;<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; codec-&gt;id =3D 0;<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; codec-&gt;codec_read =3D xilinx_ac97_get;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; codec-&gt;codec_write =3D xilinx_=
ac97_set;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; codec-&gt;codec_wai=
t =3D xilinx_ac97_codec_wait;<br>&nbsp;&nbsp;&nbsp; if (!ac97_probe_codec(c=
odec)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR "Failed to init Xilinx AC97");<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; kfree(codec);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;&nbsp;&n=
bsp;&nbsp; /* it didn't work */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_InitAudio((u32)cod=
ec-&gt;private_data,0);<br>&nbsp;&nbsp;&nbsp; if ((codec-&gt;dev_mixer =3D =
register_sound_mixer(&amp;xilinx_ac97_mixer_fops, -1)) &lt; 0) {<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR "xilinx_ac97_audio: cou=
ldn't register mixer!\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kf=
ree(codec);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<b=
r>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; if ((dev_audio =3D registe=
r_sound_dsp(&amp;xilinx_ac97_audio_fops, -1)) &lt; 0) {<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR "xilinx_ac97_audio: couldn't reg=
ister DSP device!\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unregi=
ster_sound_mixer(xilinx_ac97_codec-&gt;dev_mixer);<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(xilinx_ac97_codec);<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return -ENODEV;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nb=
sp;&nbsp; xilinx_ac97_codec =3D codec;<br><br>&nbsp;&nbsp;&nbsp; state =3D =
(struct xilinx_ac97_state *) kmalloc(sizeof(struct xilinx_ac97_state), GFP_=
KERNEL);<br>&nbsp;&nbsp;&nbsp; init_MUTEX(&amp;state-&gt;open_sem);<br>&nbs=
p;&nbsp;&nbsp; init_MUTEX(&amp;state-&gt;sem); <br>&nbsp;&nbsp;&nbsp; retur=
n 0;<br>}<br><br>static void __exit xilinx_ac97_cleanup_module(void)<br>{<b=
r><br>&nbsp;&nbsp;&nbsp; unregister_sound_mixer(xilinx_ac97_codec-&gt;dev_m=
ixer);<br>&nbsp;&nbsp;&nbsp; ac97_release_codec(xilinx_ac97_codec);<br>&nbs=
p;&nbsp;&nbsp; xilinx_ac97_codec =3D NULL;<br>&nbsp;&nbsp;&nbsp; unregister=
_sound_dsp(dev_audio);<br>&nbsp;&nbsp;&nbsp; dev_audio =3D -1;<br>}<br><br>=
module_init(xilinx_ac97_init_module);<br>module_exit(xilinx_ac97_cleanup_mo=
dule);<br>/*<br>Local Variables:<br>c-basic-offset: 8<br>End:<br>*/<br><br>=
below is the test file "test_oss.c"<br>#include &lt;fcntl.h&gt;<br>#include=
 &lt;stdlib.h&gt;<br>#include &lt;linux/soundcard.h&gt;<br>#include &lt;sys=
/ioctl.h&gt;<br><br>#define BUFFER_SIZE 1024<br>static int audio_fd;<br><br=
>void init_audio_device()<br>{<br>&nbsp;&nbsp;&nbsp; int fmts;<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int init_channels;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int speed;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( (audio_fd =3D open("/=
dev/dsp", O_WRONLY)) =3D=3D -1)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror("open error\n");<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print=
f("soundcard open error");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp=
;&nbsp;&nbsp; printf("successfully init soundcard\n\n");<br>}<br><br>int au=
dio_close(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp; if (audio_fd)<br>&nbsp;&nb=
sp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(audio_fd);<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 printf("the device has been closed!\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 }&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>=
}<br><br>int audio_play(char *buf, int len)<br>{<br>&nbsp;&nbsp;&nbsp; int =
temp;<br>&nbsp;&nbsp;&nbsp; temp =3D write(audio_fd, buf, len);<br>&nbsp;&n=
bsp;&nbsp; return temp;<br>}<br><br>int main()<br>{&nbsp;&nbsp; <br>&nbsp;&=
nbsp;&nbsp; init_audio_device();<br>&nbsp;&nbsp;&nbsp; int fd =3D open("/ro=
ot/********.wav",O_RDONLY);<br>&nbsp;&nbsp;&nbsp; int len =3D 0;<br>&nbsp;&=
nbsp;&nbsp; char buffer[BUFFER_SIZE];<br>&nbsp;&nbsp;&nbsp; int i=3D0;<br>&=
nbsp;&nbsp;&nbsp; char tempt;<br>&nbsp;&nbsp;&nbsp; while(1)<br>&nbsp;&nbsp=
;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D read(fd,buf=
fer,sizeof(buffer));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(len =
=3D=3D 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("reach the end\n");<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; audio_play(buffer,len)=
;&nbsp; <br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; audio_close();<br>&n=
bsp;&nbsp;&nbsp; close(fd);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br>&nbsp;<=
br>in the write process,firstly check whether playback FIFO is full,if not,=
 then send PCM data to FIFO;else sleep until FIFO half-empty interrupt,in t=
he interrupt handler,wake up write process,then go on send data to playback=
 FIFO until full.&nbsp; <br></div><div>&nbsp;</div><div>&nbsp;</div><br><!-=
- footer --><br><hr>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/xyq_07summer.htm?from=3D163_NO=
8" target=3D"_blank"><span style=3D"text-decoration:underline; color:blue">=
iPod=A1=A2=CD=F2 =B5=E3 =BE=DE =B6=EE =B5=E3 =BF=A8=A1=A2=BD=B1 =D1=A7 =BD=
=F0=A1=AD=A1=AD=BA=A3 =C1=BF =BD=B1 =C6=B7=A3=AC=CF=EB =C4=C3 =BE=CD =C4=C3=
=A3=A1</span> </a>
------=_Part_199439_1166067786.1184304174470--
