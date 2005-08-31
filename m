Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 7D87368202
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 22:35:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 31 Aug 2005 14:35:02 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B54@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Export assembly symbols
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody, I need your help again.
I'm desesperatly tryin to insert some new assembly code in the
linux montavista sources PE 3.1 for a ppc 405EP.=20
What I'd like to do is to have, in my kernel source file "myfile.S", two
assembly functions and export those symbols to the ksyms table.
The final point for me is to make those symbols availabale for
modules loading.
The functions definition in "myfile.S" is the one below:

/*
 myfile.S : DESCRIPTION
This module contains chip-dependent routines written in assembly =
language.
*/
#include <linux/config.h>
#include <linux/sys.h>
#include <linux/threads.h>
#include <asm/processor.h>
#include <asm/page.h>
#include <asm/mmu.h>
#include <asm/cputable.h>
#include <asm/ppc_asm.h>
#include <asm/errno.h>
#include <asm/ppc_asm.h>
#include "myfile.h"
                =20
#define _ASMLANGUAGE
   =20
       .globl  stas_Read_TBl_F
       .globl  stas_Set_TBl_F
           .text

       =
/************************************************************************=
******
       * stas_Read_TBl_F : This function returns the content of TBL.
       * uLong stas_Read_TBl_F(void)
       =
*************************************************************************=
*****/
_GLOBAL(stas_Read_TBl_F)
              mftb r3
              nop
              nop
              nop
              blr

       =
/************************************************************************=
******
       * stas_Set_TBl_F : This function is used to set the TBL.=20
       * void stas_Set_TBl_F(uLong)
       =
*************************************************************************=
*****/
_GLOBAL(stas_Set_TBl_F)
             mttbl r3
             nop
             nop
             nop
             blr


Due to a modified Linux Makefile, it is compiled by the kernel with this =
command line:

ppc_405-gcc -D__ASSEMBLY__ -D__KERNEL__ =
-I/myWorks/en-cours/linux-2.4.20_mvl31/include   [...]
-I/myWorks/en-cours/linux-2.4.20_mvl31/arch/ppc -Wa,-m405  -c -o =
myfile.o myfile.S

What do I have to do to get both functions in the symbols table when =
reading/proc/ksyms.
Is there a specific way to do for ppc?=20

Please help me cause I can't finf any info on that browsing the web.
Tks a lot for your precious help

J=E9r=E9mie
