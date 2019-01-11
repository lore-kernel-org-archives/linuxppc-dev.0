Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F9C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:26:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228EA20685
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="T0dUY1P/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228EA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bSvS5hdJzDr0Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:26:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.74; helo=conuserg-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="T0dUY1P/"; 
 dkim-atps=neutral
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bSqw2sydzDqwN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 14:23:24 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x0B3MdXc025916;
 Fri, 11 Jan 2019 12:22:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0B3MdXc025916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547176961;
 bh=JdaoxAp2zwSgj1fS+WdPKkEOeUpHHRiHMaWEvwP1TVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T0dUY1P/e9rE6AczJFmqaVz7HSGy2sJxCdVBdYk30Ys7g4FeBYyu9fNRNyIC1s7lZ
 u2dzFERf6wxAED80Drp7RSMjn96XQywIDUUBoSLw8cG8ePzF3hwAANuVBa9d9MNAZL
 /ZlYOcNQsZv74w0ueVETyDM6RntuG/UdLIbsujKhR32+O5UpA/StaxoZcdsSkBjZQp
 Gl8CMY1YmymqTNIKOmeLGRTmr0iThX+ji8VOTXClILMY+kZIiBkyzgJN2Mb+S5tFQo
 O6aoHLctLw1L4r2aY2OibmSvMTjSHhkgN2vS/jV7a85NydKPErSgJrWI8fI/QlZ2nw
 A7822+nZ87XGQ==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] KVM: powerpc: remove -I. header search paths
Date: Fri, 11 Jan 2019 12:22:31 +0900
Message-Id: <1547176954-17739-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The header search path -I. in kernel Makefiles is very suspicious;
it allows the compiler to search for headers in the top of $(srctree),
where obviously no header file exists.

Commit 46f43c6ee022 ("KVM: powerpc: convert marker probes to event
trace") first added these options, but they are completely useless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/kvm/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 64f1135..3223aec 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -10,11 +10,6 @@ common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o
 common-objs-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
 common-objs-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
 
-CFLAGS_e500_mmu.o := -I.
-CFLAGS_e500_mmu_host.o := -I.
-CFLAGS_emulate.o  := -I.
-CFLAGS_emulate_loadstore.o  := -I.
-
 common-objs-y += powerpc.o emulate_loadstore.o
 obj-$(CONFIG_KVM_EXIT_TIMING) += timing.o
 obj-$(CONFIG_KVM_BOOK3S_HANDLER) += book3s_exports.o
-- 
2.7.4

