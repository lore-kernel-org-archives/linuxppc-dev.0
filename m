Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B591C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:57:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9C5206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSNmUj4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9C5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W5wD2LNkzDqWP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 02:57:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W4qV60QgzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:08:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="sSNmUj4i"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W4qV57qqz8tDh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:08:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W4qV4mt4z9sQq; Sat, 30 Mar 2019 02:08:06 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="sSNmUj4i"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W4qV0GqXz9sPv
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 02:08:06 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 615CE2075E;
 Fri, 29 Mar 2019 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553872083;
 bh=Xb0TOBbNJhqmgylS8wR1K+GNui9E6zQ4F8hk3aF13jE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=sSNmUj4iCYrRDYO4ImcczLWanamphMRiEQVoxRtiU11HCz+wiMrxhSZzXauxWrXEX
 b+UxnsvZdGQhtdDcnk3C4uYwhcPDtJ2B2PwZxsl+5A2OhqW7KPKCNO6dJhpJGHwEe9
 dNpY8tO5CcSLjkM04mE8u+2zID5dHKs2XrmIJMPM=
Subject: Patch "powerpc/fsl: Add macro to flush the branch predictor" has been
 added to the 4.19-stable tree
To: christophe.leroy@c-s.fr, diana.craciun@nxp.com, gregkh@linuxfoundation.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2019 16:07:53 +0100
In-Reply-To: <20190329112620.14489-22-mpe@ellerman.id.au>
Message-ID: <155387207391226@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: stable-commits@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    powerpc/fsl: Add macro to flush the branch predictor

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-fsl-add-macro-to-flush-the-branch-predictor.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Mar 29 16:04:51 CET 2019
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 22:26:09 +1100
Subject: powerpc/fsl: Add macro to flush the branch predictor
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linuxppc-dev@ozlabs.org, diana.craciun@nxp.com, msuchanek@suse.de, christophe.leroy@c-s.fr
Message-ID: <20190329112620.14489-22-mpe@ellerman.id.au>

From: Diana Craciun <diana.craciun@nxp.com>

commit 1cbf8990d79ff69da8ad09e8a3df014e1494462b upstream.

The BUCSR register can be used to invalidate the entries in the
branch prediction mechanisms.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/ppc_asm.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -821,4 +821,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	stringify_in_c(.long (_target) - . ;)	\
 	stringify_in_c(.previous)
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define BTB_FLUSH(reg)			\
+	lis reg,BUCSR_INIT@h;		\
+	ori reg,reg,BUCSR_INIT@l;	\
+	mtspr SPRN_BUCSR,reg;		\
+	isync;
+#else
+#define BTB_FLUSH(reg)
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 #endif /* _ASM_POWERPC_PPC_ASM_H */


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.19/powerpc-fsl-emulate-sprn_bucsr-register.patch
queue-4.19/powerpc-fsl-flush-the-branch-predictor-at-each-kernel-entry-64bit.patch
queue-4.19/powerpc-fsl-update-spectre-v2-reporting.patch
queue-4.19/powerpc-fsl-add-macro-to-flush-the-branch-predictor.patch
queue-4.19/powerpc-security-fix-spectre_v2-reporting.patch
queue-4.19/powerpc-fsl-fix-the-flush-of-branch-predictor.patch
queue-4.19/powerpc-fsl-enable-runtime-patching-if-nospectre_v2-boot-arg-is-used.patch
queue-4.19/powerpc-fsl-fixed-warning-orphan-section-__btb_flush_fixup.patch
queue-4.19/powerpc-fsl-add-nospectre_v2-command-line-argument.patch
queue-4.19/powerpc-fsl-add-infrastructure-to-fixup-branch-predictor-flush.patch
queue-4.19/powerpc-fsl-flush-the-branch-predictor-at-each-kernel-entry-32-bit.patch
queue-4.19/powerpc-fsl-flush-branch-predictor-when-entering-kvm.patch
