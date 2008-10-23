Return-Path: <bms.monteiro@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id BC168DDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 03:59:21 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so113185ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 09:59:20 -0700 (PDT)
Message-ID: <d43ae5a00810230958w147d810v363263ab55dc1550@mail.gmail.com>
Date: Thu, 23 Oct 2008 17:58:50 +0100
From: "Bruno Monteiro" <bms.monteiro@gmail.com>
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: Compile program using XGpio
In-Reply-To: <20081021200830.436214D8052@mail10-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_34353_17591202.1224781130265"
References: <d43ae5a00810210735k2e2068aew3e67e36bd079805@mail.gmail.com>
	<20081021200830.436214D8052@mail10-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_34353_17591202.1224781130265
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm a new driver writer and i'm trying to understand how to deal with XGpio.
My goal is writing a small piece of code that can turn leds on and off. I
think this driver should do it:


#include <linux/init.h>
#include <linux/module.h>

#include "xgpio.h"
#include "xgpio_ioctl.h"
#include "xparameters.h"

XGpio led;

static int myteste_init(void)
{
    XGpio_Initialize (&led, LEDs_4Bit);
    XGpio_SetDataDirection(&led,1,0);
    XGpio_DiscreteWrite(&led,1,0xf);
    printk (KERN_ALERT "LEDS: Turn off\n");

    return 0;
}

static int myteste_exit(void)
{

    XGpio_DiscreteWrite(&led,1,0x0);
    printk (KERN_ALERT "LEDS: Turn on\n");
    return 0;
}

module_init(myteste_init);
module_exit(myteste_exit);

But i have this error:
ERROR: "XGpio_SetDataDirection" [drivers/char/mytest/mytest.ko] undefined!
ERROR: "XGpio_Initialize" [drivers/char/mytest/mytest.ko] undefined!
ERROR: "XGpio_DiscreteWrite" [drivers/char/mytest/mytest.ko] undefined!

Any suggestion? This is the makefile:
  EXTRA_CFLAGS    += -I$(TOPDIR)/drivers/xilinx_common
  EXTRA_CFLAGS    += -I$(TOPDIR)/drivers/char/xilinx_gpio
  obj-$(CONFIG_MY_TEST)     := mytest.o


Is there any way to use *.dts instead xparameters.h

Thanks,
Bruno




On Tue, Oct 21, 2008 at 9:08 PM, John Linn <John.Linn@xilinx.com> wrote:

>  Hi Bruno,
>
>
>
> I don't think you can do what you're trying to do, unless I'm
> misunderstanding or just not smart enough.
>
>
>
> The EDK from Xilinx ships with drivers that are not Linux drivers.  Those
> functions in main below are intended for a standalone (no RTOS) system such
> they can't just be called from a user app in Linux.  You are sort of trying
> to create a user mode driver with what you are doing.
>
>
>
> There is a character mode gpio driver in the Xilinx git tree, git://
> git.xilinx.com/linux-2.6-xlnx.git that has been used previously.  I don't
> currently test that driver as we're in the process of getting a flattened
> gpio driver that is not char driver ready for mainline.
>
>
>
> I plan to take a look at the char mode gpio driver today as there's another
> question regarding it on the list.
>
>
>
> Thanks,
>
> John
>
>
>
>
>   ------------------------------
>
> *From:* linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org [mailto:
> linuxppc-embedded-bounces+john.linn<linuxppc-embedded-bounces%2Bjohn.linn>
> =xilinx.com@ozlabs.org] *On Behalf Of *Bruno Monteiro
> *Sent:* Tuesday, October 21, 2008 8:36 AM
> *To:* linuxppc-embedded@ozlabs.org
> *Subject:* Compile program using XGpio
>
>
>
> Hi all,
>
>
> I'm working with a Virtex2p. I have a running system using:
>
>    - EDK 9.1
>    - Crosstool-ng (svn)
>    - linux-2.6-xlnx
>    - BusyBox 1.12.1
>
> Now, i'm trying to build a small program that turn off leds. I guess it
> should be something like this:
>
> void main (void){
>     XGpio led;
>     XGpio_Initialize (&led, XPAR_LEDS_4BIT_DEVICE_ID);
>     XGpio_SetDataDirection(&led,1,0);
>     XGpio_DiscreteWrite(&led,1,0xf);
> }
>
>
> I want to know how to compile it (without EDK). Any suggestion?
>
>
> Thanks,
> Bruno Monteiro
>
> This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you are not
> the intended recipient, do not read, copy, or forward this email message or
> any attachments. Delete this email message and any attachments immediately.
>

