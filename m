Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 4EEA6DDF93
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 02:01:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problems with PCI-E devices not being detected with switch
Date: Thu, 16 Oct 2008 10:01:55 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
In-Reply-To: <1224134422.8157.549.camel@pasglop>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-15 at 10:47 -0500, Ayman El-Khashab wrote:
>=20
> Note for people on CC: This is a problem on 460EX on a canyonland
> using the 4x port.=20
>=20
>> The problem occurs when Linux boots. It sees the switch (and looking
>> in /sys/bus/... confirms it), but nothing on the downstream sides of
>> the switch (secondary busses) is visible.  There were no boot
>> messages to indicate it had seen the Sil 3531 and it doesn't
>> function.  We've also tried other PCI-E devices (NI GPIB) on the
>> downstream side and they are also not detected, so it seems to be
>> something in Linux, my configuration, etc.  I've included the boot
>> messages below from u-boot and the kernel.  It is more than just the
>> pci boot messages, but I was not sure if something else in the log
>> with provide some insight.=20
>=20
> The messages below look really fishy indeed:
>=20
>> pci 0001:02:00.0: unknown header type 03, ignoring device pci
>> 0001:02:01.0: unknown header type 41, ignoring device pci
>> 0001:02:02.0: unknown header type 03, ignoring device pci
>> 0001:02:03.0: unknown header type 41, ignoring device pci
>> 0001:02:04.0: ignoring class 1d09 (doesn't match header type 02) pci
>> 0001:02:05.0: unknown header type 41, ignoring device pci
>> 0001:02:06.0: ignoring class 1d09 (doesn't match header type 02) pci
>> 0001:02:07.0: unknown header type 41, ignoring device pci
>> 0001:02:08.0: unknown header type 03, ignoring device pci
>> 0001:02:09.0: unknown header type 41, ignoring device pci
>> 0001:02:0a.0: ignoring class 7d09 (doesn't match header type 02) pci
>> 0001:02:0b.0: unknown header type 41, ignoring device pci
>> 0001:02:0c.0: ignoring class 1d01 (doesn't match header type 02) pci
>> 0001:02:0d.0: unknown header type 41, ignoring device pci
>> 0001:02:0e.0: ignoring class 7d09 (doesn't match header type 02) pci
>> 0001:02:0f.0: unknown header type 41, ignoring device pci
>> 0001:02:10.0: unknown header type 03, ignoring device pci
>> 0001:02:11.0: unknown header type 41, ignoring device pci
>> 0001:02:12.0: unknown header type 03, ignoring device pci
>> 0001:02:13.0: unknown header type 41, ignoring device pci
>> 0001:02:14.0: unknown header type 03, ignoring device pci
>> 0001:02:15.0: unknown header type 41, ignoring device pci
>> 0001:02:16.0: ignoring class 3d09 (doesn't match header type 02) pci
>> 0001:02:17.0: unknown header type 41, ignoring device pci
>> 0001:02:18.0: unknown header type 03, ignoring device pci
>> 0001:02:19.0: unknown header type 41, ignoring device pci
>> 0001:02:1a.0: unknown header type 03, ignoring device pci
>> 0001:02:1b.0: unknown header type 41, ignoring device pci
>> 0001:02:1c.0: ignoring class 5d01 (doesn't match header type 02) pci
>> 0001:02:1d.0: unknown header type 41, ignoring device pci
>> 0001:02:1e.0: unknown header type 03, ignoring device pci
>> 0001:02:1f.0: unknown header type 41, ignoring device
>=20
>=20
> Ayman, can you try adding a long delay (such as msleep(5000), ie 5s)
> at the beginning of pcibios_init() in arch/powerpc/kernel/pci_32.c ?=20
> This will add 5s delay between the init/reset of the port and the
> probing by linux. Do that help ?=20
>=20

Thanks for your help.  I did try a 5s delay and other than the boot
taking an extra couple of seconds, there was no change.  The messages
above "unknown header" still showed up.  Downstream devices were not
found.
BTW, this is with both the Denx kernel tree and the official 2.6.27
kernel. =20
Both have the same results. One added note, just to rule out bad
electronics,
I have confirmed that the switch+sata work correctly together if placed
into a plain x86 pc with 2.6.24.  So the electronics are fine.

Ayman
