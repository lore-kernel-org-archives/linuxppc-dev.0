Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEC606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWGZv0mgmz2xpt;
	Sat, 21 Nov 2026 00:36:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795181799;
	cv=none; b=I/BtN9LB8hwOrgudGi37AhZ4QBREsne1SAcw6KcZ3c3vsSFTSNVMurXWBa/OQsahWRc9JGs3A4p9BNfh6L1MSg5hDvh/8dFO62FwbcGFMfcFJxmoriQKbjn/CzuaybvMbg2Noi0fTF68DxHzsX4wbBWEartFOQvRL5DnCkaLsT6ge3F24h5zg0/lh6+PA8nR+aP4s+cXkgnf4ZHY32QXKiKaizPyJtDsR5bwNVux+Vm3tsPgO7w1OLY9KGQIh2+WrT14/OvqnUe1aNY+/JvF9P9/dmb/xRE7qcNnjPT7LGeP4QNPC1t2q7ojLQ9UoQ001AQZ5EmCdyhvAKz94iIHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795181799; c=relaxed/relaxed;
	bh=JB6yJU/tPLmNVtr5U4XzW0AQKtEoPkXmKtJ0W88w+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=kGTfgAUG1mu0XTZEh0F7PAQGrA5FPehU0jdu8eXNVirtyKBYbMs+6Qs8jOSLjyALHjD2mIklNx2KWv+FdlRG1/EpNevjMu/JwKLQTZeOVmqRSzJD5BUZsdXGhfZzxo2tyNO02i6V+5YBQpWFk7m9qRcEuTNK9A0WWq1b631F1GRZ0iXfOjC6W8dzJPuiEB5WPtnh/DM1pw0RVbJeSbXxF/jxvGO3eeH/J2s6S0EXeDlH2AObrpnHtyrFukTKn+R0Q//8dfn5aXsKbWjrhH5x+liLF4dYCmHz2y6iGy3ADPIxytZrmLy/d4mcAMpII/hWAX/8B3XOkTy/RwwrCkpnrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aL3ZNb4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWGZs4Hr8z2xly
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 00:36:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795181792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JB6yJU/tPLmNVtr5U4XzW0AQKtEoPkXmKtJ0W88w+8Q=;
	b=aL3ZNb4F9SVjVufvkiEAk6su5L+kxwTRpoTujfGMt3dbM9tOTmf2yAZYJ3Eh0JtcU2+CLT
	1aF/W+UjyBw6ZWBB1s5UWbMndx6gPlEaZwgS7eaHPVDKMnWtr+H1f9mmyaOH3hqRjEuptC
	UyqXqbk4E6EA2rvdfRGj9SUsOW+SQJ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795181792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JB6yJU/tPLmNVtr5U4XzW0AQKtEoPkXmKtJ0W88w+8Q=;
	b=aL3ZNb4F9SVjVufvkiEAk6su5L+kxwTRpoTujfGMt3dbM9tOTmf2yAZYJ3Eh0JtcU2+CLT
	1aF/W+UjyBw6ZWBB1s5UWbMndx6gPlEaZwgS7eaHPVDKMnWtr+H1f9mmyaOH3hqRjEuptC
	UyqXqbk4E6EA2rvdfRGj9SUsOW+SQJ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795181792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JB6yJU/tPLmNVtr5U4XzW0AQKtEoPkXmKtJ0W88w+8Q=;
	b=aL3ZNb4F9SVjVufvkiEAk6su5L+kxwTRpoTujfGMt3dbM9tOTmf2yAZYJ3Eh0JtcU2+CLT
	1aF/W+UjyBw6ZWBB1s5UWbMndx6gPlEaZwgS7eaHPVDKMnWtr+H1f9mmyaOH3hqRjEuptC
	UyqXqbk4E6EA2rvdfRGj9SUsOW+SQJ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-lZQ7p09zOwyfL8gkZ1Sa6g-1; Fri,
 20 Nov 2026 13:36:27 +0000
X-MC-Unique: lZQ7p09zOwyfL8gkZ1Sa6g-1
X-Mimecast-MFC-AGG-ID: lZQ7p09zOwyfL8gkZ1Sa6g_1795181786
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66A3919560B4;
	Fri, 20 Nov 2026 13:36:26 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85216195B3CD;
	Fri, 20 Nov 2026 13:36:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	npiggin@gmail.com,
	maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] KVM: PPC: implement .flush_memslot for BookE and Book3S-PR
Date: Fri, 20 Nov 2026 14:36:23 +0100
Message-ID: <20261120133623.479601-1-pbonzini@redhat.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Qq22jp37CVDMhvkdIjgEJffRpeNAHCjUSozXBJKgxf4_1795181786
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kvm_arch_flush_shadow_memslot() is called when memslots are deleted and
moved, with no MMU notifier invalidation.  This means that the shadow
pages (HPTEs for PR, TLB entries for e500) retain mappings from host
pfns to the old slot's gfns.

Implement the callback by unmapping the GFNs in the same way that Book3S-HV
does it.  Note that kvmppc_core_flush_memslot_pr() does not need TLB
invalidation, because kvmppc_mmu_pte_pflush() calls invalidate_pte()
on the entries, and that in turn invalidates the entry through either
the tlbie instruction or mmu_hash_ops.hpte_invalidate().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/book3s_pr.c | 8 +++++++-
 arch/powerpc/kvm/booke.c     | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 1894968f2c25..66a9e446ab64 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1893,7 +1893,13 @@ static int kvm_vm_ioctl_get_dirty_log_pr(struct kvm *kvm,
 static void kvmppc_core_flush_memslot_pr(struct kvm *kvm,
 					 struct kvm_memory_slot *memslot)
 {
-	return;
+	struct kvm_gfn_range range = {
+		.slot = memslot,
+		.start = memslot->base_gfn,
+		.end = memslot->base_gfn + memslot->npages,
+	};
+
+	kvm_unmap_gfn_range_pr(kvm, &range);
 }
 
 static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ba762ac1fb56..fffb28fe9a0f 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1844,6 +1844,14 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 
 void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
 {
+	struct kvm_gfn_range range = {
+		.slot = memslot,
+		.start = memslot->base_gfn,
+		.end = memslot->base_gfn + memslot->npages,
+	};
+
+	if (kvm_unmap_gfn_range(kvm, &range))
+		kvm_flush_remote_tlbs(kvm);
 }
 
 void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr)
-- 
2.56.0


