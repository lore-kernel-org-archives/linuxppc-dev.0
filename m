Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D5EC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0509F206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0509F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YPnt292nzDqKH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:59:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.41.16; helo=17.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 315 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 05:52:09 AEDT
Received: from 17.mo4.mail-out.ovh.net (17.mo4.mail-out.ovh.net [46.105.41.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPdP1w24zDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 05:52:08 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.143.189])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E76F11C807A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:44:24 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id ED14C1866364;
 Mon,  7 Jan 2019 18:44:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/19] KVM: PPC: Book3S HV: check the IRQ controller type
Date: Mon,  7 Jan 2019 19:43:15 +0100
Message-Id: <20190107184331.8429-4-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11387351660839013335
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

We will have different KVM devices for interrupts, one for the
XICS-over-XIVE mode and one for the XIVE native exploitation
mode. Let's add some checks to make sure we are not mixing the
interfaces in KVM.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kvm/book3s_xive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f78d002f0fe0..8a4fa45f07f8 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -819,6 +819,9 @@ u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 
+	if (!kvmppc_xics_enabled(vcpu))
+		return -EPERM;
+
 	if (!xc)
 		return 0;
 
@@ -835,6 +838,9 @@ int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval)
 	u8 cppr, mfrr;
 	u32 xisr;
 
+	if (!kvmppc_xics_enabled(vcpu))
+		return -EPERM;
+
 	if (!xc || !xive)
 		return -ENOENT;
 
-- 
2.20.1

