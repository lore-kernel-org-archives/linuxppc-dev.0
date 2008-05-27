Return-Path: <john.bonesio@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E3DABDE351
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 02:42:27 +1000 (EST)
Subject: Re: Still struggling with Xilinx GPIO...
From: John Bonesio <john.bonesio@xilinx.com>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <0b5701c8bf47$49219520$ad289e86@LPSC0173W>
References: <0b5701c8bf47$49219520$ad289e86@LPSC0173W>
Content-Type: multipart/alternative; boundary="=-jP/1iXkLb6/5LGGP9YKC"
Date: Tue, 27 May 2008 09:42:20 -0700
Mime-Version: 1.0
Message-Id: <20080527164222.E226818D0062@mail151-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-jP/1iXkLb6/5LGGP9YKC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Guillaume,

Try using channel 1. It may be set up where the first channel is 1 and
not 0.

- John

On Mon, 2008-05-26 at 17:43 +0200, Guillaume Dargaud wrote:

> I still haven't managed to figure out how to use the Xilinx GPIO from 
> usermode.
> 
> The program gpio_test found at 
> http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/archive/2004/05/msg00004.html 
> and slightly modified as this:
> 
> #include <stdio.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <string.h>
> 
> #include <linux/types.h>
> #include <sys/ioctl.h>
> 
> #include <xgpio_ioctl.h>
> 
> #define GPIO_DEV "/dev/xgpio"
> 
> void usage(int argc, char *argv[])
> {
>         fprintf(stderr,"usage: %s hexval\n\n", argv[0]);
>         fprintf(stderr,"\n");
>         fprintf(stderr,"Puts the input hexval onto the LEDs, and\n");
>         fprintf(stderr,"displays the current value on the DIP switches\n");
>         fprintf(stderr,"\n");
>         fprintf(stderr,"try  gpio_test FC\n\n");
> 
> }
> 
> void dump_dipsw(int val)
> {
>         int i;
>         val = (val & 0x000000FF);
> 
>         printf("DIP SW: ");
>         for(i=0;i<8;i++)
>         {
>                 printf("%i",val & 0x01);
>                 val >>= 1;
>         }
>         printf("\n");
> }
> 
> /* Turn 4 LSB of X into 8 bit LED segment code */
> unsigned char nyb_hex2led(int x)
> {
>         unsigned char led_tab[] = {
>                 0xFC, 0x60, 0xDA, 0xF2,
>                 0x66, 0xB6, 0xBE, 0xE0,
>                 0xFE, 0xF6, 0xEE, 0x3E,
>                 0x9C, 0x7A, 0x9E, 0x8E};
> 
>         return led_tab[x & 0xF];
> }
> 
> /* Turn 8 LSB of x into 2 times 8 bit LED segment codes */
> unsigned short hex2led(int x)
> {
>         return (nyb_hex2led(x & 0xF) << 8) | (nyb_hex2led((x >> 4) & 0xF));
> }
> 
> int main(int argc, char *argv[])
> {
>         /* Open the device */
>         int fd = open(GPIO_DEV, O_RDWR);
> 
>         struct xgpio_ioctl_data gpio_ioctl;
>         // struct ibm_gpio_ioctl_data gpio_ioctl;
> //      int     result;
> //      int command;
> 
>         if(fd==-1) {
>                 fprintf(stderr,"Unable to open %s\n", GPIO_DEV);
>                 return -1;
>         }
> 
> /*
>         if(argc!=2)
>         {
>                 usage();
>                 exit(1);
>         }
> */
>         gpio_ioctl.chan=0;
> 
>         /* Set the tristates */
>         gpio_ioctl.mask=0x000000FF;
>         ioctl(fd, XGPIO_TRISTATE,(void *)&gpio_ioctl);
> 
>         /* Get output data from command line if provided */
> 
>         if(argc==2)
>                 sscanf(argv[1],"%x",&(gpio_ioctl.data));
>         else
>                 gpio_ioctl.data=time(NULL);
> 
>         /* Convert binary (16 LSB) into LED segment codes and shift into
>            position on gpio */
>         gpio_ioctl.data=hex2led(gpio_ioctl.data & 0xFF)<<8;
> 
>         ioctl(fd, XGPIO_OUT,(void *)&gpio_ioctl);
> 
>         /* Read some data */
>         ioctl(fd, XGPIO_IN,(void *)&gpio_ioctl);
> 
>         dump_dipsw(gpio_ioctl.data);
> 
>         return 0;
> }
> 
> 
> ...crashes in flames when run:
> 
> # gpio_test FC
> [ 1366.864955] Oops: kernel access of bad area, sig: 11 [#5]
> [ 1366.867560] NIP: c0108d50 LR: c00e68c4 CTR: 00000000
> [ 1366.867560] REGS: c752fde0 TRAP: 0300   Tainted: G      D   (2.6.25-rc9)
> [ 1366.867560] MSR: 00029030 <EE,ME,IR,DR>  CR: 93000033  XER: e000007f
> [ 1366.867560] DEAR: c8fffffc, ESR: 00000000
> [ 1366.867560] TASK = c7c37030[202] 'gpio_test' THREAD: c752e000
> [ 1366.867560] GPR00: 00000000 c752fe90 c7c37030 c8fffffc 00000056 0000000c 
> c752feb0 00000000
> [ 1366.867560] GPR08: 00000000 11111111 ffffffe7 c7c5866c 00000000 10018dec 
> ffff8432 ffdf1d0f
> [ 1366.867560] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff 00000000 
> 100af244 10000858
> [ 1366.867560] GPR24: 10000c00 00000002 10000478 800c5a03 c7c58000 c7c5866c 
> 800c5a03 c0200000
> [ 1366.867560] NIP [c0108d50] XIo_In32+0x4/0xc
> [ 1366.867560] LR [c00e68c4] XGpio_GetDataDirection+0x84/0xac
> [ 1366.867560] Call Trace:
> [ 1366.867560] [c752fe90] [c00e66a8] xgpio_getinst+0x48/0xb0 (unreliable)
> [ 1366.867560] [c752fea0] [c00e6a8c] xgpio_ioctl+0x1a0/0x1fc
> [ 1366.867560] [c752fed0] [c006740c] vfs_ioctl+0x6c/0x84
> [ 1366.867560] [c752fee0] [c006778c] do_vfs_ioctl+0x368/0x39c
> [ 1366.867560] [c752ff10] [c0067800] sys_ioctl+0x40/0x70
> [ 1366.867560] [c752ff40] [c0002770] ret_from_syscall+0x0/0x3c
> [ 1366.867560] Instruction dump:
> [ 1366.867560] 7c634b78 7c031b78 4e800020 7c0006ac 88630000 5463063e 
> 4e800020 7c0006ac
> [ 1366.867560] a0630000 5463043e 4e800020 7c0006ac <80630000> 4e800020 
> 7c0006ac 7c601e2c
> Segmentation fault
> 
> 
> # dmesg | grep gpio
> [    0.120666] Registering device xilinx_gpio:0
> [    0.121672] Registering device xilinx_gpio:1
> [    0.122682] Registering device xilinx_gpio:2
> [    0.292352] xgpio0 #0 at 0x81400000 mapped to 0xC9000000 device: 10,185 
> using IRQ#7
> [    0.293805] xgpio1 #1 at 0x81420000 mapped to 0xC9020000 device: 10,186 
> using IRQ#6
> [    0.295062] xgpio2 #2 at 0x81440000 mapped to 0xC9040000 device: 10,187 
> using IRQ#5
> [ 1366.867560] TASK = c7c37030[202] 'gpio_test' THREAD: c752e000
> [ 1366.867560] [c752fe90] [c00e66a8] xgpio_getinst+0x48/0xb0 (unreliable)
> [ 1366.867560] [c752fea0] [c00e6a8c] xgpio_ioctl+0x1a0/0x1fc
> 
> 
> 
> Another program using a different strategy also fails:
> 
> #include <fcntl.h>
> #include <stdio.h>
> 
> int main (int argc, char *argv[]) {
>  if (argc==2 || argc==3) {
> 
>   int fd = open(argv[1], O_RDWR | O_NDELAY );
>   if (fd < 0) {
>      fprintf(stderr, "GPIO OPEN FAIL\n");
>      return -1;
>   }
> 
>   unsigned long buff = 0;
>   if (argc==2) {
>    if (read(fd, &buff, 4) != 4)
>       fprintf(stderr, "GPIO READ ERROR\n");
>    else printf( "%x\n", buff);
>   } else {
>    buff=atoi(argv[2]);
>    if (write(fd, &buff, 4) != 4)
>       fprintf(stderr, "GPIO WRITE ERROR value %x\n", buff);
>    else printf( "Written %x successfully\n", buff);
>   }
> 
>   close(fd);
>  } else {
>   fprintf(stderr, "Usage: %s device [value] to read or write data to gpio 
> device\n", argv[0]);
>   return 1;
>  }
> 
>  return 0;
> }
> 
> 
> # GpioReadWrite /dev/xgpio
> GPIO READ ERROR
> # GpioReadWrite /dev/xgpio 7
> GPIO WRITE ERROR value 0
> 
> I wanted to avoid writing a kernel module, but apparently I've ran out of 
> options...


________________________________________________________________________

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


--=-jP/1iXkLb6/5LGGP9YKC
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
Hi Guillaume,<BR>
<BR>
Try using channel 1. It may be set up where the first channel is 1 and not 0.<BR>
<BR>
- John<BR>
<BR>
On Mon, 2008-05-26 at 17:43 +0200, Guillaume Dargaud wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">I still haven't managed to figure out how to use the Xilinx GPIO from </FONT>
<FONT COLOR="#000000">usermode.</FONT>

<FONT COLOR="#000000">The program gpio_test found at </FONT>
<FONT COLOR="#000000"><A HREF="http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/archive/2004/05/msg00004.html">http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/archive/2004/05/msg00004.html</A> </FONT>
<FONT COLOR="#000000">and slightly modified as this:</FONT>

<FONT COLOR="#000000">#include &lt;stdio.h&gt;</FONT>
<FONT COLOR="#000000">#include &lt;fcntl.h&gt;</FONT>
<FONT COLOR="#000000">#include &lt;errno.h&gt;</FONT>
<FONT COLOR="#000000">#include &lt;string.h&gt;</FONT>

<FONT COLOR="#000000">#include &lt;linux/types.h&gt;</FONT>
<FONT COLOR="#000000">#include &lt;sys/ioctl.h&gt;</FONT>

<FONT COLOR="#000000">#include &lt;xgpio_ioctl.h&gt;</FONT>

<FONT COLOR="#000000">#define GPIO_DEV &quot;/dev/xgpio&quot;</FONT>

<FONT COLOR="#000000">void usage(int argc, char *argv[])</FONT>
<FONT COLOR="#000000">{</FONT>
<FONT COLOR="#000000">        fprintf(stderr,&quot;usage: %s hexval\n\n&quot;, argv[0]);</FONT>
<FONT COLOR="#000000">        fprintf(stderr,&quot;\n&quot;);</FONT>
<FONT COLOR="#000000">        fprintf(stderr,&quot;Puts the input hexval onto the LEDs, and\n&quot;);</FONT>
<FONT COLOR="#000000">        fprintf(stderr,&quot;displays the current value on the DIP switches\n&quot;);</FONT>
<FONT COLOR="#000000">        fprintf(stderr,&quot;\n&quot;);</FONT>
<FONT COLOR="#000000">        fprintf(stderr,&quot;try  gpio_test FC\n\n&quot;);</FONT>

<FONT COLOR="#000000">}</FONT>

<FONT COLOR="#000000">void dump_dipsw(int val)</FONT>
<FONT COLOR="#000000">{</FONT>
<FONT COLOR="#000000">        int i;</FONT>
<FONT COLOR="#000000">        val = (val &amp; 0x000000FF);</FONT>

<FONT COLOR="#000000">        printf(&quot;DIP SW: &quot;);</FONT>
<FONT COLOR="#000000">        for(i=0;i&lt;8;i++)</FONT>
<FONT COLOR="#000000">        {</FONT>
<FONT COLOR="#000000">                printf(&quot;%i&quot;,val &amp; 0x01);</FONT>
<FONT COLOR="#000000">                val &gt;&gt;= 1;</FONT>
<FONT COLOR="#000000">        }</FONT>
<FONT COLOR="#000000">        printf(&quot;\n&quot;);</FONT>
<FONT COLOR="#000000">}</FONT>

<FONT COLOR="#000000">/* Turn 4 LSB of X into 8 bit LED segment code */</FONT>
<FONT COLOR="#000000">unsigned char nyb_hex2led(int x)</FONT>
<FONT COLOR="#000000">{</FONT>
<FONT COLOR="#000000">        unsigned char led_tab[] = {</FONT>
<FONT COLOR="#000000">                0xFC, 0x60, 0xDA, 0xF2,</FONT>
<FONT COLOR="#000000">                0x66, 0xB6, 0xBE, 0xE0,</FONT>
<FONT COLOR="#000000">                0xFE, 0xF6, 0xEE, 0x3E,</FONT>
<FONT COLOR="#000000">                0x9C, 0x7A, 0x9E, 0x8E};</FONT>

<FONT COLOR="#000000">        return led_tab[x &amp; 0xF];</FONT>
<FONT COLOR="#000000">}</FONT>

<FONT COLOR="#000000">/* Turn 8 LSB of x into 2 times 8 bit LED segment codes */</FONT>
<FONT COLOR="#000000">unsigned short hex2led(int x)</FONT>
<FONT COLOR="#000000">{</FONT>
<FONT COLOR="#000000">        return (nyb_hex2led(x &amp; 0xF) &lt;&lt; 8) | (nyb_hex2led((x &gt;&gt; 4) &amp; 0xF));</FONT>
<FONT COLOR="#000000">}</FONT>

<FONT COLOR="#000000">int main(int argc, char *argv[])</FONT>
<FONT COLOR="#000000">{</FONT>
<FONT COLOR="#000000">        /* Open the device */</FONT>
<FONT COLOR="#000000">        int fd = open(GPIO_DEV, O_RDWR);</FONT>

<FONT COLOR="#000000">        struct xgpio_ioctl_data gpio_ioctl;</FONT>
<FONT COLOR="#000000">        // struct ibm_gpio_ioctl_data gpio_ioctl;</FONT>
<FONT COLOR="#000000">//      int     result;</FONT>
<FONT COLOR="#000000">//      int command;</FONT>

<FONT COLOR="#000000">        if(fd==-1) {</FONT>
<FONT COLOR="#000000">                fprintf(stderr,&quot;Unable to open %s\n&quot;, GPIO_DEV);</FONT>
<FONT COLOR="#000000">                return -1;</FONT>
<FONT COLOR="#000000">        }</FONT>

<FONT COLOR="#000000">/*</FONT>
<FONT COLOR="#000000">        if(argc!=2)</FONT>
<FONT COLOR="#000000">        {</FONT>
<FONT COLOR="#000000">                usage();</FONT>
<FONT COLOR="#000000">                exit(1);</FONT>
<FONT COLOR="#000000">        }</FONT>
<FONT COLOR="#000000">*/</FONT>
<FONT COLOR="#000000">        gpio_ioctl.chan=0;</FONT>

<FONT COLOR="#000000">        /* Set the tristates */</FONT>
<FONT COLOR="#000000">        gpio_ioctl.mask=0x000000FF;</FONT>
<FONT COLOR="#000000">        ioctl(fd, XGPIO_TRISTATE,(void *)&amp;gpio_ioctl);</FONT>

<FONT COLOR="#000000">        /* Get output data from command line if provided */</FONT>

<FONT COLOR="#000000">        if(argc==2)</FONT>
<FONT COLOR="#000000">                sscanf(argv[1],&quot;%x&quot;,&amp;(gpio_ioctl.data));</FONT>
<FONT COLOR="#000000">        else</FONT>
<FONT COLOR="#000000">                gpio_ioctl.data=time(NULL);</FONT>

<FONT COLOR="#000000">        /* Convert binary (16 LSB) into LED segment codes and shift into</FONT>
<FONT COLOR="#000000">           position on gpio */</FONT>
<FONT COLOR="#000000">        gpio_ioctl.data=hex2led(gpio_ioctl.data &amp; 0xFF)&lt;&lt;8;</FONT>

<FONT COLOR="#000000">        ioctl(fd, XGPIO_OUT,(void *)&amp;gpio_ioctl);</FONT>

<FONT COLOR="#000000">        /* Read some data */</FONT>
<FONT COLOR="#000000">        ioctl(fd, XGPIO_IN,(void *)&amp;gpio_ioctl);</FONT>

<FONT COLOR="#000000">        dump_dipsw(gpio_ioctl.data);</FONT>

<FONT COLOR="#000000">        return 0;</FONT>
<FONT COLOR="#000000">}</FONT>


<FONT COLOR="#000000">...crashes in flames when run:</FONT>

<FONT COLOR="#000000"># gpio_test FC</FONT>
<FONT COLOR="#000000">[ 1366.864955] Oops: kernel access of bad area, sig: 11 [#5]</FONT>
<FONT COLOR="#000000">[ 1366.867560] NIP: c0108d50 LR: c00e68c4 CTR: 00000000</FONT>
<FONT COLOR="#000000">[ 1366.867560] REGS: c752fde0 TRAP: 0300   Tainted: G      D   (2.6.25-rc9)</FONT>
<FONT COLOR="#000000">[ 1366.867560] MSR: 00029030 &lt;EE,ME,IR,DR&gt;  CR: 93000033  XER: e000007f</FONT>
<FONT COLOR="#000000">[ 1366.867560] DEAR: c8fffffc, ESR: 00000000</FONT>
<FONT COLOR="#000000">[ 1366.867560] TASK = c7c37030[202] 'gpio_test' THREAD: c752e000</FONT>
<FONT COLOR="#000000">[ 1366.867560] GPR00: 00000000 c752fe90 c7c37030 c8fffffc 00000056 0000000c </FONT>
<FONT COLOR="#000000">c752feb0 00000000</FONT>
<FONT COLOR="#000000">[ 1366.867560] GPR08: 00000000 11111111 ffffffe7 c7c5866c 00000000 10018dec </FONT>
<FONT COLOR="#000000">ffff8432 ffdf1d0f</FONT>
<FONT COLOR="#000000">[ 1366.867560] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff 00000000 </FONT>
<FONT COLOR="#000000">100af244 10000858</FONT>
<FONT COLOR="#000000">[ 1366.867560] GPR24: 10000c00 00000002 10000478 800c5a03 c7c58000 c7c5866c </FONT>
<FONT COLOR="#000000">800c5a03 c0200000</FONT>
<FONT COLOR="#000000">[ 1366.867560] NIP [c0108d50] XIo_In32+0x4/0xc</FONT>
<FONT COLOR="#000000">[ 1366.867560] LR [c00e68c4] XGpio_GetDataDirection+0x84/0xac</FONT>
<FONT COLOR="#000000">[ 1366.867560] Call Trace:</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752fe90] [c00e66a8] xgpio_getinst+0x48/0xb0 (unreliable)</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752fea0] [c00e6a8c] xgpio_ioctl+0x1a0/0x1fc</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752fed0] [c006740c] vfs_ioctl+0x6c/0x84</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752fee0] [c006778c] do_vfs_ioctl+0x368/0x39c</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752ff10] [c0067800] sys_ioctl+0x40/0x70</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752ff40] [c0002770] ret_from_syscall+0x0/0x3c</FONT>
<FONT COLOR="#000000">[ 1366.867560] Instruction dump:</FONT>
<FONT COLOR="#000000">[ 1366.867560] 7c634b78 7c031b78 4e800020 7c0006ac 88630000 5463063e </FONT>
<FONT COLOR="#000000">4e800020 7c0006ac</FONT>
<FONT COLOR="#000000">[ 1366.867560] a0630000 5463043e 4e800020 7c0006ac &lt;80630000&gt; 4e800020 </FONT>
<FONT COLOR="#000000">7c0006ac 7c601e2c</FONT>
<FONT COLOR="#000000">Segmentation fault</FONT>


