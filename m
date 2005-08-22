Return-Path: <stefan.nickl@kontron.com>
Received: from kom-exchfe.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 09F1668008
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 00:06:45 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
In-Reply-To: <20050822122645.7AE6867FBD@ozlabs.org>
References: <20050822122645.7AE6867FBD@ozlabs.org>
Content-Type: text/plain; charset=windows-1251
Date: Mon, 22 Aug 2005 15:54:37 +0200
Message-Id: <1124718877.19750.23.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How NEC uPD720101 USB chip work well on linux2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-07-22 at 20:26 +0800, JohnsonCheng wrote:
> Dear All,
> =20
>=20
> I use NEC uPD720101 USB chip, 2 OHCI and 1 EHCI, I also have turn on
> the following options in kernel menuconfig:
[...]
> [*] USB Support / EHCI HCD (USB 2.0) support
[...]
> =20
>=20
> But when I plug-in a USB mouse, then Kernel Oops=85.
>=20
> I use MPC8241 CPU, and there are three USB ports sharing the same IRQ
> on my borad.

I recently came across similar trouble with a chip from this series, the
uPD720113 and another one in a off-the-shelf USB hub which I tried for
reference.
It may have been even the 101, but I'm not sure.

Anyways, I've also seen hard resets with 2.6.12 to 2.6.13-rc-something,
albeit in a x86-environment. The system would reset hard when plugging
something after the hub or the hub itself, in case of the 113 it crashed
100% as soon as the hub was attached or detected during bootup. With the
off-the-shelf hub, it was somewhat more random.

In my case, disabling the EHCI controller in the BIOS helped, so you may
try to disable the USB "2.0" support in the kernel config and see what
happens.
No problems running the system with only UHCI for some weeks now.

I've deferred this problem because Hi-Speed is not an issue to me now,
but I'd be curious to hear and test things if somebody had a take on
this.

Regards,

--=20
Stefan Nickl
Kontron Modular Computers
