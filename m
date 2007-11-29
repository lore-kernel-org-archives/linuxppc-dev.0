Return-Path: <SRS0=HkGh=QW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 9D39DDDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 17:09:12 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
Date: Thu, 29 Nov 2007 07:10:29 +0100
References: <556469.76659.qm@web45605.mail.sp1.yahoo.com>
In-Reply-To: <556469.76659.qm@web45605.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711290710.29403.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 29 November 2007, Dell Query wrote:
> I don't know if the document that came with the PPC440EPx Sequoia Resource
> CD is right. It is odd that it is entitled "Embedded Planet 440xC" and it
> showed in page 34:
> -----------------------------------------------------------------------
> Table 4-4. Memory Map
>
>  Function               Start Address   End Address    Size Chip Select
>  DDR SDRAM              0x0000 0000     0x0FFF FFFF  256 MB =E2=80=94
>  PCI Memory             0x8000 0000     0xBFFF FFFF 1024 MB =E2=80=94
>  BCSR                   0xC000 0000     0xCFFF FFFF  256 MB CS2
>  NAND FLASH Controller1 0xD000 0000     0xD00F FFFF    1 MB CS3/CS0
>  NOR FLASH1             0xFC00 0000     0xFFFF FFFF   64 MB CS0/CS3
> -----------------------------------------------------------------------
> Anyway, I have seen Table 1. System Memory Address Map and it got EBC
> mapped at 0x1.c000.0000 and another one at 0x1.f000.0000.  But I didn't s=
ee
> any BCSR info. Correct me if I am wrong, but should it not give me BCSR
> details like:

This is board specific information and not CPU specific. The CPLD with it's=
=20
BCSR is a Sequoia thing and can therefor not be listed in the 440EPx manual=
s.=20
It it located on the EBC though which is documented in the 440EPx manuals.

So if this chips select which is connected to the CPLD is mapped to=20
0xc000.0000 which is the case for Sequoia, then you will "find" these=20
registers at physical address 0x1.c000.0000. And should use ioremap64() to=
=20
get the virtual address to access this CPLD.

Best regards,
Stefan

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
