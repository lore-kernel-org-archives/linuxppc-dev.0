Return-Path: <linuxppc-dev+bounces-23892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB4C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 05:59:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwknG1MTXz3c9k;
	Thu, 09 Jul 2026 15:59:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783576770;
	cv=none; b=VyYykRdGGoyM+aodYXuipVLPWZDE58cnCnmEERKQSzc36C3+h6XRePRNnKDcoQo/iOI5KroQy8XZ+eUc2VefxQUbPISx1jSJHMoOld4TxcCiNMZiMVBuY9KCUx3PZd18L9ee+tpUG52aVkx6a1kLSESzfiRiwaIV6ERATWt58NxlWQS/634PpIoklQ+Y8EgZjpe+QrQc8o/pWOSgEkouL2LZ4gN1Id/VyRZ0U95Imv8Id9iKe/y9xg5OAABJWs3xTisHbi6cqxzz+D9f0X5QtF/bNUx97icXqwzHrYQCL6FFUP+4jWXxFADNt/2tpd6VBi+a6o2+JKzSDkACOgu6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783576770; c=relaxed/relaxed;
	bh=BD6GZGtc0sxlCIWzLbBSY7OCz/x7wznovXsAFkQoPTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxSyK4VO2ilVTNgmso8jsShz4teVkrczatddz9eEvkDcbjsOBvTFJBgSRCS852OFDzNWOTcwtSM5vSFOZKO/rCTcZBQXnQHlNtZIIPq1UWD3k3PNQIP+eXviCZBX9igbhsmFyWWwY1RYs3r29QVD7ZUE2INqqxL4Q1ukNcbh3+vPIB1QBwK9o5pAWrmOX73C/Kr5yVqi1e9K84gSfW3QTVu9IwoW3euCErtCl1whfvzY9g9PWrWqoy/AJUrrc0HkQ/wI9welko+B58TJcLtv3uZwhq1zrP/D/Wm8+bg/wZiQsyIt3oHM2uwXAN9VEVxdN1/mRDuqp+3NU0sYi6tNaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=leixiang@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=leixiang@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwknB63vrz3byk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 15:59:25 +1000 (AEST)
X-UUID: 29d2803c7b5b11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9573cb13-f166-48ce-8f4f-344c4878f5ea,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:f269dd2c1502e98836ece2b94ff3c8e7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 29d2803c7b5b11f1aa26b74ffac11d73-20260709
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 962530721; Thu, 09 Jul 2026 13:58:09 +0800
From: leixiang <leixiang@kylinos.cn>
To: 
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	stable@vger.kernel.org,
	leixiang <leixiang@kylinos.cn>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Suresh Warrier <warrier@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Set irqfd->producer only on success
Date: Thu,  9 Jul 2026 13:57:52 +0800
Message-ID: <20260709055755.31297-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak59frQUBl9Gs3Qn@google.com>
References: <ak59frQUBl9Gs3Qn@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set irqfd->producer only after kvmppc_set_passthru_irq() succeeds to
avoid leaving a dangling pointer on failure. The bypass manager does
not register a failed producer, so the pointer is never cleared.

Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: leixiang <leixiang@kylinos.cn>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..ff7b25629125 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
 
-	irqfd->producer = prod;
-
 	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
 	if (ret)
 		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
 			prod->irq, irqfd->gsi, ret);
+	else
+		irqfd->producer = prod;
 
 	return ret;
 }
-- 
2.45.0

