Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E10EBDDF14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 19:31:41 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Tue, 22 Jul 2008 11:31:32 +0200
References: <18503022.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
	<18582612.post@talk.nabble.com>
In-Reply-To: <18582612.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807221131.32556.arnd@arndb.de>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 22 July 2008, Misbah khan wrote:
> I am getting kernel panic while trying these as suggested by you ,the
> following points will elaborate my concern :-

Please post the entire driver, when you only post fragments that
don't compile, we can't really help you.

> i am allocating memory using vmalloc and remaping to the SDRAM area as :-
>=20
> buf_area =3D vmalloc(sizeof(circularbuffer_S));
> =A0=A0=A0=A0=A0=A0=A0=A0if(!buf_area)
> =A0=A0=A0=A0=A0=A0=A0=A0{
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ALERT"vmalloc=
 failed \n");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> =A0=A0=A0=A0=A0=A0=A0=A0}
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0buf_area =3D (circularbuffer_S *)ioremap(7700000,=
900000);
> =A0=A0=A0=A0=A0=A0=A0=A0if(!buf_area)
> =A0=A0=A0=A0=A0=A0=A0=A0{
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ALERT"ioremap=
 failed \n");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> =A0=A0=A0=A0=A0=A0=A0=A0}

You really need to decide whether you want to allocate memory or
want to remap an I/O range. ioremap is *only* for I/O ranges
on SoC or similar devices, and when you have that, you don't allocate
memory. Besides, the addresses you pass are really strange,
e.g. 900,000 bytes are not 9MB. Normally, you would get the
I/O address from the device tree, using of_iomap(), and then
use of_translate_address/remap_pfn_range to map it to user
space.

	Arnd <><
