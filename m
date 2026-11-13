Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31802606A33B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=E2UibT/+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQdSV6Vv1z3bcJ;
	Fri, 13 Nov 2026 11:30:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794529802;
	cv=none; b=ewDhwi9o7NNb+nh7kYaeCxtsKFICeiGwQjfHau3rL40G/v6AzVwkKpeuovPtIvRuHSG1aCW1fa326umt5O33SxUHJw6m/O0qKKdn2L5dpcKg1nfOLu8guEP9Ir1vYtZPRQCvEwE7KmLV8KzPnIw+Xt2f+Sho454vWb7wMae+LAfXH6Dof32BQi/XzKlnTs140TfL/5NICb7XxeCoJgcjIIPcTq+zw6rs7MZ0IdOHrDWWFexKwv9VUfSIlm1iFAe/b/AQqiZdH/V1aCVrhyynOGcuQl3Ct5EkZynR1aKHpj6GXpsXU3ZLvEO2tuRDXD6A3CvnYEgH5SBAAn+fc/lzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794529802; c=relaxed/relaxed;
	bh=WUzZAc94TsS7Jml651A4i89wAxxOVIQCfAZAmZSXQi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHchm5FTB7oMMQ+dGtreQ/ypwJFgX7lDTgo+1h+YBDxUWAQe9+/YFpdmUYMLCzIKVx8A6EP44Xm9zn+G8VV0yoRLuUL5vOvalp3JIi54zZVdhPI77Lmh15WrClCDjL/mkbtJaYUunIHs31BZMfaZCB7+CAKYw2IaG1L9SdPsOsw4RRFNFWcDuDvy24x4Y34PAXQgI4gvetAwE0PYTnppqdQT4ntsvlrhG2eYtnZabwrtdDd2d01RfcPDuFpitheC0gkxAa2v5WGWG4oWPzd6d9t2ou5avRcQDC1VSowcpVM6ByvjNisKLBDAwAB1QEYor8oy9hN7vdBj2IEagDxTaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=E2UibT/+; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=E2UibT/+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQdSQ6J1Yz3bQl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 11:29:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WUzZAc94TsS7Jml651A4i89wAxxOVIQCfAZAmZSXQi4=; b=E2UibT/+k5GThbDF7kF1kpxCWv
	3iflL7tFohUAGCfEHj7vzeKG8ozJ3nn5nLuxUjav9wzS8efjNIJ0+uTTEW/Qryp1HFnmjrkLoeURq
	af+HJwcsGTeARjxvnm+1yi/ijLHpxMB/n0oZcE5hOuvUC6hppnvXcrTk0p7esTg6pS5VYDfX1K77y
	9Rk84h7wESXJ2Yafz+0bczwrCSx6Q2VvFyNCWPw+pO/L6vdg09OQh9L8kXufrI5kla8wcPmMGLs/M
	ZPRua1PeNQs0VJHG/KqgeC2nrwrNo00TnjnBaElzeLrmgFZXSEdPpJUFFOx+e9swWCRhqnCxy+s7o
	5sU7mb2Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRfAt-0000000AqdF-0X34;
	Fri, 13 Nov 2026 00:29:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRfAq-00000000DvM-0tIh;
	Fri, 13 Nov 2026 00:29:48 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 17/16] Documentation: kvm: Renumber KVM_CREATE_PLANE and restore the kvm_run label
Date: Thu, 12 Nov 2026 17:29:47 -0700
Message-ID: <20261113002948.53522-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111222911.477-1-dwmw2@infradead.org>
References: <20261111222911.477-1-dwmw2@infradead.org>
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
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

The KVM_CREATE_PLANE section was inserted between the .. _kvm_run:
label and "5. The kvm_run structure", so the :ref:`kvm_run` in the
KVM_CAP_SYNC_REGS text now links to KVM_CREATE_PLANE. It also took the
number 4.145, which KVM_PPC_GET_COMPAT_CAPS already has, leaving 4.147
unused.

Move the label back above section 5 and number the section 4.147.

Found by a local Sashiko review.

Fixes the section placement in "Documentation: kvm: introduce "VM
plane" concept".

Fixes: https://lore.kernel.org/all/20260608144252.351443-9-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c1a6536354fd..9aa09d8a39dc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6821,11 +6821,9 @@ if the guest_memfd memory was pinned in IOMMU page tables.
 
 See also: :ref:`KVM_SET_MEMORY_ATTRIBUTES`.
 
-.. _kvm_run:
-
 .. _KVM_CREATE_PLANE:
 
-4.145 KVM_CREATE_PLANE
+4.147 KVM_CREATE_PLANE
 ----------------------
 
 :Capability: KVM_CAP_PLANES
@@ -6843,6 +6841,8 @@ in the future may use the plane id when planes are supported by hardware (as is
 the case for VMPLs in AMD), or if KVM supports accelerated plane switch
 operations (as might be the case for Hyper-V VTLs).
 
+.. _kvm_run:
+
 5. The kvm_run structure
 ========================
 
-- 
2.50.1


