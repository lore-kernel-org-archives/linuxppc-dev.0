Return-Path: <linuxppc-dev+bounces-22875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB268CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 14:45:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkWGG47Mlz2yVZ;
	Tue, 23 Jun 2026 00:45:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782115116;
	cv=none; b=gnqhpBgl0ubHVIiio1NLi+UWEhSzNlJvezOCG+B+GP+NBoJsvaY5q1F+bGBPxMlg2ZfdRs2vQoXBKpuYifRnobBkhbO8NGKZU5NMPkw4UUzobMU3g5k5e7HGXLgIG0wK8++WBH9lJqKQNjhJ3pC907Qr9HWmEHoTNqOix436kAdSNleWoZQ3GPnK36vHn/EuzpqNhaF2vIa7V7p1sn14GPRRkXLMXgp33F5lo9GOIQyBzqGxiN/HnDipTd+e2tTDHoapLZ+jR1qx0MR1CXQSsQFi//dVnexZe8TGwze1vp1TBbms1jNOY2c0kTKYOtS4aEH24ed46zA8b8KFCH8cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782115116; c=relaxed/relaxed;
	bh=6AO5js1C7AaKnU17xnEcGYVJNLq1Oqku0BsOLw8GoWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJ+deHY4jQgefkaM7nIyDulXUYeO3tg04u6IRXWnE1K7AV/Vd7S/+dALemkgiXAmd3VT/fkB+FxnyzpaH8gPMniFEqN1n2jiwxPUDH/TrNk4TrYmwgsCSwPnUDmDhIjJms2uV9Aau8x7sIWBOMoLoeyHCg4c1FTPbDwSj0eS0+D5V0ac6SY0KOqcakIIEGWKkAggs76yUQVU2TZ129sGEvQMhjgyBU/0pXPuzCc3gXsz6uLShdOHPAMOzQs3yWjH4f+qeZekL6q0A8PBgk9Rx2cwVlQN/r0gVKhwg1GLl4GgPiT1Uij4E3+kdQ9fdP6Jtte5s0Cms/If1gqzJrKIPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=leixiang@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=leixiang@kylinos.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 366 seconds by postgrey-1.37 at boromir; Mon, 22 Jun 2026 17:58:33 AEST
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkLDT5CWbz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 17:58:33 +1000 (AEST)
X-UUID: 21bd73886e0f11f1aa26b74ffac11d73-20260622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:df1340d8-bad8-4902-a57c-bc94b27aad22,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:97fc9069a1c6fe1949f2f7a7b81d7275,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21bd73886e0f11f1aa26b74ffac11d73-20260622
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 972357421; Mon, 22 Jun 2026 15:51:09 +0800
From: leixiang <leixiang@kylinos.cn>
To: 
Cc: leixiang <leixiang@kylinos.cn>,
	stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Suresh Warrier <warrier@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
Date: Mon, 22 Jun 2026 15:51:01 +0800
Message-ID: <20260622075103.35164-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

The x86 and powerpc add_producer() callbacks set irqfd->producer before the
fallible setup and never clear it on error.  The bypass manager doesn't
register a producer whose add_producer() failed -- producer->eventfd is
left NULL, so the later unregister early-returns and del_producer() is
never called -- so nothing ever drops the pointer.

For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
when the vector is disabled, after which a routing update dereferences the
dangling pointer via kvm_arch_update_irqfd_routing().

Nullify irqfd->producer on the error paths.

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
Cc: stable@vger.kernel.org
Signed-off-by: leixiang <leixiang@kylinos.cn>
---
 arch/powerpc/kvm/book3s_hv.c | 4 +++-
 arch/x86/kvm/irq.c           | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..14919b76fb32 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
 	irqfd->producer = prod;

 	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
-	if (ret)
+	if (ret) {
 		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
 			prod->irq, irqfd->gsi, ret);
+		irqfd->producer = NULL;
+	}

 	return ret;
 }
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 8c62c6d4d5c1..cb8ac4b9b0d7 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -488,8 +488,10 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,

 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
-		if (ret)
+		if (ret) {
 			kvm->arch.nr_possible_bypass_irqs--;
+			irqfd->producer = NULL;
+		}
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);

--
2.45.0

