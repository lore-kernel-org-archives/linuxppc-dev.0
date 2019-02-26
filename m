Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D1C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 22:24:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963072146F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 22:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="dEsxM1sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963072146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Czq1Pw8zDqMr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:24:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Cy051Q2zDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 09:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="dEsxM1sT"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 448Cy01g9Yz9s71; Wed, 27 Feb 2019 09:23:20 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 448Cy00tV5z9s7T; Wed, 27 Feb 2019 09:23:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551219800; bh=1z5BkuyLmhCXAyZkpQABOgmNlHdnLQFxvBIbmrNeO1M=;
 h=Date:From:To:Cc:Subject:From;
 b=dEsxM1sTt3QPt53XUZnyNlud7n+Si1+Il9O/ytbmBzDr1LpOxSSVYuGfw3F0iBSfh
 OgAgf6UQTkslXTpVK4Wn+CX28g2NhLzFGBcQHy9dUkB6zIkdG4RBFbPObtCom49EtR
 fS5q+CcAzbHbrWLnOBV0Qd/ZTewnr8gKPPLHO4fpigpGbUG7hNj/+lDRCRxyfEdDCC
 HNcVUH3GZK89qVzgufw3eCAGsxPpLvUSq3K9TIoX77Xapbx5vYVU1TgqiI5H+81+w2
 4MjaE2I3Ch9qLABvLvz8a/Wf1u5yCQRGRxKjOq09T2YhicQHHxryfRr0k+Ftp8O9HG
 dCJe9M6eLw/IQ==
Date: Wed, 27 Feb 2019 09:21:56 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Fix compilation when KVM is not enabled
Message-ID: <20190226222156.GD28015@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Compiling with CONFIG_PPC_POWERNV=y and KVM disabled currently gives
an error like this:

  CC      arch/powerpc/kernel/dbell.o
In file included from arch/powerpc/kernel/dbell.c:20:0:
arch/powerpc/include/asm/kvm_ppc.h: In function ‘xics_on_xive’:
arch/powerpc/include/asm/kvm_ppc.h:625:9: error: implicit declaration of function ‘xive_enabled’ [-Werror=implicit-function-declaration]
  return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
         ^
cc1: all warnings being treated as errors
scripts/Makefile.build:276: recipe for target 'arch/powerpc/kernel/dbell.o' failed
make[3]: *** [arch/powerpc/kernel/dbell.o] Error 1

Fix this by making the xics_on_xive() definition conditional on the
same symbol (CONFIG_KVM_BOOK3S_64_HANDLER) that determines whether we
include <asm/xive.h> or not, since that's the header that defines
xive_enabled().

Fixes: 03f953329bd8 ("KVM: PPC: Book3S: Allow XICS emulation to work in nested hosts using XIVE")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index d283d31..ac22b28 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -619,7 +619,7 @@ static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 ir
 static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
 #endif /* CONFIG_KVM_XIVE */
 
-#ifdef CONFIG_PPC_POWERNV
+#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_KVM_BOOK3S_64_HANDLER)
 static inline bool xics_on_xive(void)
 {
 	return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
-- 
2.7.4

