Return-Path: <bergner@vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C0FBDE08E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 04:31:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n37ILwYa000874
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 14:21:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n37IVl8r153790
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 14:31:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n37IU8bR018992
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 14:30:09 -0400
Subject: Re: [PATCH] powerpc: Fix tlbilx opcode
From: Peter Bergner <bergner@vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <606D70D7-6F85-48DF-854F-18DAE01ACA95@kernel.crashing.org>
References: <1239050219-4477-1-git-send-email-galak@kernel.crashing.org>
	<1239125792.7557.7.camel@otta>
	<606D70D7-6F85-48DF-854F-18DAE01ACA95@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 13:31:46 -0500
Message-Id: <1239129106.7557.10.camel@otta>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Alan Modra <amodra@bigpond.net.au>,
	"binutils@sourceware.org" <binutils@sourceware.org>,
	Edmar Wienskoski-RA8797 <edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-04-07 at 12:54 -0500, Kumar Gala wrote:
> On Apr 7, 2009, at 12:36 PM, Peter Bergner wrote:
> > How do you want to handle the current binutils code that implements tlbilx
> > and its extended mnemonics?  Should they be changed to use secondary opcode
> > 18 instead of 787 as per the ISA 2.06 doc?
> 
> YES ! :)

The ISA 2.06 documentation states the secondary opcode used by tlbilx and
its extended mnemonics is 18 and not 787 which the current code uses.
This patch fixes the typo, as well as reordering the extended mnemonics
so they are listed in the opcodes table before the base tlbilx insn, so
that objdump will attempt to use them before the base insn.

This built and make checks fine, so I committed this as obvious.

Peter


opcodes/
	* ppc-opc.c (powerpc_opcodes) <"tlbilxlpid", "tlbilxpid", "tlbilxva",
	"tlbilx">: Use secondary opcode "18" as per the ISA 2.06 documentation.
	Reorder entries so the extended mnemonics are listed before tlbilx.

gas/testsuite/
	* gas/ppc/e500mc.d: Update to match extended mnemonics.

Index: gas/testsuite/gas/ppc/e500mc.d
===================================================================
RCS file: /cvs/src/src/gas/testsuite/gas/ppc/e500mc.d,v
retrieving revision 1.3
diff -u -p -r1.3 e500mc.d
--- gas/testsuite/gas/ppc/e500mc.d	26 Feb 2009 22:07:33 -0000	1.3
+++ gas/testsuite/gas/ppc/e500mc.d	7 Apr 2009 18:15:23 -0000
@@ -50,7 +50,8 @@ Disassembly of section \.text:
   a0:	7c 64 29 fe 	dcbtstep r3,r4,r5
   a4:	7c c7 42 7e 	dcbtep  r6,r7,r8
   a8:	7c 0b 67 fe 	dcbzep  r11,r12
-  ac:	7c 00 06 26 	tlbilx  0,0,r0
-  b0:	7c 20 06 26 	tlbilx  1,0,r0
-  b4:	7c 62 1e 26 	tlbilx  3,r2,r3
-  b8:	7c 64 2e 26 	tlbilx  3,r4,r5
+  ac:	7c 00 00 24 	tlbilxlpid
+  b0:	7c 20 00 24 	tlbilxpid
+  b4:	7c 62 18 24 	tlbilxva r2,r3
+  b8:	7c 64 28 24 	tlbilxva r4,r5
+
Index: opcodes/ppc-opc.c
===================================================================
RCS file: /cvs/src/src/opcodes/ppc-opc.c,v
retrieving revision 1.120
diff -u -p -r1.120 ppc-opc.c
--- opcodes/ppc-opc.c	2 Apr 2009 13:30:56 -0000	1.120
+++ opcodes/ppc-opc.c	7 Apr 2009 18:15:24 -0000
@@ -3464,6 +3464,11 @@ const struct powerpc_opcode powerpc_opco
 
 {"isellt",	X(31,15),	X_MASK,      PPCISEL,	PPCNONE,	{RT, RA, RB}},
 
+{"tlbilxlpid",	XTO(31,18,0),	XTO_MASK,    E500MC,	PPCNONE,	{0}},
+{"tlbilxpid",	XTO(31,18,1),	XTO_MASK,    E500MC,	PPCNONE,	{0}},
+{"tlbilxva",	XTO(31,18,3),	XTO_MASK,    E500MC,	PPCNONE,	{RA0, RB}},
+{"tlbilx",	X(31,18),	X_MASK,      E500MC,	PPCNONE,	{T, RA0, RB}},
+
 {"mfcr",	XFXM(31,19,0,0), XFXFXM_MASK, POWER4,	PPCNONE,	{RT, FXM4}},
 {"mfcr",	XFXM(31,19,0,0), XRARB_MASK, COM,	POWER4,		{RT}},
 {"mfocrf",	XFXM(31,19,0,1), XFXFXM_MASK, COM,	PPCNONE,	{RT, FXM}},
@@ -4551,10 +4556,6 @@ const struct powerpc_opcode powerpc_opco
 {"lxvw4x",	X(31,780),	XX1_MASK,    PPCVSX,	PPCNONE,	{XT6, RA, RB}},
 
 {"tlbivax",	X(31,786),	XRT_MASK,    BOOKE,	PPCNONE,	{RA, RB}},
-{"tlbilx",	X(31,787),	X_MASK,      E500MC,	PPCNONE,	{T, RA0, RB}},
-{"tlbilxlpid",	XTO(31,787,0),	XTO_MASK,    E500MC,	PPCNONE,	{0}},
-{"tlbilxpid",	XTO(31,787,1),	XTO_MASK,    E500MC,	PPCNONE,	{0}},
-{"tlbilxva",	XTO(31,787,3),	XTO_MASK,    E500MC,	PPCNONE,	{RA0, RB}},
 
 {"lwzcix",	X(31,789),	X_MASK,      POWER6,	PPCNONE,	{RT, RA0, RB}},
 
