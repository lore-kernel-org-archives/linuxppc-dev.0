Return-Path: <sd.mail@laposte.net>
Received: from mx.laposte.net (mx.laposte.net [81.255.54.11])
	by ozlabs.org (Postfix) with ESMTP id 9E8D967A00
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 22:51:45 +1000 (EST)
Received: from smtp.laposte.net (10.150.9.39) by mx.laposte.net (7.2.060.1)
	id 442BB3B901C77DD9 for linuxppc-embedded@ozlabs.org;
	Thu, 4 May 2006 14:30:19 +0200
Received: from laposte.net (10.150.9.77) by smtp.laposte.net (7.3.105.2)
	id 443BAC050100F0BB for linuxppc-embedded@ozlabs.org;
	Thu, 4 May 2006 14:31:14 +0200
Date: Thu,  4 May 2006 14:30:19 +0200
Message-Id: <IYQQQJ$15FC0C241A37525F2DA33CF46BA086DD@laposte.net>
Subject: isa_io_base and _IO_BASE usage
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "sd\.mail" <sd.mail@laposte.net>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
i would like to have some details about isa_io_base and _IO_BASE usage be=
cause i can't access to a PCI-PMC I/O space correctly.
My platform is a PMC board based on MPC85xx (see end of mail to show isa_=
io_base and _IO_BASE configuration).
I have set MPC85XX_PCI1_IO_BASE to 0xF3000000 and MPC85XX_PCI1_IO_SIZE to=
 0x01000000.
I can't correctly access to a PCI-PMC-disk in PIO mode. 
Function ide_inb (in drivers/ide/ide-iops.c function ) produces a trap be=
cause of inb macro add ___IO_BASE =3D _IO_BASE =3D isa_io_mem to port add=
ress.
When trap is produce, port parameter is equal to 0xF3000028, for result t=
o an access on bus to 0xF3000028+0xF3000000 !!!
If i set isa_io_base to 0, my PCI-PMC-disk is recognized and i can use it=
 !
My questions are :
Is-it a good solution to set isa_io_base to 0 ?
Is-it better to set _IO_BASE to 0 and keep isa_io_base =3D hose_a->io_bas=
e_virt ?
Why we add ___IO_BASE in __do_in_asm macro ?

Any suggestion are greatly appreciated.
Thanks, 
Sebastien D.

include/asm-ppc/mpc85xx.h :
---------------------------
#define _IO_BASE isa_io_base
arch/ppc/syslib/ppc85xx_setup.c :
---------------------------------
hose_a->io_space.start =3D MPC85XX_PCI1_LOWER_IO;
hose_a->io_space.end =3D MPC85XX_PCI1_UPPER_IO;
hose_a->io_base_phys =3D MPC85XX_PCI1_IO_BASE;
#ifdef CONFIG_85xx_PCI2
hose_a->io_base_virt =3D ioremap(MPC85XX_PCI1_IO_BASE,
MPC85XX_PCI1_IO_SIZE +
MPC85XX_PCI2_IO_SIZE);
#else
hose_a->io_base_virt =3D ioremap(MPC85XX_PCI1_IO_BASE,
MPC85XX_PCI1_IO_SIZE);
#endif
isa_io_base =3D (unsigned long)hose_a->io_base_virt;
include/asm-ppc/io.h :
----------------------
__do_in_asm(inb, "lbzx")
#define ___IO_BASE ((void __iomem *)_IO_BASE)
#define __do_in_asm(name, op) \
extern __inline__ unsigned int name(unsigned int port) \
{ \
unsigned int x; \
__asm__ __volatile__( \
"0:" op " %0,0,%1\n" \
"1: twi 0,%0,0\n" \
"2: isync\n" \
"3: nop\n" \
"4:\n" \
".section .fixup,\"ax\"\n" \
"5: li %0,-1\n" \
" b 4b\n" \
".previous\n" \
".section __ex_table,\"a\"\n" \
" .align 2\n" \
" .long 0b,5b\n" \
" .long 1b,5b\n" \
" .long 2b,5b\n" \
" .long 3b,5b\n" \
".previous" \
: "=3D&r" (x) \
: "r" (port + ___IO_BASE)); \
return x; \
}=0A=0AAcc=E9dez au courrier =E9lectronique de La Poste : www.laposte.net=
 ; =0A3615 LAPOSTENET (0,34 =80/mn) ; t=E9l : 08 92 68 13 50 (0,34=80/mn)=
=0A=0A