------=_Part_34353_17591202.1224781130265
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;m a new driver writer and i&#39;m trying to understand how to deal with XGpio. My goal is writing a small piece of code that can turn leds on and off. I think this driver should do it:<br><br><br><div style="margin-left: 40px;">



#include &lt;linux/init.h&gt;<br>#include &lt;linux/module.h&gt;<br><br>#include &quot;xgpio.h&quot;<br>#include &quot;xgpio_ioctl.h&quot;<br>#include &quot;xparameters.h&quot;<br><br>XGpio led;<br><br>static int myteste_init(void)<br>

{<br>&nbsp;&nbsp;&nbsp; XGpio_Initialize (&amp;led, LEDs_4Bit);<br>

&nbsp;&nbsp;&nbsp; XGpio_SetDataDirection(&amp;led,1,0);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; XGpio_DiscreteWrite(&amp;led,1,0xf);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; printk (KERN_ALERT &quot;LEDS: Turn off\n&quot;);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>static int myteste_exit(void)<br>



{<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; XGpio_DiscreteWrite(&amp;led,1,0x0);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; printk (KERN_ALERT &quot;LEDS: Turn on\n&quot;);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>module_init(myteste_init);<br>module_exit(myteste_exit);<br><br></div>But i have this error:<br>



<div style="margin-left: 40px;">ERROR: &quot;XGpio_SetDataDirection&quot; [drivers/char/mytest/mytest.ko] undefined!<br>ERROR: &quot;XGpio_Initialize&quot; [drivers/char/mytest/mytest.ko] undefined!<br>ERROR: &quot;XGpio_DiscreteWrite&quot; [drivers/char/mytest/mytest.ko] undefined!<br>


<br></div>Any suggestion? This is the makefile:<br>&nbsp; EXTRA_CFLAGS&nbsp;&nbsp;&nbsp; += -I$(TOPDIR)/drivers/xilinx_common<br>&nbsp; EXTRA_CFLAGS&nbsp;&nbsp;&nbsp; += -I$(TOPDIR)/drivers/char/xilinx_gpio<br>&nbsp; obj-$(CONFIG_MY_TEST) &nbsp;&nbsp;&nbsp; := mytest.o<br><br><br>
Is there any way to use *.dts instead xparameters.h<br><br>Thanks,<br>Bruno<br><br><br>
<br><br><div class="gmail_quote">On Tue, Oct 21, 2008 at 9:08 PM, John Linn <span dir="ltr">&lt;<a href="mailto:John.Linn@xilinx.com" target="_blank">John.Linn@xilinx.com</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">









<div link="blue" vlink="purple" lang="EN-US">

<div><div>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">Hi Bruno,</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">I don&#39;t think you can do what
you&#39;re trying to do, unless I&#39;m misunderstanding or just not smart
enough.</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">The EDK from Xilinx ships with drivers
that are not Linux drivers. &nbsp;Those functions in main below are intended
for a standalone (no RTOS) system such they can&#39;t just be called from a
user app in Linux.&nbsp; You are sort of trying to create a user mode driver
with what you are doing.</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">There is a character mode gpio driver in
the Xilinx git tree, git://<a href="http://git.xilinx.com/linux-2.6-xlnx.git" target="_blank">git.xilinx.com/linux-2.6-xlnx.git</a> that has been used
previously.&nbsp; I don&#39;t currently test that driver as we&#39;re in
the process of getting a flattened gpio driver that is not char driver ready
for mainline.</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">I plan to take a look at the char mode
gpio driver today as there&#39;s another question regarding it on the list.</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">Thanks,</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">John</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color="navy" face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

</div><div style="border-style: none none none solid; border-color: -moz-use-text-color -moz-use-text-color -moz-use-text-color blue; border-width: medium medium medium 1.5pt; padding: 0in 0in 0in 4pt;"><div>


<div>

<div style="text-align: center;" align="center"><font face="Times New Roman" size="3"><span style="font-size: 12pt;">

<hr align="center" width="100%" size="2">

</span></font></div>

<p><b><font face="Tahoma" size="2"><span style="font-size: 10pt; font-family: Tahoma; font-weight: bold;">From:</span></font></b><font face="Tahoma" size="2"><span style="font-size: 10pt; font-family: Tahoma;"> linuxppc-embedded-bounces+john.linn=<a href="http://xilinx.com" target="_blank">xilinx.com</a>@<a href="http://ozlabs.org" target="_blank">ozlabs.org</a>
[mailto:<a href="mailto:linuxppc-embedded-bounces%2Bjohn.linn" target="_blank">linuxppc-embedded-bounces+john.linn</a>=<a href="http://xilinx.com" target="_blank">xilinx.com</a>@<a href="http://ozlabs.org" target="_blank">ozlabs.org</a>] <b><span style="font-weight: bold;">On Behalf Of </span></b>Bruno Monteiro<br>




<b><span style="font-weight: bold;">Sent:</span></b> Tuesday, October 21, 2008
8:36 AM<br>
<b><span style="font-weight: bold;">To:</span></b> <a href="mailto:linuxppc-embedded@ozlabs.org" target="_blank">linuxppc-embedded@ozlabs.org</a><br>
<b><span style="font-weight: bold;">Subject:</span></b> Compile program using XGpio</span></font></p>

</div>

<p><font face="Times New Roman" size="3"><span style="font-size: 12pt;">&nbsp;</span></font></p>

</div><p><font face="Times New Roman" size="3"><span style="font-size: 12pt;">Hi all,<div><div></div><div><br>
<br>
I&#39;m working with a Virtex2p. I have a running system using:</div></div></span></font></p><div><div></div><div>

<ul type="disc">
 <li><font face="Times New Roman" size="3"><span style="font-size: 12pt;">EDK 9.1</span></font></li>
 <li><font face="Times New Roman" size="3"><span style="font-size: 12pt;">Crosstool-ng (svn)</span></font></li>
 <li><font face="Times New Roman" size="3"><span style="font-size: 12pt;">linux-2.6-xlnx</span></font></li>
 <li><font face="Times New Roman" size="3"><span style="font-size: 12pt;">BusyBox 1.12.1</span></font></li>
</ul>

<p style="margin-bottom: 12pt;"><font face="Times New Roman" size="3"><span style="font-size: 12pt;">Now, i&#39;m trying to build
a small program that turn off leds. I guess it should be something like this:</span></font></p>

<div style="margin-left: 30pt;">

<p style="margin-bottom: 12pt;"><font face="Times New Roman" size="3"><span style="font-size: 12pt;">void main (void){<br>
&nbsp;&nbsp;&nbsp; XGpio led;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; XGpio_Initialize (&amp;led, XPAR_LEDS_4BIT_DEVICE_ID);<br>
&nbsp;&nbsp;&nbsp; XGpio_SetDataDirection(&amp;led,1,0);<br>
&nbsp;&nbsp;&nbsp; XGpio_DiscreteWrite(&amp;led,1,0xf);&nbsp;&nbsp;&nbsp; <br>
}</span></font></p>

</div>

<p style="margin-bottom: 12pt;"><font face="Times New Roman" size="3"><span style="font-size: 12pt;"><br>
I want to know how to compile it (without EDK). Any suggestion? <br>
<br>
<br>
Thanks,<br>
Bruno Monteiro </span></font></p>

</div></div></div>

</div>

<br clear="all"><div> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
</div></div>



</blockquote></div><br>

------=_Part_34353_17591202.1224781130265--
