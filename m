Return-Path: <eddy.petrisor@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id E0C7D68593
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2005 18:13:22 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id s18so21195nze
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Nov 2005 23:13:21 -0800 (PST)
Message-ID: <60381eeb0511032313i426db0c8o7254009240f6988a@mail.gmail.com>
Date: Fri, 4 Nov 2005 09:13:21 +0200
From: =?ISO-8859-2?Q?Eddy_Petri=BAor?= <eddy.petrisor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1131052876.4680.78.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1130999620.4680.28.camel@gaston>
	<60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>
	<1131052876.4680.78.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/3/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > So this supposed to work with the USB sleep support enabled, right?
> > If this works then I will be very thankful!
> > I hope I have the time to test this patch this evening.
> >
> > > Note that the patch is totally untested here so it may be just plain
> > > bogus :)
> >
> > No problem.
> >
> > AIUI, this should allow me to put my PB 5,2 to sleep while a usb stick
> > is mounted and come back from sleep with no problem and the stick to
> > be still mounted, right?
>
> Heh, in _theory_ :) The first aim of the patch is to remove the crash on
> sleep/wakeup in 2.6.14. If it doesn't blow up, that's already a good

Well, I couldn't get to that point (getting back from sleep) :-D

> first step :) Wether suspend with your USB stick works is a different
> matter, mostly due to the USB stack itself.

The kernel oopsed when it was supposed to go to sleep:

Nov  4 09:01:34 localhost kernel: usb 3-1: no poweroff yet, suspending inst=
ead
Nov  4 09:01:34 localhost kernel: usb usb4: no poweroff yet, suspending ins=
tead
Nov  4 09:01:34 localhost kernel: Oops: Exception in kernel mode, sig: 5 [#=
1]
Nov  4 09:01:34 localhost kernel: PREEMPT
Nov  4 09:01:34 localhost kernel: NIP: C00184F4 LR: D224199C SP:
CD7D5D00 REGS: cd7d5c50 TRAP: 0700    Not tainted
Nov  4 09:01:34 localhost kernel: MSR: 00029032 EE: 1 PR: 0 FP: 0 ME:
1 IR/DR: 11
Nov  4 09:01:34 localhost kernel: TASK =3D cec8f2e0[2751] 'pbbuttonsd'
THREAD: cd7d4000
Nov  4 09:01:34 localhost kernel: Last syscall: 54
Nov  4 09:01:34 localhost kernel: GPR00: 00000001 CD7D5D00 CEC8F2E0
00000001 00001000 00001000 000007D0 FFFFFFFC
Nov  4 09:01:34 localhost kernel: GPR08: D220C064 CD7D4000 00000000
00000000 0000D903 1002C830 100D0000 100E2CB8
Nov  4 09:01:34 localhost kernel: GPR16: 100D0000 100A0000 00000000
100D0000 100EC488 10010000 10010000 D20C0000
Nov  4 09:01:34 localhost kernel: GPR24: D20C0000 D20C0000 C0310000
00000000 C0300000 00000006 CF3EDC00 CF3EDCD0
Nov  4 09:01:34 localhost kernel: NIP [c00184f4] sub_preempt_count+0x14/0x7=
0
Nov  4 09:01:34 localhost kernel: LR [d224199c]
ehci_hub_suspend+0x1ac/0x210 [ehci_hcd]
Nov  4 09:01:34 localhost kernel: Call trace:
Nov  4 09:01:34 localhost kernel:  [d20b47e4]
hcd_hub_suspend+0x34/0x50 [usbcore]
Nov  4 09:01:34 localhost kernel:  [d20b2958]
__usb_suspend_device+0x308/0x330 [usbcore]
Nov  4 09:01:34 localhost kernel:  [d20b2ae0]
usb_suspend_device+0x40/0x70 [usbcore]
Nov  4 09:01:34 localhost kernel:  [d20aead0]
usb_generic_suspend+0xa0/0xb0 [usbcore]
Nov  4 09:01:34 localhost kernel:  [c01d7904] suspend_device+0x104/0x160
Nov  4 09:01:34 localhost kernel:  [c01d7b40] device_suspend+0x110/0x320
Nov  4 09:01:34 localhost kernel:  [c037d6b0] pmac_suspend_devices+0x50/0x1=
d0
Nov  4 09:01:34 localhost kernel:  [c037de58] pmu_ioctl+0x388/0x9f0
Nov  4 09:01:34 localhost kernel:  [c00961dc] do_ioctl+0x9c/0xb0
Nov  4 09:01:34 localhost kernel:  [c009627c] vfs_ioctl+0x8c/0x4c0
Nov  4 09:01:34 localhost kernel:  [c0096744] sys_ioctl+0x94/0xb0
Nov  4 09:01:34 localhost kernel:  [c0004840] ret_from_syscall+0x0/0x44



--
Regards,
EddyP
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"Imagination is more important than knowledge" A.Einstein
