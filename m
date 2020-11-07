Return-Path: <SRS0=O+98=EN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF12EC55178
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 15:51:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02020888
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 15:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avtEcUhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02020888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CT1vv6XL6zDrTs
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 02:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=xiakaixu1987@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=avtEcUhN; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CT1sn1nCqzDr0l
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2020 02:49:47 +1100 (AEDT)
Received: by mail-pj1-x1042.google.com with SMTP id w7so931069pjy.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2020 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7/TyYiy/5YMk+mjNioNCBNSjuP8QdrV8gyWB7vm7Ee4=;
 b=avtEcUhNqqjSLS+EfsY67zoE0Imvh3Z3/y6Wsw5xHsCv73Hd4peccJ36/5aVb323I3
 5oCoomgspQUWmEb13n/G5tmvMcW8WmJiGjld9PjBt26OZW1EnEB6GwI9Ns3qufY4ufVp
 ErvInhBCZgV6lxRIa1lDHBn4upauaOGfb0xU7sadmgK3Rq7fPIs6+tXrJXQo2J+bxs25
 LhUAq70ib5Ym486IWNzK0x1y2ed2HwM8DlQF/GAIpJycqGs+yQ0DbQNGA+Dy+pBLWFpU
 1pkpONzVXpA2FmeoZYAU3W3s5/Rcij4bt92aLCZ9FoB8qRXWUDOFMkMkmmvr98tAJ+pB
 vjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7/TyYiy/5YMk+mjNioNCBNSjuP8QdrV8gyWB7vm7Ee4=;
 b=mmt1You3KcZkme3bBBWgCTIdrnuluPRcbGw2y3/2g+79ZqiwOFFByIj+KsGBwIcQP1
 7dRFMyeWYoa6eyFkOOfZsRmP+lpOtWAo5Cwo6mZ8VlB6SzJRj+E+MBP0CbOvviyfh1Pf
 rDpqAFxYl3I8Z+w8kry7MqMetP4XHZ1YJ0WVwcVsn7ymUPKNqIkjJmdOXgZrzQGe3ekF
 mnZEmsBMrJ294OUhlvqoCneY7sdM7UlkgXFgpBAkmREpUoJXDzIi1QEICR9nxnXYoeTL
 yEOj2FgH1j72RSOAEIsFJsIBddscj52ESZTsLCjEmSVTmCqV30IU3k9TixI/oscdgqE4
 D/DQ==
X-Gm-Message-State: AOAM531IIk73ckvU5uT4eYrbOCUEw0tJWZ05MnbP6zpFAnN9APRoQvZ4
 bH0JBy6RIVGL7WVa4ThrSA==
X-Google-Smtp-Source: ABdhPJyPrKkZuv82wY4VNPDIZFDkA2Whl8MeIKe3R/fJUILTiZOJueiDHikEWqrDBbQdM+Gv0T8rxA==
X-Received: by 2002:a17:902:724c:b029:d5:c1de:e34e with SMTP id
 c12-20020a170902724cb02900d5c1dee34emr5947456pll.71.1604764183921; 
 Sat, 07 Nov 2020 07:49:43 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com.
 [67.216.221.250])
 by smtp.gmail.com with ESMTPSA id u24sm6317375pfm.81.2020.11.07.07.49.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 07:49:43 -0800 (PST)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: paulus@ozlabs.org
Subject: [PATCH] KVM: PPC: fix comparison to bool warning
Date: Sat,  7 Nov 2020 23:49:38 +0800
Message-Id: <1604764178-8087-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccicheck warning:

./arch/powerpc/kvm/booke.c:503:6-16: WARNING: Comparison to bool
./arch/powerpc/kvm/booke.c:505:6-17: WARNING: Comparison to bool
./arch/powerpc/kvm/booke.c:507:6-16: WARNING: Comparison to bool

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/powerpc/kvm/booke.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index b1abcb816439..288a9820ec01 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -500,11 +500,11 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 
 		vcpu->arch.regs.nip = vcpu->arch.ivpr |
 					vcpu->arch.ivor[priority];
-		if (update_esr == true)
+		if (update_esr)
 			kvmppc_set_esr(vcpu, vcpu->arch.queued_esr);
-		if (update_dear == true)
+		if (update_dear)
 			kvmppc_set_dar(vcpu, vcpu->arch.queued_dear);
-		if (update_epr == true) {
+		if (update_epr) {
 			if (vcpu->arch.epr_flags & KVMPPC_EPR_USER)
 				kvm_make_request(KVM_REQ_EPR_EXIT, vcpu);
 			else if (vcpu->arch.epr_flags & KVMPPC_EPR_KERNEL) {
-- 
2.20.0

