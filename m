Subject: Re: Notifying a user space application
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Christian =?ISO-8859-1?Q?Tr=F6ster?= <please.see.sig@gmx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200407010029.05546.please.see.sig@gmx.de>
References: <200407010029.05546.please.see.sig@gmx.de>
Content-Type: multipart/mixed; boundary="=-fnsYhDSdmmq9NarQ+gKY"
Message-Id: <1088662847.6010.2.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 08:20:47 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-fnsYhDSdmmq9NarQ+gKY
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-01 at 00:29, Christian Tr=F6ster wrote:
>=20
> Hi!
>=20
> I'd like to notify a user space application if an interrupt occurs. I
> had no
> problems to install a custom signal handler but I am not sure what's
> the best
> way to notify the application.

Mostly a stripped-down ppdev.

--=20
Stefan Nickl
Kontron Modular Computers


--=-fnsYhDSdmmq9NarQ+gKY
Content-Disposition: attachment; filename=waitforint.c
Content-Type: text/x-c; name=waitforint.c; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

/*
 * This driver allows user-space programs to wait for interrupts
 */

#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/ioctl.h>
#include <linux/ctype.h>
#include <linux/poll.h>
#include <linux/malloc.h>
#include <linux/interrupt.h>
#include <asm/io.h>

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
	#include <linux/devfs_fs_kernel.h>
#else
	#include "sysdep.h"
#endif

#include "waitforint.h"

#define WFI_VERSION "WaitForInt: user-space interrupt waiting"
#define CHRDEV "waitforint"
#define DEFAULT_MAJOR	245	/* from range for local/experimental use */
#define DEFAULT_IRQ	7	/* usually used for the first printer port */

static int major = -1;
MODULE_PARM(major, "i");

/* The interrupt line is undefined by default. "wfi_irq" is as above */
static int irq = -1;
static int wfi_irq = -1;
MODULE_PARM(irq, "i");

MODULE_AUTHOR ("Stefan Nickl");

/* ugly hack, throw out as soon as 2.2 compatibility is no longer required */
#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0))
#define DEVFS_FL_NONE           0x000
typedef struct devfs_entry * devfs_handle_t;
static inline int devfs_register_chrdev (unsigned int major, const char *name,
                                         struct file_operations *fops)
{
    return register_chrdev (major, name, fops);
}
static inline devfs_handle_t devfs_register (devfs_handle_t dir,
                                             const char *name,
                                             unsigned int flags,
                                             unsigned int major,
                                             unsigned int minor,
                                             umode_t mode,
                                             void *ops, void *info)
{
    return NULL;
}
static inline void devfs_unregister (devfs_handle_t de)
{
    return;
}
static inline int devfs_unregister_chrdev (unsigned int major,const char *name)
{
    return unregister_chrdev (major, name);
}
#endif


struct wfi_struct {
        wait_queue_head_t irq_wait;
        atomic_t irqc;
};
/* all entries of wfi_global have to be handled atomically! */
static struct wfi_struct wfi_global;


/*
 * This is an example for the parallel port, in real life
 * the user app should do this directly after ioperm(2)
 */
static inline void wfi_enable_irq ()
{
#ifdef DEBUG_PP
	/* Initialize the control register, turning on interrupts. */
	/* outb (SP_CR_IRQ | SP_CR_SELECT | SP_CR_INIT, 0x378 + SP_CONTROL); */
	outb (0x1c, 0x37a);
#endif
}
static inline void wfi_disable_irq ()
{
#ifdef DEBUG_PP
	/* outb(0x0, 0x378 + SP_CONTROL); */  /* disable the interrupt */
	outb(0x0, 0x37a);
#endif
}
static inline void wfi_clear_irq ()
{
}

/*
 * The interrupt handler.
 */
void wfi_interrupt(int irq, void *private, struct pt_regs *regs)
{
        struct wfi_struct * wfi = (struct wfi_struct *) private;

        atomic_inc (&wfi->irqc);
        wake_up_interruptible (&wfi->irq_wait);
}


/*
 * Open the device. It is single-open.
 */
int wfi_s_count = 0;
spinlock_t wfi_s_lock;

static int wfi_open (struct inode *inode, struct file *file)
{
        file->private_data = &wfi_global;

	spin_lock(&wfi_s_lock);
	if (wfi_s_count) {
        	spin_unlock(&wfi_s_lock);
        	return -EBUSY; /* already open */
	}
	wfi_s_count++;
	spin_unlock(&wfi_s_lock);

	return 0;
}

static int wfi_release (struct inode * inode, struct file * file)
{
	wfi_s_count--; /* release the device */
        return 0;
}

