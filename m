Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB4C282D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 04:39:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3C721855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 04:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3C721855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z90x0p0szDqNq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 15:39:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43z8z53WtbzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 15:37:51 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id D7122AE80037;
 Mon, 11 Feb 2019 23:37:47 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] KVM: PPC: Release all hardware TCE tables attached to
 a group
Date: Tue, 12 Feb 2019 15:37:45 +1100
Message-Id: <20190212043745.18290-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The SPAPR TCE KVM device references all hardware IOMMU tables assigned to
some IOMMU group to ensure that in-kernel KVM acceleration of H_PUT_TCE
can work. The tables are references when an IOMMU group gets registered
with the VFIO KVM device by the KVM_DEV_VFIO_GROUP_ADD ioctl;
KVM_DEV_VFIO_GROUP_DEL calls into the dereferencing code
in kvm_spapr_tce_release_iommu_group() which walks through the list of
LIOBNs, finds a matching IOMMU table and calls kref_put() when found.

However that code stops after the very first successful derefencing
leaving other tables referenced till the SPAPR TCE KVM device is destroyed
which normally happens on guest reboot or termination so if we do hotplug
and unplug in a loop, we are leaking IOMMU tables here.

This removes a premature return to let kvm_spapr_tce_release_iommu_group()
find and dereference all attached tables.

Fixes: 121f80ba68f "KVM: PPC: VFIO: Add in-kernel acceleration for VFIO"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I kinda hoped to blame RCU for misbehaviour but it was me all over again :)

---
 arch/powerpc/kvm/book3s_64_vio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 532ab797..6630dde 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -133,7 +133,6 @@ extern void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
 					continue;
 
 				kref_put(&stit->kref, kvm_spapr_tce_liobn_put);
-				return;
 			}
 		}
 	}
-- 
2.17.1

