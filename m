Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899D606A882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GTTbU0sn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyr33Bhfz3bsm;
	Thu, 12 Nov 2026 09:29:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436178;
	cv=none; b=b6wSeLxOIO25YLT6+xdY0cOYk1D46YkN4t1AMjou0LCUeg3Y2tbJCZipQHyGBXyQ7cFw14BgPFTMHMfUHMznhJSI7j57UgQ+qwn6TEYwG7Cj22D2PRo54dbQx2UiW9DziiuGWZZvMP3znxhoZc3etA+zgJserSBPf6Z/7YoULBYGauqz20+SFvP7CSeIw6zfP1PVLYZRRq4k4AL3u3QcQkqCti21Qaw9+m6SUx6h5x7Lj3GhLi57UZ716LQHodBIviCXtFNsnFcxMZtfQkmA0N/ZC4kAH5R8xsmbsjK4ZD957gi54anLMdEFW7gEGfMHVlSZGvQBXIfTWGRg+wF39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436178; c=relaxed/relaxed;
	bh=8qybenYqvG8G9PhMhPtpqHZ056gMFT0pwcSnxKT9iyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFzxqG+2KGR/qR9GW9oewq4udSHJ1xifqhRUIe4iO2Z261MCgfq5LHC4JB6GzhRxduOiAQcbWkyMcoRYu+QzVTs6SxaEJI4PJXDYoZlxBXIL2z0uiFQmLXCgo8WFxfkVnqsOIOdUjUKV6aYJzryzP2mjJ/Nu6/C9W0uXc1Jjn9QX1rq7qYcIugRCrELa/0hUsJM9pvF1HfXFh5BxauOD6fsqtQEs2FYEIIi5MV+YOeNq3nyEsA1SzpG8aks9frFxZby9Xifru/80WxfJqMrNzPOZnKO0LLcqVX9d3OMoV1m34yV3TI+u1/DWE36PWKGIVcQZ2WtRalbUl/pOCiByAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GTTbU0sn; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GTTbU0sn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj3RQ0z30W9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8qybenYqvG8G9PhMhPtpqHZ056gMFT0pwcSnxKT9iyE=; b=GTTbU0snO/nUQajge+xBq1MFqg
	QCVuIo3EK60swCUZBbdORPP9nzonwyf38wVn5CkrR4E+VbSwxUtREevKSLliFB6FkoA4U0PawrBC6
	21DVG1UqXCWYh8595L2Ac34v8l+N9Em9XG6MOE7cPxBGxDpGLbck/jzBxXsBA9L5afdyIarQH8c0Z
	w7w29b0ah/iBIIRVSrPjcp4hF3oE56z6pIjvpaUGM9Nyjm6z4yMxONuU0qhp079dLqajLEtUPtKCU
	wOMpaAYrFNfqQZpOFD++SIM+GIlqjp42fskxCot1POq9AKgO20oFdAjP691kKLoqXW6LMXgwjthK6
	Idrz/Zwg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoc-00000009dba-29nz;
	Wed, 11 Nov 2026 22:29:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-00000000081-2lp5;
	Wed, 11 Nov 2026 22:29:11 +0000
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
Subject: [PATCH 04/16] KVM: Guard the per-plane KVM_SIGNAL_MSI cases with __KVM_HAVE_MSI
Date: Wed, 11 Nov 2026 14:28:59 -0800
Message-ID: <20261111222911.477-5-dwmw2@infradead.org>
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

KVM_SIGNAL_MSI fails with -ENOTTY on both the VM fd and plane fds,
while KVM_CHECK_EXTENSION still reports KVM_CAP_SIGNAL_MSI. A VMM that
sends MSIs through the ioctl, such as QEMU with a split irqchip, cannot
inject device interrupts at all.

The new cases in kvm_vm_ioctl() and __kvm_plane_ioctl() test
CONFIG_HAVE_KVM_MSI, which no Kconfig defines; the macro architectures
set is __KVM_HAVE_MSI, as the old VM-fd case used. So both compile
away. Use __KVM_HAVE_MSI.

test_plane_msi in the x86 planes selftest, added later in this series,
catches this.

Fixes the per-plane KVM_SIGNAL_MSI cases added by "kvm: Make
KVM_SIGNAL_MSI per plane".

Fixes: https://lore.kernel.org/all/20260608144252.351443-39-joro@8bytes.org/
Reported-by: Sriram Nambakam <snambakam@linux.microsoft.com>
Closes: https://lore.kernel.org/all/20261104065536.15232-1-snambakam@linux.microsoft.com/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0136156df252..95de904f0c61 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5016,7 +5016,7 @@ static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsig
 	case KVM_CREATE_VCPU:
 		r = kvm_plane_ioctl_create_vcpu(plane, arg);
 		break;
-#ifdef CONFIG_HAVE_KVM_MSI
+#ifdef __KVM_HAVE_MSI
 	case KVM_SIGNAL_MSI: {
 		void __user *argp = (void __user *)arg;
 		struct kvm_msi msi;
@@ -5662,7 +5662,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_create_plane(kvm, arg);
 		break;
 	case KVM_CREATE_VCPU:
-#ifdef CONFIG_HAVE_KVM_MSI
+#ifdef __KVM_HAVE_MSI
 	case KVM_SIGNAL_MSI:
 #endif
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
-- 
2.50.1


