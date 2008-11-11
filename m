Return-Path: <rajasekaran.k@hcl.in>
Received: from gws03.hcl.in (gws03.mail.hcl.in [203.105.186.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gws03.hcl.in",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BE6DCDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Nov 2008 20:34:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: Using DMA
Date: Tue, 11 Nov 2008 14:39:38 +0530
Message-ID: <6317656E41CC2249B682A3DA9BA1E9002C878E@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
In-Reply-To: <OF23CBF910.0133035A-ON882574FD.0061E950-882574FD.0062B6DE@selinc.com>
References: <491846A9.8080709@freescale.com>
	<OF23CBF910.0133035A-ON882574FD.0061E950-882574FD.0062B6DE@selinc.com>
From: "Rajasekaran Kaliyaperumal,  Chennai" <rajasekaran.k@hcl.in>
To: <Bruce_Leonard@selinc.com>, "Timur Tabi" <timur@freescale.com>
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



HI,=20

I would like to port a linux kernel to a 8051 Microcontroller
C8051F120(128kB flash memory 8KB Ram )=2E=20

Is this really possible?=20

What book would help me in porting a linux kernel to a modest
microcontroller such as 8051?=20

Any help would be greatly appreciated


Thanks in Advance=20
   K=2ERajasekaran=2E
-----Original Message-----
From: linuxppc-embedded-bounces+rajasekaran=2Ek=3Dhcl=2Ein@ozlabs=2Eorg
[mailto:linuxppc-embedded-bounces+rajasekaran=2Ek=3Dhcl=2Ein@ozlabs=2Eorg]=
 On
Behalf Of Bruce_Leonard@selinc=2Ecom
Sent: Monday, November 10, 2008 11:29 PM
To: Timur Tabi
Cc: timur=2Etabi@gmail=2Ecom; linuxppc-embedded@ozlabs=2Eorg
Subject: Re: Using DMA

Timur Tabi <timur@freescale=2Ecom> wrote on 11/10/2008 06:35:21 AM:

> Bruce_Leonard@selinc=2Ecom wrote:
>=20
> > Is there something else I need to do?  Or is there something wrong=20
with my=20
> > device tree (always a possibility :)  )=2E  Any help is appreciated=2E
>=20
> You might need to add something like this:
>=20
> static struct of_device_id __initdata mpc8610_ids[] =3D {
>          { =2Ecompatible =3D "fsl,mpc8610-immr", },
>          { =2Ecompatible =3D "simple-bus", },
>          {}
> };
> static int __init mpc8610_declare_of_platform_devices(void)
> {
>          /* Without this call, the SSI device driver won't get probed=2E

*/
>          of_platform_bus_probe(NULL, mpc8610_ids, NULL);
>          return 0;
> }
> machine_device_initcall(mpc86xx_hpcd,=20
mpc8610_declare_of_platform_devices);
>=20
> --=20
> Timur Tabi
> Linux Kernel Developer @ Freescale

Something like that already exists in=20
/arch/powerpc/platforms/83xx/mpc834x_itx=2Ec, which I'm using=2E  Only real=
=20
difference is the first compatible flag is:

=2E=2Ecompatible =3D "fsl,pq2pro-localbus"

Which I presume is correct since other drivers load and work correctly=20
based on what's in the device tree=2E

Bruce
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs=2Eorg
https://ozlabs=2Eorg/mailman/listinfo/linuxppc-embedded

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
 is strictly prohibited=2E If you have
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E

---------------------------------------------------------------------------=
--------------------------------------------
