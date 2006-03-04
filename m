Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55F8E679FC
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 23:15:46 +1100 (EST)
Date: Sat, 4 Mar 2006 13:15:40 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] correct cacheflush loop in zImage
Message-ID: <20060304121540.GA30106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Correct the loop for cacheflush. No idea where I copied the code from,
but the original does not work correct. Maybe the flush is not needed.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/boot/crt0.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc5-olh/arch/powerpc/boot/crt0.S
===================================================================
--- linux-2.6.16-rc5-olh.orig/arch/powerpc/boot/crt0.S
+++ linux-2.6.16-rc5-olh/arch/powerpc/boot/crt0.S
@@ -45,7 +45,8 @@ _zimage_start:
 	bdnz	2b
 
 	/* Do a cache flush for our text, in case OF didn't */
-3:	lis	r9,_start@h
+3:	lis	r9,_start@ha
+	addi	r9,r9,_start@l
 	add	r9,r0,r9
 	lis	r8,_etext@ha
 	addi	r8,r8,_etext@l
@@ -53,7 +54,7 @@ _zimage_start:
 4:	dcbf	r0,r9
 	icbi	r0,r9
 	addi	r9,r9,0x20
-	cmplwi	0,r9,8
+	cmplw	cr0,r9,r8
 	blt	4b
 	sync
 	isync
