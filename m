Return-Path: <SRS0=YiAJ=HX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C8C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 17:55:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DEC64EE6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 17:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DEC64EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DkCdN1bQmz3dcR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 04:55:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=tE2Do87Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=tE2Do87Y; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DkCWF3H4Sz3cGD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2021 04:49:45 +1100 (AEDT)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 10A3520B57AA;
 Sun, 21 Feb 2021 09:49:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10A3520B57AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1613929784;
 bh=O9olzA4F8wOx+jGLw6qdo8GKMGxvb6BX+udmR/nonSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tE2Do87YmsnzqiU9jjBbsx1Ji8zTOuLkFwj6q0XO71jHqVEusqeSa80K27M9hxhhT
 QI9HNULJZB9K08wc+NSAExED+UY4GNhNTILzIyrs6bsVXzzaHbC03+/BpNA2eG5Hqz
 u/ziu6jWcPiqxF3EQ6lM+ZF1cuYcFORY80ea5e8g=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
 takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, will@kernel.org,
 joe@perches.com, catalin.marinas@arm.com, mpe@ellerman.id.au,
 sfr@canb.auug.org.au
Subject: [PATCH v19 12/13] powerpc: Delete unused function delete_fdt_mem_rsv()
Date: Sun, 21 Feb 2021 09:49:29 -0800
Message-Id: <20210221174930.27324-13-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221174930.27324-1-nramas@linux.microsoft.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
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
Cc: mark.rutland@arm.com, tao.li@vivo.com, paulus@samba.org,
 vincenzo.frascino@arm.com, frowand.list@gmail.com, sashal@kernel.org,
 masahiroy@kernel.org, jmorris@namei.org, allison@lohutok.net, serge@hallyn.com,
 devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
 mbrugger@suse.com, balajib@linux.microsoft.com, dmitry.kasatkin@gmail.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

delete_fdt_mem_rsv() defined in "arch/powerpc/kexec/file_load.c"
has been renamed to fdt_find_and_del_mem_rsv(), and moved to
"drivers/of/kexec.c".

Remove delete_fdt_mem_rsv() in "arch/powerpc/kexec/file_load.c".

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h |  1 -
 arch/powerpc/kexec/file_load.c   | 32 --------------------------------
 2 files changed, 33 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 1af7b5962bb9..e881e9d083ce 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -115,7 +115,6 @@ char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr);
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 
 #ifdef CONFIG_PPC64
 struct kexec_buf;
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index dc28cb7813c8..4284f76cbef5 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -107,35 +107,3 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 
 	return 0;
 }
-
-/**
- * delete_fdt_mem_rsv - delete memory reservation with given address and size
- *
- * Return: 0 on success, or negative errno on error.
- */
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
-{
-	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
-
-	for (i = 0; i < num_rsvs; i++) {
-		uint64_t rsv_start, rsv_size;
-
-		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
-		if (ret) {
-			pr_err("Malformed device tree.\n");
-			return -EINVAL;
-		}
-
-		if (rsv_start == start && rsv_size == size) {
-			ret = fdt_del_mem_rsv(fdt, i);
-			if (ret) {
-				pr_err("Error deleting device tree reservation.\n");
-				return -EINVAL;
-			}
-
-			return 0;
-		}
-	}
-
-	return -ENOENT;
-}
-- 
2.30.0

