Return-Path: <linuxppc-dev+bounces-22404-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D9FCD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5DB2j0yz2xdb;
	Wed, 10 Jun 2026 22:48:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095690;
	cv=none; b=cqefEdCleJsigEVo0/YMhOFb65IfcKKaz2RbJyqKxh8eSZJiAsUcqH9BPvNB+HDcmTDUPNiiK4bBxOZUCk32KfU5q7uPmvJFgjd7wztcWVCjAVyXI2IglQ4ghRIbREVEl7Iy7R/TRafMNkCRpaSu6X58cTCzI7fS7ngvKwMD7UYzhjJ8Jsa6/R335ZY15tMjMx28alNCvwVDX23+64KJ5NnFjlc0ZIGllbv57HgAfJGEq8WC7oxRK7b1ag1KxpZbKLQd3FoKbPwi+oyEFs4rOwDJNpRFGpK5sia85TVerQ/0MZipvEDVDC/SUebEfnP7mPbLfSCG37b+aWm8nbS3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095690; c=relaxed/relaxed;
	bh=VrxTcenItW2gu16uj0ViHf2ekVBrXj9Zuq6BUQC9S+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs0OS2Uv2VmVCt+Z2duuf9Yi+S+CbaynU8ENaAc5ZAyO9OodqxivKhLbLBOo5LVOZPFke5G0dYkQfCTN+7+DpihwaEaaM6Bt3qNduwyxpxeuOtNd06qFNrF61j9w256DTj2XhFLxreBZu0eAmaChLA0y2WeO69FQOm/CEVjLeR384JyvOyQ4QYVWm5YJL/juMII7fp54dBvwukCEM7NxujDNR8+vkn7vHOBybbzwMvr0Q7p5wbWY8M+7fqyFN98Vjwmr2VPc9rUSriHu/1AGgHy0HbDikHcXbtEnm+YU+LobfHwHmPRNBzBjb96pBBU52es7qc8ORFRKQQPnmIu5CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YfyfTpj2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YfyfTpj2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5D94GQCz3bpM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:09 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so4805551a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095688; x=1781700488; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrxTcenItW2gu16uj0ViHf2ekVBrXj9Zuq6BUQC9S+E=;
        b=YfyfTpj2TJRfCNTAzwF9mWypbrUzw1LobGv7aeu1oZuI1ujQLE8fPkZqPKDBPvVwuv
         /W3twhuuFHVCbyl8Bo5qCE8jPJ2d0EcUwTxikzSLe9ScADcL69i4tOmCGOG1CIXJ5sIo
         UB0E9b/C9iOCQ9qwFRhC8htlAQzYJhzzW4uxOlvcs4T74pUw/O7rIObhbX1CkBSBcFBS
         NVwKtq6NOJ9v9j/Ik8bYhi+EGsDEQfrEurOtZ5kaA6Z3QVlo5A/zXsovKdE3bousgNgM
         tXBu9LJ5N+jsKLx1XwGxoZhdjkBqXmDdm+INvGQ0pvsA8j9ldhHLq0ldF57suoj2zJKo
         cYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095688; x=1781700488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrxTcenItW2gu16uj0ViHf2ekVBrXj9Zuq6BUQC9S+E=;
        b=VNbnp6vO9e6386O1QqgUk+qf15B7Zwsz1z/p0+mT/MM4mRkbRpboGU8fnlQDodROWZ
         7uonsuJBIrWB3kuphldlljcxFc0Bub3XTZR/9JiDIZjndBb9G9UIwHiaKLrWv4YHxcSX
         unuEZ9SIEWmob2f7NJ+NBOK5OMpG/mIWKE8SxAf+WYSjRZO3P6npGj7e3k3627zV0Lwi
         mUeS+jxzEEKwOG4F4DDNr9kkdDU7A8rq9Mu6utyOgajqxAu4TE+Jnq2YAWL+u+KU1xrU
         N6fxALg8J8+lMABmFLBDYq0IpuigtS43XCywW3ujrF0kKVdPngjYQNCIke/YAbMH+yrd
         /pUg==
X-Gm-Message-State: AOJu0Yw8R2EO83CXz2bgueAClqI37vijglI8srgm+TVOM4Nb5aeOLr+3
	ysA4aZ7n/bIBRZwj3xV2fmmt/aWL8FTEOsEJlQ2daxB8kcsObF+OfNSo
X-Gm-Gg: Acq92OE2GXza/Gwnyq+rUQZ7BDEKX9aYlNW/wGeh9JS+zQE6njSAAfpfCEuUiStA3Md
	/S5tkdDfDhe4OWvXhRNvmM+NqSj9eHUfHBo1y13blaJUZQz6fOagtxGIFB/J8Ukr27+3j5WrvZG
	BpgB4IWdFGPQrqkkjUurCKmKgKxotY/DNUcqJaTeaJ8IwILirlrKaliUWvcM3L5rwNJCUmI4Aa5
	brWb0OrLqQz4EB1MCmLtau25t2OH05IfIxjPuYuC07O5U1K3S/JVMEieu9D4EBWe1orAWhkv2fl
	68X5nsQaiT5n40V5yzcwFCcVEsC98MdPlM2gK2H48JFq/6wrt0EXVE6rPjMRmSGfK3j/I2C2MIP
	UAg74q8nj5EN4N0lGB8xK99x8yMPBBxfkAYTlllV5iWhskGbhDm52SRlDF+DDmky3AwZs74j+1E
	jQvzU/zwlZAKOWBPVkmzzPKQLysjiQ+M7LtCJtQ2u92qKoH4N944D31kOv5clyJw==
X-Received: by 2002:a17:90b:560d:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-3712ffaa11fmr18804464a91.3.1781095687672;
        Wed, 10 Jun 2026 05:48:07 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:06 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 05/10] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
Date: Wed, 10 Jun 2026 18:17:21 +0530
Message-ID: <2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the vcpu_id and errno when the KVM_CREATE_VCPU ioctl fails, for
debug purposes.
This helped in debugging an issue with KVM on PowerVM, where KVM_CREATE_VCPU
only supports max 2048 vcpus, because the PAPR_HCALL H_GUEST_CREATE_VCPU
("Documentation/arch/powerpc/kvm-nested.rst") supports only up to 0-2047
vcpu_id. However KVM_CAP_MAX_VCPUS capability extension always reports max_vcpus
as NR_CPUS of the host.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e00a25f59416..6319e2037882 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1354,6 +1354,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+	if (vcpu->fd < 0) {
+		int saved_errno = errno;
+
+		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+			vcpu_id, saved_errno);
+		errno = saved_errno;
+	}
 	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
-- 
2.50.1 (Apple Git-155)


