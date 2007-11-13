Return-Path: <srinavakalav@hcl.in>
Received: from gws04.hcl.in (gws04.hcl.in [203.105.186.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gws04.hcl.in",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6FBD3DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 04:05:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=US-ASCII
Subject: RE: MPC5200B - Mapping Micrel Ethernet Controller Chip
Date: Tue, 13 Nov 2007 22:35:41 +0530
Message-ID: <66E8AEE9980BB44CA5FCAD39EBA56AC602D89B6B@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
From: "Sri nava kala devi Valteti, TLS-Chennai" <srinavakalav@hcl.in>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: "Prakash Palanisamy, TLS-Chennai" <prakashp@hcl.in>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi
Thank you for your response=2E
> Are you *sure* it's mapped at physical address 0xe0000000? (ie=2E have
>you verified that you can access the device registers via u-boot or a
>debugger?) =20

Yes, We have accessed the Micrel chip via U-boot setting (Micrel Chips
Base addres) 0xE0000000 to the CS1 Start address Register=2E
The LP_CS1 pin is configured to access the chip in U-boot=2E


LINUX:
We also probed the CS1 signal and found some noise in the signal (but
wasn't any kind of pulse)=2E It might not be the actual Chip Select pulse=
=2E
But in U-Boot, we are getting proper Chip Select pulse=2E

LINUX:
The MBAR is mapped to default 0xF0000000 value=2E The BAT 2 settings in
the "mpc52xx_set_bat" function, is set to map the 0xf0000000 area=2E=20
Do we need to perform any similar BAT settings or any other settings to
access the IO Device mapped at 0xE0000000 ?


Thanks,
Kala=2E





-----Original Message-----
From: glikely@secretlab=2Eca [mailto:glikely@secretlab=2Eca] On Behalf Of
Grant Likely
Sent: Tuesday, November 13, 2007 9:21 AM
To: Sri nava kala devi Valteti, TLS-Chennai
Cc: linuxppc-embedded@ozlabs=2Eorg; Prakash Palanisamy, TLS-Chennai
Subject: Re: MPC5200B - Mapping Micrel Ethernet Controller Chip

On 11/12/07, Sri nava kala devi Valteti, TLS-Chennai
<srinavakalav@hcl=2Ein> wrote:
>
> We are using MPC5200B based custom board=2E In that we have an external
Micrel's ethernet controller mapped at 0xE0000000=2E
>
> We have taken Lite5200 code as a reference to port linux to our new
board=2E We have integrated the ethernet driver given by the vendor
(Micrel)=2E
>
> Unfortunately, we are not able to access the chip mapped at
0xE0000000=2E

Are you *sure* it's mapped at physical address 0xe0000000? (ie=2E have
you verified that you can access the device registers via u-boot or a
debugger?)  The chip selects on the 5200 are programmable so you need
to make sure that the chip select wired to the Micrel device is
actually configured for base address 0xe0000000=2E

There are up to 8 CS pins on the MPC5200B; LP_CS0 through LP_CS7=2E  See
section 9=2E7=2E1 in the MPC5200B user manual for details on how to
configure them=2E

> We performed the following steps to access the chip:
>
> i) We mapped this address range of the Ethernet Controller Chip in
function "mpc52xx_map_io" as
>
> "io_block_mapping(0xE0000000, 0xE0000000, 0x10000000, _PAGE_IO)"

You don't want to call this=2E  ioremap is the only function you should
need to call=2E  But *first*, you must make sure the CS pin is
configured correctly=2E

Cheers,
g=2E

--=20
Grant Likely, B=2ESc=2E, P=2EEng=2E
Secret Lab Technologies Ltd=2E
grant=2Elikely@secretlab=2Eca
(403) 399-0195

DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have=20
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E

---------------------------------------------------------------------------=
--------------------------------------------
