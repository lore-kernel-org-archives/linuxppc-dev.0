Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB0606A338
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=hOEc3Ykw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5Ls1r1Jz2xlk;
	Sat, 14 Nov 2026 05:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794594405;
	cv=none; b=WZXdB8BVdm4j6lrQQ4p6E4s7kd4S1HaBp1seHyXSZ4icmEDwPueIaclWD80TBqDIitWOQgtz5qdWn1IhRgEpb6NCEfFhZlRP/HLYiFbUe/91fnf25TKgeYgxHBrpmArXqXdQQTh0WrnB1SfXEbk8ofKAjCMPmgFZLc9UJhT667ub+Xu5znt4zQMYIWzuglFL6h665/1Sl9tPyAKJ5bT4xMM4ZNnJFotB+wcY4B0VE92YaodwsfqSAs8bLkaOJiMw6ZiAUOsMwbahJ36FjfPeRwIbl86M5GLmgYiH0VN1VvbeG1TESTZVhz3gwWuPQcwd0dsoVl3OsSYrODUbLC11Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794594405; c=relaxed/relaxed;
	bh=a447najyP6oiEfQOMuEwmzsq+JuFRrv0E+AbaPhpCIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdF6162QDneBkabpSuWxV2d6bJie0x4BGDEfmxn9tF+LTziqdFL7ERxRalJHT09lB17k7cogQuBOOzLot4EFGtIH9ZiWzwaBsIn0f937RZoGQbWc6KE3ujJ7+nUPODiCasLyhD9athmdVqJgPacjz04ZHjMioyv0Jg/jUAWrh2CvrUJcYTadr+3cY7gg6dtoGGY1j8rSme+qMatru4cmMi1qNqNCBUvwRYm7kECG68MVkrlpyss4pNQaFWxEUvS6ZFslCHu70UOs4Tjuw+tSSXkKTt/cgZKcAV8a/wSe9XnFO+BQNogtCPgkEZ/5ihuktZQqzjk764vVJCTmcgjoEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=hOEc3Ykw; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=hOEc3Ykw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5Lm31m8z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:26:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=a447najyP6oiEfQOMuEwmzsq+JuFRrv0E+AbaPhpCIo=; b=hOEc3YkwQtQpZARn5ieWyaY5Ne
	Fee1m0HWE6LQ/qA1Behapz2i4AlA7dulrNddxuRIvHhJPeFGiaLYlTpC8BDGwfEFZ46z6C7VlAu68
	KOcy7f+V6eNYB3Cyi7RBaYgOT0TlTmX9dDDm0TwfZ9T29PSA3RPC7nRBMdx9PjXKu4dCzbokBKXla
	3qQ+w62TjIfT7oD6HIwpvhreNe+8CfnsnlYeDj6n4k4R702pjDkkNSqcirtqUHm6p/RL7NIonFGzf
	s3jdwOrmFyuMm3DKOL5B9HErrcjdvzC/ejUh4FtoEpmuRHex0vdSSgxvt0i+zef5PxcKwiDbDeAuM
	RQJevh8g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvyU-0000000BeOW-16LO;
	Fri, 13 Nov 2026 18:26:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRvyR-00000000LXo-1IJ3;
	Fri, 13 Nov 2026 18:26:07 +0000
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
Subject: [RFC PATCH 00/13] KVM: planes: Userspace API
Date: Fri, 13 Nov 2026 11:25:54 -0700
Message-ID: <20261113182607.82813-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

The VSM work¹ drives planes from userspace, which takes a little
more API than the planes series² itself provides: an explicit
userspace opt-in (enabling KVM_CAP_PLANES with the plane count,
before any vCPU is created), KVM_GET/SET_PLANE_RUN_STATE vCPU
ioctls, and the mechanics to go with them — per-plane requests
fanned out to the twin vCPUs, XCR0 shared across twins (with every
twin's fpstate sized for the dynamic xfeatures that allows), and
APICv inhibited while planes are enabled (for now). With selftests,
including Paolo's plane infrastructure tests from the original
planes RFC³, ported forward.

Posted separately from the VSM RFC v2 (to follow) so this part can
be reviewed — or folded — with the rest of the planes series. Based
on that series² with my fixes⁴ applied (including two follow-up
patches on that thread); the whole stack is at ⁵.

¹ https://lore.kernel.org/kvm/20261017122501.610248-1-dwmw2@infradead.org/
² https://lore.kernel.org/kvm/20260608144252.351443-1-joro@8bytes.org/
³ https://lore.kernel.org/all/20250401161106.790710-29-pbonzini@redhat.com/
⁴ https://lore.kernel.org/kvm/20261111222911.477-1-dwmw2@infradead.org/
⁵ https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/vsm2/planes-uapi

David Woodhouse (12):
  KVM: x86: Let userspace opt in to multiple planes with KVM_CAP_PLANES
  KVM: selftests: Add x86 planes lifecycle test
  KVM: Add KVM_GET/SET_PLANE_RUN_STATE vCPU ioctls
  KVM: selftests: Cover plane run-state ioctls in planes_test
  KVM: planes: Fan out per-plane requests to twin vCPUs
  KVM: x86: Inhibit APICv when VM planes are enabled
  KVM: planes: Enlarge every twin's fpstate for dynamic xfeatures
  KVM: x86: Let userspace choose state for plane twins to share
  KVM: planes: Let plane twins share XCR0
  KVM: planes: Let plane twins share DR6
  KVM: selftests: Check CPUID handling of plane twins
  KVM: selftests: Cover plane state sharing

Paolo Bonzini (1):
  KVM: selftests: Add VM plane infrastructure and tests

 Documentation/virt/kvm/api.rst                | 129 +++-
 arch/powerpc/kvm/trace.h                      |   3 +-
 arch/x86/include/asm/kvm_host.h               |   8 +-
 arch/x86/include/uapi/asm/kvm.h               |   4 +
 arch/x86/kvm/cpuid.c                          |  25 +-
 arch/x86/kvm/mmu/mmu.c                        |  13 +-
 arch/x86/kvm/regs.c                           |   1 +
 arch/x86/kvm/svm/svm.h                        |   3 +-
 arch/x86/kvm/trace.h                          |   3 +-
 arch/x86/kvm/vmx/main.c                       |   3 +-
 arch/x86/kvm/x86.c                            | 221 ++++++-
 arch/x86/kvm/x86.h                            |  21 +
 include/linux/kvm_host.h                      |  36 +-
 include/uapi/linux/kvm.h                      |   7 +
 tools/testing/selftests/kvm/Makefile.kvm      |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |  73 +++
 .../selftests/kvm/include/x86/processor.h     |  14 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  74 ++-
 .../testing/selftests/kvm/lib/x86/processor.c |  47 +-
 tools/testing/selftests/kvm/plane_test.c      | 137 ++++
 .../selftests/kvm/x86/plane_x86_test.c        | 331 ++++++++++
 tools/testing/selftests/kvm/x86/planes_test.c | 605 ++++++++++++++++++
 virt/kvm/kvm_main.c                           | 138 +++-
 23 files changed, 1852 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/plane_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/plane_x86_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_test.c

-- 
2.50.1


