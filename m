Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 424DC679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 09:49:32 +1100 (EST)
Message-ID: <43FF8D76.7030807@digis.net>
Date: Fri, 24 Feb 2006 15:49:26 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: Frank Bennett <bennett78@digis.net>
Subject: Re: mpc5200 timer3 Interrupts stopped working
References: <43FF2D69.3030902@digis.net>
In-Reply-To: <43FF2D69.3030902@digis.net>
Content-Type: multipart/alternative;
	boundary="------------090300050707000001080700"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Frank Bennett <bennett78@digis.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090300050707000001080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

bennett78 wrote:

> Help, how do I debug timer3 Interrupts?  My driver was working and 
> then interrupts

Never mind H/W problem...the J27 jumper on the 5200Lite was missing.  I 
did get a change to
review arch/ppc/kernel/mpc5xxx-pic.c & my interrupt masks settings!

Sorry for the thread interrupt!

Frank Bennett

> stopped coming (most likely blocked).  I have a driver that is very 
> similar to
>      linuxppc_2_4_devel/drivers/char/pp01_ad64.c
> I have attached the complete driver (et.c)
>
> / # insmod et
> ET Display Driver v0.1 loaded ET_TIN irq 16
>
> et_init 00 intr->per_mask  1bfffc00
> et_init 10 intr->ctrl      00c01001
> et_init 14 intr->main_mask 00010e00
> et_init 24 intr->enc_stat  00000001
> et_init 28 intr->crit_stat 00000000
> et_init 2c intr->main_stat 00002000
> et_init 30 intr->per_stat  00000000
> et_init 38 intr->per_error 00000000
>
> / # cat /proc/interrupts
>            CPU0
>  16:          0  MPC5xxx Edge      et Trubine
>  23:       1049  MPC5xxx Edge      eth_xmit
>  24:       2468  MPC5xxx Edge      eth_recv
>  39:         51  MPC5xxx Edge      serial
>  40:          0  MPC5xxx Edge      serial
>  43:         69  MPC5xxx Edge      eth_err
> BAD:          0
>
> with a pulse train on timer3 input "et_interrupt" no longer gets
> called.
>
> code snippets
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> #define ET_TIN         3   // Turbine PULSE IN
>
> static void et_interrupt (int irq, void *dev_id, struct pt_regs * regs)
> {
>     int port = ET_IRQ_TO_PORT(irq);
>     unsigned long stat;
>
>     printk(KERN_INFO "et_interrupt IRQ %d port %d main_stat %x gpt.sr 
> %x \n",
>                         irq, port, intr->main_status, gpt[port].sr );
>
>     if( port == ET_TIN ) {
>         // Clear pending interrupt
>         stat = in_be32(&gpt[port].sr) & 0xffff;
>         out_be32(&gpt[port].sr,  MPC5xxx_GPT_SR_CAPT);
>         printk(KERN_INFO "et_int irq=%d port=%d stat %0lx \n", irq, 
> port, stat);
>         // wake_up_interruptible(&et_wait);
>     } else {
>         printk(KERN_ERR ET_MSG "Unexpected IRQ %d received", irq);
>     }
>     spin_lock (&et_lock);
>     turbine_per = in_be32(&gpt[port].sr) >> 16;
>     spin_unlock (&et_lock);
> }
>
>
> static int __init et_init (void)
> ....
> if (request_irq(ET_PORT_TO_IRQ(ET_TIN), et_interrupt, 0, "et Trubine", 
> NULL)) {
>             printk(KERN_ERR ET_MSG "couldn't register interrupts\n");
>             goto abort_remove_proc;
>     }
> out_be32(&gpt[ET_TIN].cir, (   66<<16) | 1 );  /* prescale(16), 
> period(16)  */
> out_be32(&gpt[ET_TIN].emsr,
>         MPC5xxx_GPT_EMSR_INP_CAPTURE
>       | MPC5xxx_GPT_EMSR_ICT_FALLING
>       | MPC5xxx_GPT_EMSR_INT_ENABLE);
> ...
> printk(KERN_INFO "ET Display Driver v%s loaded ET_TIN irq %d\n",
>         ET_VERSION, ET_PORT_TO_IRQ(ET_TIN) );
>
>     //broke with or without the following
>     intr->main_mask &= ~(0x000000ff);   /* enable timer ints */
>
>     printk(KERN_INFO "et_init 00 intr->per_mask  %08x\n", intr->per_mask);
>     printk(KERN_INFO "et_init 10 intr->ctrl      %08x\n", intr->ctrl);
>     printk(KERN_INFO "et_init 14 intr->main_mask %08x\n", 
> intr->main_mask);
>     printk(KERN_INFO "et_init 24 intr->enc_stat  %08x\n", 
> intr->enc_status);
>     printk(KERN_INFO "et_init 28 intr->crit_stat %08x\n", 
> intr->crit_status);
>     printk(KERN_INFO "et_init 2c intr->main_stat %08x\n", 
> intr->main_status);
>     printk(KERN_INFO "et_init 30 intr->per_stat  %08x\n", 
> intr->per_status);
>     printk(KERN_INFO "et_init 38 intr->per_error %08x\n", 
> intr->per_error);
>
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> thanks in advance for any help,
>
> Frank Bennett
>

--------------090300050707000001080700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
bennett78 wrote:
<blockquote cite="mid43FF2D69.3030902@digis.net" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
  <tt>Help, how do I debug timer3 Interrupts?&nbsp; My driver was working
and
then interrupts <br>
  </tt></blockquote>
