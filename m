Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA2606A333
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=C9BSB26Y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyr24D5Yz3brr;
	Thu, 12 Nov 2026 09:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436178;
	cv=none; b=cKMjkCO08IVVMdtAMqIlVzVECz4bJ1UNBL6WYAjUiv4TqhI1QiBT6+n+z/o7e/UBt+j8KDvlFeOcWCTb+jeBq7+Q+WIoiIc0iZERvHl92zhjLTKEVS+i27PPELFO1cnCApkTnbAgZNPfaLwqEiWrqfgn1+QnWd0oiW1+HI6NnaRRiVK/2vAlDYg7rs+9CxXgj8HYxfsAUfqkCFFUO+NhSkSAP0HBeloz28WeReT6kWkXOfx/wbhi0vRX9URK0ZFrBIB84c+JSF3Oc+a/d7TQ1vTsY4ITuo6UMXibsMfGhqWLYIG/1fKIzBA9hNuw7yMH7gcwoT7FWsc1lhaIDOezzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436178; c=relaxed/relaxed;
	bh=oFTOekiPiKL4T1KhOTcidabBpJ5GICpNBEzlP5Id0Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdRWi07nxU+0tXHD4abB4aRK1OMzZVHWZfixoS27EHi4o2UnAwcpxSsK14fs54s30lEBCFGjUvym29vGCrGL8fIEP9nowGB62/qLm5mtFvFSoSB3xFpIjhtYZnA+dpU+t2gFZNmOQH1FGP8BXNc+8o+cYpxfLtC988cawmaBT2oczbUwZ6eB7H0bBEdU/hlMNRW4L/zPzv34QTgYXVWFiQkjp0X/M6/JOU1FYnHG7etwl8IAd2sdOYljNbXETnwHDgUvYmjnCMqtWGa+2bCA/XYB2qFxvNRHqMiaB+O3PN/k9EqyWjBpaRHD19ACxWCSsTJMR80tAtKXOKliz1EnUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=C9BSB26Y; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=C9BSB26Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj399Hz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oFTOekiPiKL4T1KhOTcidabBpJ5GICpNBEzlP5Id0Nc=; b=C9BSB26YSXAAAt8dotx5k4npei
	7lOaJNzIG3vNyJXet0BSEzgeND3o0kmPi8zLlvguz0/YykL482sDuJo5mz8z+C8YDdaVn4MK2U3B4
	qeX6HzVze6Jw2bKaqD+IZuDS2A3FuaC92BrhMw3foF5vgGYk+QRLIbK+f2hyKYzpveDgRgWatXglx
	h9pgQtP9oXDL5gAGu1XPX2UhzPHdc6RiKTRcuWp+xsEd9gXZS14E6bSCqwHCYvenocTcMtqgTsRJB
	COcg+iRyM2waOsPu0BXkMhP1pEY/pF5Y6CDua+bGhd0RA33jBQwPEwTLAMZ+oLBw3uSlm0MnChIqM
	H2YjHJWg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoc-00000009dbd-2A1k;
	Wed, 11 Nov 2026 22:29:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoa-0000000008a-0ZfS;
	Wed, 11 Nov 2026 22:29:12 +0000
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
Subject: [PATCH 12/16] KVM: VMX: Leave the IPIv PID-table entry to the plane 0 vCPU
Date: Wed, 11 Nov 2026 14:29:07 -0800
Message-ID: <20261111222911.477-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111222911.477-1-dwmw2@infradead.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20261111222911.477-1-dwmw2@infradead.org>
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

The IPI virtualization PID table is indexed by vCPU ID, and a plane
vCPU has the same vCPU ID as its plane 0 twin. vmx_vcpu_create() for a
twin therefore repoints plane 0's entry at the twin's posted-interrupt
descriptor, and vmx_vcpu_free() for a twin (including the error path
of a failed KVM_CREATE_VCPU on a plane fd) clears it. Plane 0 is left
with no valid entry, or one naming a freed descriptor.

Nothing consumes the table while that is the case today: a VM with
planes has APICv inhibited, so IPIv stays off. But the entry must not
depend on that. Fill and clear it for the plane 0 vCPU only.

Fixes the IPIv PID-table handling for the plane vCPUs that "KVM:
Implement KVM_CREATE_VCPU ioctl for planes" creates.

Fixes: https://lore.kernel.org/all/20260608144252.351443-34-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 44d0e8eba45b..591c7745e3e9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7525,7 +7525,8 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	free_loaded_vmcs(vmx->loaded_vmcs);
 	free_page((unsigned long)vmx->ve_info);
 
-	if (vmx_can_use_ipiv(vcpu))
+	/* See vmx_vcpu_create(): only the plane 0 vCPU owns the entry. */
+	if (vmx_can_use_ipiv(vcpu) && !vcpu->plane_level)
 		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id], 0);
 }
 
@@ -7614,7 +7615,12 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		vmx->ve_info = page_to_virt(page);
 	}
 
-	if (vmx_can_use_ipiv(vcpu))
+	/*
+	 * The PID table is indexed by vCPU ID, which a plane vCPU shares
+	 * with its plane 0 twin: only plane 0 fills the entry, or creating
+	 * (and freeing) a twin would repoint (and clear) plane 0's.
+	 */
+	if (vmx_can_use_ipiv(vcpu) && !vcpu->plane_level)
 		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id],
 			   __pa(&vmx->vt.pi_desc) | PID_TABLE_ENTRY_VALID);
 
-- 
2.50.1


