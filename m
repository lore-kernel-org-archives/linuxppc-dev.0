Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC3F668748
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 08:09:08 +1100 (EST)
Date: Thu, 17 Nov 2005 22:09:02 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051117210902.GB31775@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] ppc boot: replace string labels with numbers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Replacing the string labels with numbers saves 117 bytes in the final zImage.
These local labels are not discared.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/boot/crt0.S |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6.15-rc1-olh/arch/powerpc/boot/crt0.S
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/boot/crt0.S
+++ linux-2.6.15-rc1-olh/arch/powerpc/boot/crt0.S
@@ -14,43 +14,42 @@
 	.text
 	.globl	_zimage_start
 _zimage_start:
-	bl	reloc_offset
+	bl	1f
 
-reloc_offset:
+1:
 	mflr	r0
-	lis	r9,reloc_offset@ha
-	addi	r9,r9,reloc_offset@l
+	lis	r9,1b@ha
+	addi	r9,r9,1b@l
 	subf.	r0,r9,r0
-	beq	clear_caches
+	beq	3f
 
-reloc_got2:
 	lis	r9,__got2_start@ha
 	addi	r9,r9,__got2_start@l
 	lis	r8,__got2_end@ha
 	addi	r8,r8,__got2_end@l
 	subf.	r8,r9,r8
-	beq	clear_caches
+	beq	3f
 	srwi.	r8,r8,2
 	mtctr	r8
 	add	r9,r0,r9
-reloc_got2_loop:
+2:
 	lwz	r8,0(r9)
 	add	r8,r8,r0
 	stw	r8,0(r9)
 	addi	r9,r9,4
-	bdnz	reloc_got2_loop
+	bdnz	2b
 
-clear_caches:
+3:
 	lis	r9,_start@h
 	add	r9,r0,r9
 	lis	r8,_etext@ha
 	addi	r8,r8,_etext@l
 	add	r8,r0,r8
-1:	dcbf	r0,r9
+4:	dcbf	r0,r9
 	icbi	r0,r9
 	addi	r9,r9,0x20
 	cmplwi	0,r9,8
-	blt	1b
+	blt	4b
 	sync
 	isync
 
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