<FONT COLOR="#000000"># dmesg | grep gpio</FONT>
<FONT COLOR="#000000">[    0.120666] Registering device xilinx_gpio:0</FONT>
<FONT COLOR="#000000">[    0.121672] Registering device xilinx_gpio:1</FONT>
<FONT COLOR="#000000">[    0.122682] Registering device xilinx_gpio:2</FONT>
<FONT COLOR="#000000">[    0.292352] xgpio0 #0 at 0x81400000 mapped to 0xC9000000 device: 10,185 </FONT>
<FONT COLOR="#000000">using IRQ#7</FONT>
<FONT COLOR="#000000">[    0.293805] xgpio1 #1 at 0x81420000 mapped to 0xC9020000 device: 10,186 </FONT>
<FONT COLOR="#000000">using IRQ#6</FONT>
<FONT COLOR="#000000">[    0.295062] xgpio2 #2 at 0x81440000 mapped to 0xC9040000 device: 10,187 </FONT>
<FONT COLOR="#000000">using IRQ#5</FONT>
<FONT COLOR="#000000">[ 1366.867560] TASK = c7c37030[202] 'gpio_test' THREAD: c752e000</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752fe90] [c00e66a8] xgpio_getinst+0x48/0xb0 (unreliable)</FONT>
<FONT COLOR="#000000">[ 1366.867560] [c752fea0] [c00e6a8c] xgpio_ioctl+0x1a0/0x1fc</FONT>



