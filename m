Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id C8162DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 18:13:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mmap and ppc460gt
Date: Wed, 27 Aug 2008 10:13:18 +0200
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com>
In-Reply-To: <ada3akri1i5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271013.18659.arnd@arndb.de>
Cc: vb <vb@vsbe.com>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 27 August 2008, Roland Dreier wrote:
> =A0> I don't seem to be able to port this to ppc460gt: on this architectu=
re
> =A0> the PCI register space can be mapped only to 36 bit address ranges
> =A0> with nonzero top nibbles. But mmap() =A0(at least the one I have in
> =A0> 2.6.25) =A0accepts only 32 bit values for addresses, hence there is =
no
> =A0> way to map PCI space into user space.
>=20
> In the past I've been able to use mmap64() on ppc440 to get at 36-bit
> addresses. =A0As far as I know this should still work.

Right, this is supposed to work. If it doesn't, report it as a bug.

> Also you should be able to get at the BAR of a PCI device by using
> mmap() on a resource file under /sys/devices, eg something like
> /sys/devices/pci0000:00/0000:00:04.0/0000:0b:00.0/resource0
> (where the bus numbers obviously depend on your system and the resource
> number depends on what BAR your device has registers in)

This should work as well.

The best way to do it however would be to implement a UIO device driver
for your device, see e.g. http://lwn.net/Articles/232575/.

That gives you proper control over the permissions and lets you handle
interrupts and other things as well.

	Arnd <><