static int wfi_ioctl(struct inode *inode, struct file *file,
                    unsigned int cmd, unsigned long arg)
{
        unsigned int minor = MINOR(inode->i_rdev);
        struct wfi_struct *wfi = file->private_data;

        switch (cmd) {
                int ret;

        case WFICLRIRQ:
                ret = atomic_read (&wfi->irqc);
                if (copy_to_user ((int *) arg, &ret, sizeof (ret)))
                        return -EFAULT;
                atomic_sub (ret, &wfi->irqc);
		wfi_clear_irq();
                return 0;
       default:
                printk (KERN_DEBUG CHRDEV "%x: What? (cmd=0x%x)\n", minor,
                        cmd);
                return -EINVAL;
        }

        /* Keep the compiler happy */
        return 0;
}

static unsigned int wfi_poll (struct file * file, poll_table * wait)
{
        struct wfi_struct *wfi = file->private_data;
        unsigned int mask = 0;

        poll_wait (file, &wfi->irq_wait, wait);
        if (atomic_read (&wfi->irqc))
                mask |= POLLIN | POLLRDNORM;

        return mask;
}

struct file_operations wfi_fops = {
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
        owner:          THIS_MODULE,
        llseek:         no_llseek,
#endif
        poll:           wfi_poll,
        ioctl:          wfi_ioctl,
        open:           wfi_open,
        release:        wfi_release,
};



static devfs_handle_t devfs_handle;

/*
 * Module initialization
 */

static int __init wfi_init(void)
{
	int result;

	wfi_irq = irq;

	/* If no IRQ was explicitly requested, pick a default */
	if (wfi_irq < 0)
		wfi_irq = DEFAULT_IRQ;

	if (major <= 0)
		major = DEFAULT_MAJOR;

	/* interrupt count and waiting processes are managed globally */
	atomic_set (&wfi_global.irqc, 0);
	init_waitqueue_head (&wfi_global.irq_wait);

	/* Request the IRQ */
    	result = request_irq(wfi_irq, wfi_interrupt,
				SA_INTERRUPT,"waitforint", &wfi_global);
    	if (result) {
       		printk(KERN_INFO "waitforint: can't assign irq %i\n", wfi_irq);
		wfi_irq = -1;
		return result;
	}

        /* Tell the hardware to generate interrupts */
        wfi_enable_irq ();

	/* Register character device */
	if (devfs_register_chrdev (major, CHRDEV, &wfi_fops)) {
    		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
			major);
		return -EIO;
	}

	devfs_handle = devfs_register (NULL, CHRDEV,
				DEVFS_FL_NONE, major, 0,
                              	S_IFCHR | S_IRUGO | S_IWUGO,
                               	&wfi_fops, NULL);

	printk (KERN_INFO WFI_VERSION " for irq %d\n", wfi_irq);
	return 0;
}

/* static void __exit wfi_cleanup(void) */
static void wfi_cleanup(void)
{
	/* Return the IRQ if we have one */
	if (wfi_irq >= 0) {
		wfi_disable_irq();
		free_irq(wfi_irq, &wfi_global);
	}

	devfs_unregister_chrdev (major, CHRDEV);
	devfs_unregister (devfs_handle);
}


module_init(wfi_init);
module_exit(wfi_cleanup);

EXPORT_NO_SYMBOLS;

--=-fnsYhDSdmmq9NarQ+gKY
Content-Disposition: attachment; filename=waitforint.h
Content-Type: text/x-c-header; name=waitforint.h; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

#define WFI_IOCTL        'w'

/* Clear (and return) interrupt count. */
#define WFICLRIRQ        _IOR(WFI_IOCTL, 0x93, int)

--=-fnsYhDSdmmq9NarQ+gKY
Content-Disposition: attachment; filename=waitforint_user.c
Content-Type: text/x-c; name=waitforint_user.c; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include "waitforint.h"


int wait_for_int(int fd);
int clear_int(int fd);

int main(){
	int fd;
	int c;

	fd = open("/dev/waitforint", O_RDONLY);
	if(fd < 0){
		perror("couldn't open waitforint device");
		exit(1);
	}

	while(1){
		c = wait_for_int(fd);
		printf("got int %d\n", c);
		sleep(1);
	}

	close(fd);

	return 0;
}

int clear_int(int fd) {
        int count;

        if( ioctl(fd, WFICLRIRQ, &count) < 0){
                perror("couldn't clear interrupt count");
                exit(5);
        }

        return count;
}

int wait_for_int(int fd){
        fd_set rfds;
        int retval;

        FD_ZERO(&rfds);
        FD_SET(fd, &rfds);

        /* wait forever for a read event on fd */
        retval = select(fd+1, &rfds, NULL, NULL, NULL);

        if(retval)
                return clear_int(fd);
        else{
                perror("error waiting for interrupt");
                exit(5);
        }
}


--=-fnsYhDSdmmq9NarQ+gKY--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
