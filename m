Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id C157BDDE03
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 17:03:20 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so249417anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 22:03:18 -0800 (PST)
Message-ID: <fa686aa40801252203j4ef89fey2a4557abe9add6f9@mail.gmail.com>
Date: Fri, 25 Jan 2008 23:03:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: xsysace.c oops on restart
In-Reply-To: <169c03cb0801252115q59b7e9c7g795cc35b7f252958@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0801252115q59b7e9c7g795cc35b7f252958@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/25/08, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> Hi Grant,
>
> I'm writing this e-mail directly to you before posting in the
> discussion forums because I found some issues with the xsysace.c
> driver.  You are listed as the main author of the driver, so I'm
> assuming you might have a better clue than me as to what is happening.

Feel free to post to the mailing list regardless.  It's better to have
a public record of our discussions.  I certainly have no problem with
you pointing out issues with that driver in public.  :-)

>
> When I built kernel 2.6.23.9 or the latest from your git tree, if I
> use the new system ACE driver that you wrote, I cannot reboot without
> a Oops in the kernel.  The message happens very late before the CPU is
> supposed to reboot.  If I compile the kernel with the old Xilinx
> driver, I don't get the oops on restart.

Yeah; that definitely sounds like a driver bug.

> Below are the details of the exception.
>
> The system is going down NOW!
> Sending SIGTERM to all processes
> Requesting system reboot
> [172545.229120] Restarting system.
> [172545.232346] <NULL>
> [172545.234663] Oops: Exception in kernel mode, sig: 8 [#1]
> [172545.239960] NIP: c7cb7e00 LR: c7cb7df0 CTR: 00000001
> [172545.245003] REGS: c7cb7d40 TRAP: 2007df0   Not tainted
> (2.6.23.9-jsc-vanilla)
> [172545.252291] MSR: 00000000 <>  CR: 00000010  XER: 000a00d2
> [172545.257773] TASK =3D c02fb430[136] 'init' THREAD: c7cb6000
> [172545.262976] GPR00: 3c303e5b 31373235 34352e32 32393132 305d2000
> 00000000 00000000 7fa41efc
> [172545.271442] GPR08: 00000000 fee1dead 28121969 00000000 c7cb7df0
> c0016350 00000000 00000000
> [172545.279902] GPR16: 00000001 00000000 c0170000 c019a464 c000b1f0
> 00607b83 00000000 00000000
> [172545.288368] GPR24: 00000000 ffffffff 00000000 0002d030 00000001
> c0024ccc 00000000 00000000
> [172545.296999] NIP [c7cb7e00] 0xc7cb7e00
> [172545.300747] LR [c7cb7df0] 0xc7cb7df0
> [172545.304400] Call Trace:
> [172545.306925] Instruction dump:
> [172545.309965] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX
> [172545.317781] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX

This traceback doesn't help much without knowing where 0xc7cb7e00 is
in your kernel image.  You could use gdb on the vmlinux image to
figure it out, but it would be simpler to enable
CONFIG_DEBUG_BUGVERBOSE and CONFIG_DEBUG_INFO and run it again.  That
should give you a more meaningful traceback.

I've also got a rework patch for the sysace drive which makes it a bit
more robust.  I'll post it to the list shortly.

> The only modification I had to make in the xsysace.c to make it work
> on my ML-310 is change the width of the systemACE bus:
> @@ -1126,7 +1127,7 @@ static void __devexit ace_free(struct device *dev)
>  static int __devinit ace_probe(struct platform_device *dev)
>  {
>         unsigned long physaddr =3D 0;
> -       int bus_width =3D ACE_BUS_WIDTH_16; /* FIXME: should not be hard =
coded */
> +       int bus_width =3D ACE_BUS_WIDTH_8; /* FIXME: should not be hard c=
oded */
>         int id =3D dev->id;
>         int irq =3D NO_IRQ;
>         int i;
>
> I would prefer to use the new systemACE driver because it seems to be
> faster (and the code is cleaner), but this oops on restart prevents me
> from doing a lot of work remotely since I need to press the reset
> button on my board.  I get this error on both my ML-310 board and the
> BEE2 machine I have at school.  I guess I could investigate a bit more
> by building the systemACE as a module and trying to load and unload it
> to see if I can make it crash.  It may not even be related to that
> driver, but if I change to the older driver, I never get this problem.
>  Every time I use the new driver, the problem shows up and this is the
> only setting that I change in the kernel.  All the time, I have the
> driver built into the kernel (not as a loadable module).
>
> Also, thanks to your Wiki pages and discussions in the linux-ppc
> groups, I managed to get my BEE2 to boot Linux 2.6 with all the
> goodies.  This is basically the only leftover issue with my system.
>
> Let me know if you have some insights as why this could happen.  I can
> see if other people have seen a similar problem in the discussion
> forums.
>
> Regards,
>
> Jean-Samuel
> --
> Ph.D. candidate
> Integrated Microsystems Laboratory
> McGill University, Montr=E9al, QC, CANADA
> Web Page: http://chaos.ece.mcgill.ca
>


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
