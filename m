Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 58082B7179
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 35/35] KVM: PPC: Add documentation for magic page enhancements
Date: Tue, 31 Aug 2010 04:32:16 +0200
Message-Id: <1283221937-21006-36-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This documents how to detect additional features inside the magic
page when a guest maps it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 Documentation/kvm/ppc-pv.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/kvm/ppc-pv.txt b/Documentation/kvm/ppc-pv.txt
index 922cf95..a7f2244 100644
--- a/Documentation/kvm/ppc-pv.txt
+++ b/Documentation/kvm/ppc-pv.txt
@@ -102,6 +102,20 @@ struct kvm_vcpu_arch_shared {
 Additions to the page must only occur at the end. Struct fields are always 32
 or 64 bit aligned, depending on them being 32 or 64 bit wide respectively.
 
+Magic page features
+===================
+
+When mapping the magic page using the KVM hypercall KVM_HC_PPC_MAP_MAGIC_PAGE,
+a second return value is passed to the guest. This second return value contains
+a bitmap of available features inside the magic page.
+
+The following enhancements to the magic page are currently available:
+
+  KVM_MAGIC_FEAT_SR		Maps SR registers r/w in the magic page
+
+For enhanced features in the magic page, please check for the existence of the
+feature before using them!
+
 MSR bits
 ========
 
-- 
1.6.0.2
