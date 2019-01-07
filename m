Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 18:57:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFE62087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 18:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFE62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YPlK3l2kzDqLf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:57:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.36; helo=2.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 489 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 05:52:06 AEDT
Received: from 2.mo4.mail-out.ovh.net (2.mo4.mail-out.ovh.net [46.105.72.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPdL53mHzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 05:52:06 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.143.209])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id B5A5E1C8AF5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:46:04 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 4FF9F18664E9;
 Mon,  7 Jan 2019 18:45:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 12/19] KVM: PPC: Book3S HV: record guest queue page address
Date: Mon,  7 Jan 2019 19:43:24 +0100
Message-Id: <20190107184331.8429-13-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11415499157494402007
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The guest physical address of the event queue will be part of the
state to transfer in the migration. Cache its value when the queue is
configured, it will save us an OPAL call.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/xive.h       | 2 ++
 arch/powerpc/kvm/book3s_xive_native.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 7a7aa22d8258..e90c3c5d9533 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -74,6 +74,8 @@ struct xive_q {
 	u32			esc_irq;
 	atomic_t		count;
 	atomic_t		pending_count;
+	u64			guest_qpage;
+	u32			guest_qsize;
 };
 
 /* Global enable flags for the XIVE support */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 35d806740c3a..4ca75aade069 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -708,6 +708,10 @@ static int kvmppc_h_int_set_queue_config(struct kvm_vcpu *vcpu,
 	}
 	qaddr = page_to_virt(page) + (qpage & ~PAGE_MASK);
 
+	/* Backup queue page address and size for migration */
+	q->guest_qpage = qpage;
+	q->guest_qsize = qsize;
+
 	rc = xive_native_configure_queue(xc->vp_id, q, priority,
 					 (__be32 *) qaddr, qsize, true);
 	if (rc) {
-- 
2.20.1

