Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A061C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 09:03:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AE82175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 09:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AE82175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PP8P673xzDqDS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.165.38; helo=6.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo2.mail-out.ovh.net (6.mo2.mail-out.ovh.net [87.98.165.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PNqC0gShzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 19:48:05 +1100 (AEDT)
Received: from player787.ha.ovh.net (unknown [10.109.160.93])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B71D418A6E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 09:40:09 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 4F1283F3B6A4;
 Wed, 20 Mar 2019 08:40:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v4 15/17] KVM: PPC: Book3S HV: XIVE: activate XIVE
 exploitation mode
Date: Wed, 20 Mar 2019 09:37:49 +0100
Message-Id: <20190320083751.27001-16-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320083751.27001-1-clg@kaod.org>
References: <20190320083751.27001-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 18188068572450950103
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrieehgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

Full support for the XIVE native exploitation mode is now available,
advertise the capability KVM_CAP_PPC_IRQ_XIVE for guests running on
PowerNV KVM Hypervisors only. Support for nested guests (pseries KVM
Hypervisor) is not yet available. XIVE should also have been activated
which is default setting on POWER9 systems running a recent Linux
kernel.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/powerpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b0858ee61460..f54926c78320 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -573,10 +573,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_KVM_XIVE
 	case KVM_CAP_PPC_IRQ_XIVE:
 		/*
-		 * Return false until all the XIVE infrastructure is
-		 * in place including support for migration.
+		 * We need XIVE to be enabled on the platform (implies
+		 * a POWER9 processor) and the PowerNV platform, as
+		 * nested is not yet supported.
 		 */
-		r = 0;
+		r = xive_enabled() && !!cpu_has_feature(CPU_FTR_HVMODE);
 		break;
 #endif
 
-- 
2.20.1