<FONT COLOR="#000000">Another program using a different strategy also fails:</FONT>

<FONT COLOR="#000000">#include &lt;fcntl.h&gt;</FONT>
<FONT COLOR="#000000">#include &lt;stdio.h&gt;</FONT>

<FONT COLOR="#000000">int main (int argc, char *argv[]) {</FONT>
<FONT COLOR="#000000"> if (argc==2 || argc==3) {</FONT>

<FONT COLOR="#000000">  int fd = open(argv[1], O_RDWR | O_NDELAY );</FONT>
<FONT COLOR="#000000">  if (fd &lt; 0) {</FONT>
<FONT COLOR="#000000">     fprintf(stderr, &quot;GPIO OPEN FAIL\n&quot;);</FONT>
<FONT COLOR="#000000">     return -1;</FONT>
<FONT COLOR="#000000">  }</FONT>

<FONT COLOR="#000000">  unsigned long buff = 0;</FONT>
<FONT COLOR="#000000">  if (argc==2) {</FONT>
<FONT COLOR="#000000">   if (read(fd, &amp;buff, 4) != 4)</FONT>
<FONT COLOR="#000000">      fprintf(stderr, &quot;GPIO READ ERROR\n&quot;);</FONT>
<FONT COLOR="#000000">   else printf( &quot;%x\n&quot;, buff);</FONT>
<FONT COLOR="#000000">  } else {</FONT>
<FONT COLOR="#000000">   buff=atoi(argv[2]);</FONT>
<FONT COLOR="#000000">   if (write(fd, &amp;buff, 4) != 4)</FONT>
<FONT COLOR="#000000">      fprintf(stderr, &quot;GPIO WRITE ERROR value %x\n&quot;, buff);</FONT>
<FONT COLOR="#000000">   else printf( &quot;Written %x successfully\n&quot;, buff);</FONT>
<FONT COLOR="#000000">  }</FONT>

<FONT COLOR="#000000">  close(fd);</FONT>
<FONT COLOR="#000000"> } else {</FONT>
<FONT COLOR="#000000">  fprintf(stderr, &quot;Usage: %s device [value] to read or write data to gpio </FONT>
<FONT COLOR="#000000">device\n&quot;, argv[0]);</FONT>
<FONT COLOR="#000000">  return 1;</FONT>
<FONT COLOR="#000000"> }</FONT>

<FONT COLOR="#000000"> return 0;</FONT>
<FONT COLOR="#000000">}</FONT>


<FONT COLOR="#000000"># GpioReadWrite /dev/xgpio</FONT>
<FONT COLOR="#000000">GPIO READ ERROR</FONT>
<FONT COLOR="#000000"># GpioReadWrite /dev/xgpio 7</FONT>
<FONT COLOR="#000000">GPIO WRITE ERROR value 0</FONT>

<FONT COLOR="#000000">I wanted to avoid writing a kernel module, but apparently I've ran out of </FONT>
<FONT COLOR="#000000">options...</FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>

<HR SIZE="1">
<BR>
<BR>
John Bonesio<BR>
Commercial Linux Solutions<BR>
john.bonesio@xilinx.com<BR>
(408) 879-5569
</TD>
</TR>
</TABLE>
<br clear=all> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
</BODY>
</HTML>


--=-jP/1iXkLb6/5LGGP9YKC--
