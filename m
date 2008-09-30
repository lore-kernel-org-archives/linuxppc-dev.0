Return-Path: <mohan@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1FA7DE371
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 22:56:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8UCuQj2005889
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 08:56:26 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8UCuQk5071162
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:56:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8UCtsqD010378
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:55:56 -0600
Date: Tue, 30 Sep 2008 18:26:21 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: kexec@lists.infradead.org
Subject: [PATCH] Relocatable kdump kernel support in kexec-tools
Message-ID: <20080930125621.GC1945@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Relocatable kdump kernel support in kexec-tools

This patch adds relocatable kernel support for kdump in the kexec-tools
code. A signature (0xfeed1234) is passed in r6 from panic code to the
purgatory code through kexec_sequence function. The signature is used to
differentiate between relocatable kdump kernel and non-kdump kernels.

The purgatory code compares the signature and sets the __kdump_flag in
head_64.S by using the offset with respect to next kernel load address.
During the boot up, kernel code checks __kdump_flag and if it is set, the
kernel will behave as relocatable kdump kernel.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index b3563de..f69dad2 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -45,6 +45,7 @@
 	oris    rn,rn,name##@h;         \
 	ori     rn,rn,name##@l
 
+#define KDUMP_SIGNATURE 0xfeed1234
 
 	.machine ppc64
 	.globl purgatory_start
@@ -64,6 +65,7 @@ master:
 	isync
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
+	mr      18,6            # save kdump flag in reg18
 
 	LOADADDR(6,my_toc)
 	ld      2,0(6)          #setup toc
@@ -94,6 +96,12 @@ master:
 	mtctr	4		# prepare branch too
 	mr      3,16            # restore dt address
 
+	LOADADDR(6,KDUMP_SIGNATURE)
+	cmpd	18,6
+	bne	regular
+	li	7,1
+	std	7,24(4)		# mark kdump flag at kernel
+regular:
 	lwz	7,0(4)		# get the first instruction that we stole
 	stw	7,0(0)		# and put it in the slave loop at 0
 				# skip cache flush, do we care?
