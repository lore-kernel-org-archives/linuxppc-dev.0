Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 05ED0DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 23:07:17 +1100 (EST)
Message-ID: <47344D70.4050308@fz-juelich.de>
Date: Fri, 09 Nov 2007 13:07:12 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: MingLiu <eemingliu@hotmail.com>
Subject: Re: Bootloader & Flash
References: <4731A8E3.4020909@fz-juelich.de>
	<BAY138-W14EEE9667CD669878D3BD0B28A0@phx.gbl>
In-Reply-To: <BAY138-W14EEE9667CD669878D3BD0B28A0@phx.gbl>
Content-Type: text/plain;
	charset=UTF-8
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

Hi again,

i've learned a little bit :)

- I have download the zImage.elf via the EDK flash loader
- The flash loader creates a bootloader, this is also running on start up=
 :)

But ... It stops with an error-message after a few seconds:

EDK Bootloader:
Bootloader: Processed (0x)000000b2 S-recordsERROR: SREC line is corrupted=


What now ?

Georg


MingLiu wrote:
> Dear Georg,
> I guess you were talking about the booting process of the system, both =
HW and the SW, from the flash memory. This process should be like this:
>
> 1. Store your HW bitstream and Linux kernel in flash memories. If neede=
d, perhaps you want another bootloader program, such as U-boot also insid=
e.=20
>
> 2. In your HW bitstream, you need one bootloader which helps you to loa=
d the software and execute it in DDR-ram. EDK helps you to generate such =
a bootloader when you design.=20
>
> 3. Durong Power on, HW bitstream (with an EDK bootloader included) will=
 be loaded into FPGA and configure the FPGA, then the EDK bootloader will=
 load your Linux kernel into DDR-Ram and execute it there. Thus your linu=
x could run.=20
>
> This is a normal process. If you want to execute the program in flash d=
irectly, that's another story. Also you should know, for the booting proc=
ess, MTD driver is not necessary. The driver is only used when you want t=
o access flash memories when you booted your Linux kernel.
>
> Clear or not? :)
>
> Best Regards
> Ming
>
> ----------------------------------------> Date: Wed, 7 Nov 2007 13:00:3=
5 +0100> From: g.schardt@fz-juelich.de> To: Linuxppc-embedded@ozlabs.org>=
 Subject: Bootloader & Flash>> Hi,>> i use the AVnet Xilinx4 FX12 Minimod=
ule and until now, i use system-ace> to configure the fpga and boot the l=
inux kernel.> But now, i want to boot from the on board flash memory and =
have no idea> where to start.>> I think i have to:> - save the fpga confi=
guration in the fpga-prom> - use/program some kind of bootloader store in=
 fpga block ram to jump to> the flash-adress where the executable linux k=
ernel resist> - use the mtd-device driver to mount root fs on the same fl=
ash some> address later>> Is this the right way ?>>> Regards> Georg>>>>>>=
> -----------------------------------------------------------------------=
------------------> -----------------------------------------------------=
------------------------------------> Forschungszentrum J=C3=BClich GmbH>=
 52425 J=C3=BClich>> Sitz der Gesellschaft: J=C3=BClich> Eingetragen im H=
andelsregister des Amtsgerichts D=C3=BCren Nr. HR B 3498> Vorsitzende des=
 Aufsichtsrats: MinDirig'in B=C3=A4rbel Brumme-Bothe> Gesch=C3=A4ftsf=C3=BC=
hrung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv.>=
 Vorsitzender)> ---------------------------------------------------------=
--------------------------------> ---------------------------------------=
--------------------------------------------------> _____________________=
__________________________> Linuxppc-embedded mailing list> Linuxppc-embe=
dded@ozlabs.org> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> _________________________________________________________________
> MSN =E4=B8=AD=E6=96=87=E7=BD=91=EF=BC=8C=E6=9C=80=E6=96=B0=E6=97=B6=E5=B0=
=9A=E7=94=9F=E6=B4=BB=E8=B5=84=E8=AE=AF=EF=BC=8C=E7=99=BD=E9=A2=86=E8=81=9A=
=E9=9B=86=E9=97=A8=E6=88=B7=E3=80=82
> http://cn.msn.com


=0A=0A-------------------------------------------------------------------------=

----------------=0A-----------------------------------------------------------=

------------------------------=0AForschungszentrum J=C3=BClich GmbH=0A52425 J=C3=BClich=

=0A=0ASitz der Gesellschaft: J=C3=BClich=0AEingetragen im Handelsregister des Amtsgeri=

chts D=C3=BCren Nr. HR B 3498=0AVorsitzende des Aufsichtsrats: MinDirig'in B=C3=A4rbel=

 Brumme-Bothe=0AGesch=C3=A4ftsf=C3=BChrung: Prof. Dr. Achim Bachem (Vorsitzender), Dr.=

 Ulrich Krafft (stellv. =0AVorsitzender)=0A-------------------------------------=

----------------------------------------------------=0A-----------------------=

------------------------------------------------------------------=0A
