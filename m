Return-Path: <SRS0=L/Xq=JC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F0C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:40:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34E061392
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34E061392
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDCyt25hLz3hd2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 11:40:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=UxFd1Tip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=UxFd1Tip; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDCZK0zbmz3cYQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Apr 2021 11:22:33 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id e10so560808pls.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Apr 2021 18:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cVXXJ3+5eVqba9QwRIR5tmg1j34fukVhUGM2jj9knwc=;
 b=UxFd1TiplL4W9TdnF/sfU53l0ZIm0lAMZUDx586IddSoDglNkbBjurTTb2jD/AhcfF
 vPb2ju32VhDtbAvA+TL1CP9eFFhmD4qdRlPCOySJBjm5pyCe1EReVkS2pgAgGRz1qXBd
 5/nuhxcWK1a8BLblxevjuX4oo7lbaSoRd+vF6VOMM3vU9aoVrHHugjzCFLk64Oav63TZ
 CoBdFzIA02joFVcbOzrnwUeqLKUsdJBMSnsBhME+dMk/sMSIS3V+1MQ54vHiqTyNH1BG
 cZOojORn6+0CnoOvhdRsoA5nVccISmXsg/xuRARGeZxG78jfk4Nmlb4gGEADtLgXm7a1
 w0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cVXXJ3+5eVqba9QwRIR5tmg1j34fukVhUGM2jj9knwc=;
 b=D2T06YlbnN5j+NS6nf3wsEphvbcegJ8B3x9DFta/x52WDbamR2AqjfGNE2RRqdsE5U
 /E6gNGX1oypkOj7Blbewv7HqKoLQLTDo4Lw6BsD5QF0brHR4k7S07VgYD+y2mQz5uCP7
 9A78GMHjwEInYGN2JH6+qNQ/KtPDRujjLNVhCvcNHQuD1rsK2YWuHrUPi3Cksh3w0o+A
 k5Sg0VXzqytc/ie24FmDDZ+8pPbh1EE/qAqbaTdi8SgyuBlgKC+MUv8AgVO95QsaVdLy
 H4R6DVSn6WDUZfXdUrBBFnOWrXavH7LXb3ffR8WXreoBtpitRnDDbOjIqTL6mB0RDeWJ
 /tCg==
X-Gm-Message-State: AOAM532GNC9jp75em/5sJZrgs6UAj8Jt68Rm/BT7ss2tMvgQhHo3d1Ya
 NIaE1/4tveKD4zaypm+Ne7Y=
X-Google-Smtp-Source: ABdhPJyiPcFFg3gpUzlKShVVdy22TWMQoFv79DmwmX+Zci1OAOGbGS+7VdZgO1zPtQU9sdcmg3FtzA==
X-Received: by 2002:a17:90b:1b42:: with SMTP id
 nv2mr24097499pjb.190.1617585751512; 
 Sun, 04 Apr 2021 18:22:31 -0700 (PDT)
Received: from bobo.ibm.com ([1.132.215.134])
 by smtp.gmail.com with ESMTPSA id e3sm14062536pfm.43.2021.04.04.18.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Apr 2021 18:22:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v6 45/48] KVM: PPC: Book3S HV P9: Reflect userspace hcalls to
 hash guests to support PR KVM
Date: Mon,  5 Apr 2021 11:19:45 +1000
Message-Id: <20210405011948.675354-46-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210405011948.675354-1-npiggin@gmail.com>
References: <20210405011948.675354-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The reflection of sc 1 interrupts from guest PR=1 to the guest kernel is
required to support a hash guest running PR KVM where its guest is
making hcalls with sc 1.

In preparation for hash guest support, add this hcall reflection to the
P9 path. The P7/8 path does this in its realmode hcall handler
(sc_1_fast_return).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d8e36f1ea66d..7cd97e6757e5 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1455,13 +1455,23 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 			 * Guest userspace executed sc 1. This can only be
 			 * reached by the P9 path because the old path
 			 * handles this case in realmode hcall handlers.
-			 *
-			 * Radix guests can not run PR KVM or nested HV hash
-			 * guests which might run PR KVM, so this is always
-			 * a privilege fault. Send a program check to guest
-			 * kernel.
 			 */
-			kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+			if (!kvmhv_vcpu_is_radix(vcpu)) {
+				/*
+				 * A guest could be running PR KVM, so this
+				 * may be a PR KVM hcall. It must be reflected
+				 * to the guest kernel as a sc interrupt.
+				 */
+				kvmppc_core_queue_syscall(vcpu);
+			} else {
+				/*
+				 * Radix guests can not run PR KVM or nested HV
+				 * hash guests which might run PR KVM, so this
+				 * is always a privilege fault. Send a program
+				 * check to guest kernel.
+				 */
+				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+			}
 			r = RESUME_GUEST;
 			break;
 		}
-- 
2.23.0