Never mind H/W problem...the J27 jumper on the 5200Lite was missing.&nbsp; I
did get a change to<br>
review arch/ppc/kernel/mpc5xxx-pic.c &amp; my interrupt masks settings!<br>
<br>
Sorry for the thread interrupt!<br>
<br>
Frank Bennett<br>
<blockquote cite="mid43FF2D69.3030902@digis.net" type="cite"><tt>stopped
coming (m</tt><tt>ost likely blocked).&nbsp; I have a driver that is
very similar to<br>
&nbsp;&nbsp;&nbsp;&nbsp; linuxppc_2_4_devel/drivers/char/pp01_ad64.c <br>
I have attached the complete driver (et.c)<br>
  </tt><tt><br>
/ # insmod et<br>
ET Display Driver v0.1 loaded ET_TIN irq 16<br>
  <br>
et_init 00 intr-&gt;per_mask&nbsp; 1bfffc00<br>
et_init 10 intr-&gt;ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00c01001<br>
et_init 14 intr-&gt;main_mask 00010e00<br>
et_init 24 intr-&gt;enc_stat&nbsp; 00000001<br>
et_init 28 intr-&gt;crit_stat 00000000<br>
et_init 2c intr-&gt;main_stat 00002000<br>
et_init 30 intr-&gt;per_stat&nbsp; 00000000<br>
et_init 38 intr-&gt;per_error 00000000<br>
  <br>
/ # cat /proc/interrupts<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
&nbsp;16:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; et Trubine<br>
&nbsp;23:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1049&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_xmit<br>
&nbsp;24:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2468&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_recv<br>
&nbsp;39:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial<br>
&nbsp;40:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial<br>
&nbsp;43:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69&nbsp; MPC5xxx Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_err<br>
BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
  <br>
with a pulse train on timer3 input "et_interrupt" no longer gets<br>
called.<br>
  <br>
code snippets<br>
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<br>
#define ET_TIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; // Turbine PULSE IN<br>
  <br>
static void et_interrupt (int irq, void *dev_id, struct pt_regs * regs)<br>
{<br>
&nbsp;&nbsp;&nbsp; int port = ET_IRQ_TO_PORT(irq);<br>
&nbsp;&nbsp;&nbsp; unsigned long stat;<br>
  <br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_interrupt IRQ %d port %d main_stat %x gpt.sr
%x \n",<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq, port, intr-&gt;main_status, gpt[port].sr );<br>
  <br>
&nbsp;&nbsp;&nbsp; if( port == ET_TIN ) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Clear pending interrupt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stat = in_be32(&amp;gpt[port].sr) &amp; 0xffff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;gpt[port].sr,&nbsp; MPC5xxx_GPT_SR_CAPT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_int irq=%d port=%d stat %0lx \n", irq,
port, stat);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // wake_up_interruptible(&amp;et_wait);<br>
&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR ET_MSG "Unexpected IRQ %d received", irq);<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; spin_lock (&amp;et_lock);<br>
&nbsp;&nbsp;&nbsp; turbine_per = in_be32(&amp;gpt[port].sr) &gt;&gt; 16;<br>
&nbsp;&nbsp;&nbsp; spin_unlock (&amp;et_lock);<br>
}<br>
  <br>
  <br>
static int __init et_init (void)<br>
....<br>
if (request_irq(ET_PORT_TO_IRQ(ET_TIN), et_interrupt, 0, "et Trubine",
NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR ET_MSG "couldn't register interrupts\n");<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto abort_remove_proc;<br>
&nbsp;&nbsp;&nbsp; }<br>
out_be32(&amp;gpt[ET_TIN].cir, (&nbsp;&nbsp; 66&lt;&lt;16) | 1 );&nbsp; /*
prescale(16), period(16)&nbsp; */<br>
out_be32(&amp;gpt[ET_TIN].emsr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC5xxx_GPT_EMSR_INP_CAPTURE <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | MPC5xxx_GPT_EMSR_ICT_FALLING <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | MPC5xxx_GPT_EMSR_INT_ENABLE);<br>
...<br>
printk(KERN_INFO "ET Display Driver v%s loaded ET_TIN irq %d\n",<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ET_VERSION, ET_PORT_TO_IRQ(ET_TIN) );<br>
  <br>
&nbsp;&nbsp;&nbsp; //broke with or without the following<br>
&nbsp;&nbsp;&nbsp; intr-&gt;main_mask &amp;= ~(0x000000ff);&nbsp;&nbsp; /* enable timer ints */<br>
  <br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 00 intr-&gt;per_mask&nbsp; %08x\n",
intr-&gt;per_mask);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 10 intr-&gt;ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %08x\n",
intr-&gt;ctrl);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 14 intr-&gt;main_mask %08x\n",
intr-&gt;main_mask);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 24 intr-&gt;enc_stat&nbsp; %08x\n",
intr-&gt;enc_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 28 intr-&gt;crit_stat %08x\n",
intr-&gt;crit_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 2c intr-&gt;main_stat %08x\n",
intr-&gt;main_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 30 intr-&gt;per_stat&nbsp; %08x\n",
intr-&gt;per_status);<br>
&nbsp;&nbsp;&nbsp; printk(KERN_INFO "et_init 38 intr-&gt;per_error %08x\n",
intr-&gt;per_error);<br>
  <br>
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=<br>
thanks in advance for any help,</tt><br>
  <div class="moz-signature"><br>
  <meta content="text/html;" http-equiv="Content-Type">
  <title></title>
  <span style="font-style: italic; font-weight: bold;">Frank Bennett</span><br>
  <br>
  </div>
</blockquote>
</body>
</html>

--------------090300050707000001080700--
