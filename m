Return-Path: <rwehbi@wirecom-tech.com>
Received: from smtp2.clm.net4all.ch (smtp2.net4all-dns.com [80.80.228.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96F53DE5F1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 22:43:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: linux boot sequence
Date: Thu, 17 Jul 2008 14:42:05 +0200
Message-ID: <D3C541E264C021479BFB60B3B790C0FB49742D@etoilenoire.STARWARS.local>
From: "Rami WEHBI" <rwehbi@wirecom-tech.com>
To: "Siva Prasad" <sprasad@bivio.net>
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

Hello Siva,

I am using the 2.6.23 kernel and the target is the ppc405.=20

Using the booting-without-of.txt, and in searching in the kernel code I =
found that the devices_info are passed as parameters (memory size is the =
parameter I am searching for) by calling the function =
"find_bootinfo(void)" in /arch/ppc/kernel/setup.c
This function initializes send the pointer to linux on the device info =
as following (line 345):

		Rec =3D (struct bi_record *) =
_ALIGN((ulong)__bss_start+(1<<20)-1,(1<<20));

What is this address stand for ???=20


Rami,



-----Message d'origine-----
De : linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+rami.wehbi=3Dwirecom-tech.com@ozlabs.or=
g] De la part de Siva Prasad
Envoy=E9 : mercredi 16 juillet 2008 20:46
=C0 : Rami WEHBI
Cc : linuxppc-embedded@ozlabs.org
Objet : RE: linux boot sequence

Rami,

Please make sure to copy the list as well.

OF - Open firmware. I am not sure which version of Linux kernel you are =
using, and which boot loader. Lately it is all OF based, however it is =
supported in the form of device tree blob/structure. For more =
information read booting-without-of.txt in Documentation/powerpc.

U-Boot updates the detected memory in the dtb you loaded, so that when =
kernel reads it, correct information is provided.

There is no auto-detect option in kernel. You need to write your own =
code at the exact location it needs to identify the size of memory. =
Typically this is passed to the kernel either through DTB or kernel =
arguments.

Good Luck.

- Siva




-----Original Message-----
From: Rami WEHBI [mailto:rwehbi@wirecom-tech.com]
Sent: Monday, July 14, 2008 11:47 PM
To: Siva Prasad
Subject: RE: linux boot sequence


 what is the OF dtb ??? And how does the bootloader update it ???

 How can I do to set the autodetect option in the kernel ???


Best Regards,
Rami,



-----Message d'origine-----
De : Siva Prasad [mailto:sprasad@bivio.net]=20
Envoy=E9 : vendredi 11 juillet 2008 23:01
=C0 : Rami WEHBI
Cc : linuxppc-embedded@ozlabs.org
Objet : linux boot sequence


Well!... You can pass the size as part of the OF memory=3D<>.

Typically your boot loader should detect the amount of memory on the =
system and update the OF dtb to reflect the available memory.

You may also tweak the kernel yourself to autodetect, instead of reading =
from the OF. How ever, I would recommend the previous approach.

- Siva


Date: Fri, 11 Jul 2008 08:34:54 +0200
From: "Rami WEHBI" <rwehbi@wirecom-tech.com>
Subject: linux boot sequence
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
=09
<D3C541E264C021479BFB60B3B790C0FB497014@etoilenoire.STARWARS.local>
Content-Type: text/plain; charset=3D"iso-8859-1"


Hi all,
=20
    I am using the ppc405 and I would like to know, how does linux on =
this architect detect the available memory size in details !!!
        is it a parameter passed to linux at startup by the boot loader =
??
        is it an automatic detection ?? what are the steps to accomplish =
this job then ???
=20
Best regards to all,
=20
Rami
=20



Rami WEHBI =09
Recherche & D?veloppement =09
T?l :	 +33 2 36 56 86 00=09
Fax :	 +33 2 36 56 86 01=09
www.wirecom-tech.com=09

  <http://www.wirecom-tech.com> =09

WIRECOM Technologies
135, Rue Jacques Charles
45166 Olivet
=09






_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
