Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6415AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 19:07:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B6860F41
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 19:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3B6860F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpNvP0fcNz3cLw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 05:07:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mpi6Ef+m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=nathan@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mpi6Ef+m; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpNth6Zvxz2yR8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 05:06:36 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB6860EAF;
 Mon, 16 Aug 2021 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629140793;
 bh=gbVkho5GRcWxEMUkS1t6U/1oMavMPJ9b9Lt9m90EGU8=;
 h=From:To:Cc:Subject:Date:From;
 b=mpi6Ef+mJXSBdBWk+F+3oijcYsOfFhmL3URC5d3XPE7wskFuT2pd6bCz9L5Vpw7zN
 y92eb7fakfdglM9mf7/VL9y2fqFWBQ8FjLFeHIS8Q4qrmUgG7TTBMCYFmMD16f9aDf
 QRbYI43+dnN7lOB1ms0Au97mb8AWWk3QZgiau+w/vcyHEPMhbwDzwYwq3f3vq6IOdi
 +AAGWWpB8SNwHcbS6HB5Ti4lSn1wJizoC9RqX5cVe0yFOL6kjJXYMIEDTrYn+ZShoi
 AJO/d5P60WWywzAgiMlKINJrSgrDzOVS4YG1Vp8oZrT2xI+mHU9E4kc6YwBzsNd6Qz
 JQSOVu3IyfvXA==
From: Nathan Chancellor <nathan@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/xive: Do not mark xive_request_ipi() as __init
Date: Mon, 16 Aug 2021 11:57:11 -0700
Message-Id: <20210816185711.21563-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Compiling ppc64le_defconfig with clang-14 shows a modpost warning:

WARNING: modpost: vmlinux.o(.text+0xa74e0): Section mismatch in
reference from the function xive_setup_cpu_ipi() to the function
.init.text:xive_request_ipi()
The function xive_setup_cpu_ipi() references
the function __init xive_request_ipi().
This is often because xive_setup_cpu_ipi lacks a __init
annotation or the annotation of xive_request_ipi is wrong.

xive_request_ipi() is called from xive_setup_cpu_ipi(), which is not
__init, so xive_request_ipi() should not be marked __init. Remove the
attribute so there is no more warning.

Fixes: cbc06f051c52 ("powerpc/xive: Do not skip CPU-less nodes when creating the IPIs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 943fd30095af..8183ca343675 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1170,7 +1170,7 @@ static int __init xive_init_ipis(void)
 	return ret;
 }
 
-static int __init xive_request_ipi(unsigned int cpu)
+static int xive_request_ipi(unsigned int cpu)
 {
 	struct xive_ipi_desc *xid = &xive_ipis[early_cpu_to_node(cpu)];
 	int ret;

base-commit: a2824f19e6065a0d3735acd9fe7155b104e7edf5
-- 
2.33.0.rc2

