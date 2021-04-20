Return-Path: <SRS0=xixs=JR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848EFC433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 19:04:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A3F613D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 19:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A3F613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FPtR5231Dz2ysq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 05:04:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=q+9hg0E+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=q+9hg0E+; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FPtQG11s4z2yZC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 05:04:05 +1000 (AEST)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id DD5FD20B8002;
 Tue, 20 Apr 2021 12:04:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD5FD20B8002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1618945444;
 bh=GohHPxZNM/O59OuHx4wz3PzFEFX8BxLA8/Ko41CG6NY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q+9hg0E+rSJkkQ86Ia1lPStRGxfsmvHnB0l5Tsv7+Oc6/Sf6LEcsgC+XugB03Xoep
 ShOchkZO5Fj567ONB1z4I1UqomucAQC8MS9jMalxMXCKa9PGAFnuBFJ9clL5rD26c9
 els+9/pYVxrbhSiZB7+08tWzvvspRwz8twk2r9lo=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: robh@kernel.org,
	dan.carpenter@oracle.com,
	mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc: If kexec_build_elf_info() fails return
 immediately from elf64_load()
Date: Tue, 20 Apr 2021 12:03:55 -0700
Message-Id: <20210420190355.10059-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210420190355.10059-1-nramas@linux.microsoft.com>
References: <20210420190355.10059-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: devicetree@vger.kernel.org, kbuild-all@lists.01.org, lkp@intel.com,
 nramas@linux.microsoft.com, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Uninitialized local variable "elf_info" would be passed to
kexec_free_elf_info() if kexec_build_elf_info() returns an error
in elf64_load().

If kexec_build_elf_info() returns an error, return the error
immediately.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/powerpc/kexec/elf_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 02662e72c53d..eeb258002d1e 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -45,7 +45,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
 	ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
 	if (ret)
-		goto out;
+		return ERR_PTR(ret);
 
 	if (image->type == KEXEC_TYPE_CRASH) {
 		/* min & max buffer values for kdump case */
-- 
2.31.0

