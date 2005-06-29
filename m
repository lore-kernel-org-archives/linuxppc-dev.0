Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5F1DF67B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 23:01:18 +1000 (EST)
Date: Wed, 29 Jun 2005 15:01:13 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050629130113.GA30972@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] use correct register names in
	arch/ppc/kernel/relocate_kernel.S
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


CONFIG_KEXEC=y doesnt work:

arch/ppc/kernel/relocate_kernel.S:37: Error: unsupported relocation against SRR1
arch/ppc/kernel/relocate_kernel.S:39: Error: unsupported relocation against SRR0

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.13-rc1/arch/ppc/kernel/relocate_kernel.S
===================================================================
--- linux-2.6.13-rc1.orig/arch/ppc/kernel/relocate_kernel.S
+++ linux-2.6.13-rc1/arch/ppc/kernel/relocate_kernel.S
@@ -34,9 +34,9 @@ relocate_new_kernel:
 
 	mr	r8, r0
 	ori     r8, r8, MSR_RI|MSR_ME
-	mtspr	SRR1, r8
+	mtspr	SPRN_SRR1, r8
 	addi	r8, r4, 1f - relocate_new_kernel
-	mtspr	SRR0, r8
+	mtspr	SPRN_SRR0, r8
 	sync
 	rfi
 
