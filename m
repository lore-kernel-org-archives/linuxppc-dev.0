Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CECC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:14:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930AA218A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il5TnmdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930AA218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W6Hw6B98zDqWb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:14:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W4r25xnvzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:08:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Il5TnmdR"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W4r24xD5z8tDh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:08:34 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W4r24NfXz9sQr; Sat, 30 Mar 2019 02:08:34 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Il5TnmdR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W4r20fC5z9sPx
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 02:08:34 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20DCF2075E;
 Fri, 29 Mar 2019 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553872112;
 bh=sdRevPeV7ZbTp7ccFOLYHCglpbXQzdMSXeztS2bwmjM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Il5TnmdRC+8OEGJ/yIVMKlCaqLEp8CKC8fnMhFAZZ9jyNPzNnob92Ez6Xu4C4TNs6
 9xwL5LLQ3pGyUnUaGuTJ0UBwG4dht7Kdroex25orTt2ILIdPNt4+86QbmVx1BPvF4n
 2hfJIjwc5yFmOU/nnb3POISm2BHEqUwOnKEdqFJc=
Subject: Patch "powerpc/security: Fix spectre_v2 reporting" has been added to
 the 4.19-stable tree
To: christophe.leroy@c-s.fr, diana.craciun@nxp.com, gregkh@linuxfoundation.org,
 linuxppc-dev@ozlabs.org, mikey@neuling.org, mpe@ellerman.id.au,
 msuchanek@suse.de
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2019 16:07:54 +0100
In-Reply-To: <20190329112620.14489-33-mpe@ellerman.id.au>
Message-ID: <155387207411157@kroah.com>
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

    powerpc/security: Fix spectre_v2 reporting

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-security-fix-spectre_v2-reporting.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Mar 29 16:04:51 CET 2019
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 22:26:20 +1100
Subject: powerpc/security: Fix spectre_v2 reporting
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linuxppc-dev@ozlabs.org, diana.craciun@nxp.com, msuchanek@suse.de, christophe.leroy@c-s.fr
Message-ID: <20190329112620.14489-33-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit 92edf8df0ff2ae86cc632eeca0e651fd8431d40d upstream.

When I updated the spectre_v2 reporting to handle software count cache
flush I got the logic wrong when there's no software count cache
enabled at all.

The result is that on systems with the software count cache flush
disabled we print:

  Mitigation: Indirect branch cache disabled, Software count cache flush

Which correctly indicates that the count cache is disabled, but
incorrectly says the software count cache flush is enabled.

The root of the problem is that we are trying to handle all
combinations of options. But we know now that we only expect to see
the software count cache flush enabled if the other options are false.

So split the two cases, which simplifies the logic and fixes the bug.
We were also missing a space before "(hardware accelerated)".

The result is we see one of:

  Mitigation: Indirect branch serialisation (kernel only)
  Mitigation: Indirect branch cache disabled
  Mitigation: Software count cache flush
  Mitigation: Software count cache flush (hardware accelerated)

Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache flush")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -189,29 +189,22 @@ ssize_t cpu_show_spectre_v2(struct devic
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
 
-	if (bcs || ccd || count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
-		bool comma = false;
+	if (bcs || ccd) {
 		seq_buf_printf(&s, "Mitigation: ");
 
-		if (bcs) {
+		if (bcs)
 			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
-			comma = true;
-		}
 
-		if (ccd) {
-			if (comma)
-				seq_buf_printf(&s, ", ");
-			seq_buf_printf(&s, "Indirect branch cache disabled");
-			comma = true;
-		}
-
-		if (comma)
+		if (bcs && ccd)
 			seq_buf_printf(&s, ", ");
 
-		seq_buf_printf(&s, "Software count cache flush");
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else if (count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
+		seq_buf_printf(&s, "Mitigation: Software count cache flush");
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, "(hardware accelerated)");
+			seq_buf_printf(&s, " (hardware accelerated)");
 	} else if (btb_flush_enabled) {
 		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
 	} else {


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
