Return-Path: <linuxppc-dev+bounces-21430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1402CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 11:15:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN01N1MWyz2yH4;
	Sat, 23 May 2026 21:15:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779534920;
	cv=none; b=Z3fwyTrKDl2pTa4CX1T+cSXSbnrfEcp+7ZPwRmtl0u9BiKJFF8ByGxx5UrJm75DtWNZRkcN355it2RyLRch+lcQDn1yR8X3z1qWk4WudSutfDDZ73It4PnGYHXugQl1nInXN1S2/7GboZ4xfyfSeH8hwElkxl/XBLQiaACzETsoIQbBqi9S1oupDpx3q4GgHIiedXEDMsdVkNghfcuXkWBKhLb7g1MNuDLkaT748TaToN+8Noc9iq8oU2GEAO1UTAA27m/2FR4CQ+a3cyCdnZwgXlVsegwr6g86UDXEUwTGpug9YAjpkNeGUr+potkv33PbOnMSIqWKMMytt2bNGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779534920; c=relaxed/relaxed;
	bh=vTfV5I/6+8PKgpUetxyiP6m2rwpoR69hVt3JVVxbU6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWUZa5594GB+O7jxIQDrRMiZGo3TbaVcQQs4kFSvcfZNJcP+I2J/KwQFybutb8am9lmJzPfm53znIZL5joHjpTtlWy9jv1Q//0zG1Ak2ZX/7htm8hyCE54u99o1gw1D0JQVcAiB9Z8zoXWUE8XOMhMrh/L1Ky9wdZTRYaUMvlpvRFVGx7G5vDxsz+PBkMe0Qybl0Ldp2ket1OspaCYbfeCO06gU5BtzUuIVuUN2kGWosdAkFNAcX37vkHoIUCCvBCP7hfma6OSrAsKRINcXccCYftw4cAn/hVwp3+B9R5tVGqL6/7bOhdOuCJC+Z0P7wIj5afDIrwbFzkpZ5z//mXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FJejwyLf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FJejwyLf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN01M3bG8z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 21:15:19 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8413ac3d82fso3067604b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534918; x=1780139718; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTfV5I/6+8PKgpUetxyiP6m2rwpoR69hVt3JVVxbU6o=;
        b=FJejwyLfp4nyzEQMp1X1TT6hKTbVlyEeOVM8mD63MVKyA6R9E4fKhM5hEw7uMwOVbt
         wf4TD981cxohLE5zoPp3ew3jObe2MtyeTCG46P+sYB1ZBVkEVXtGuUz4k2PVvDAJrSqe
         NPI+YXiK1m8tkIOgRXcH88088lAXFgEM44I5yIz7pO7NKucwb2SrvFFMXFwiOlrG2JWw
         HlpblvMBzBz4z52PvJ1bK2J5EeNUfUvYAtn5oj0n0p2rq6w/3ACM6B1uHeHoU8PDfc86
         unGedTIUH/zswo8AnG967VKdHg+jBN6IAE6W6hw9t1vCthD38fpx+QZk8oFkd1WSaN50
         Ei+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534918; x=1780139718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTfV5I/6+8PKgpUetxyiP6m2rwpoR69hVt3JVVxbU6o=;
        b=dZ2a8ji1y4GAuERy1Yav1XzDdVPEvvoW/1lgq/F3HwQ48z1PBckFKDjcsmKSDcCdW8
         Uk6dRn4gDJE13UPtGq6X9Gphz7gPO5llRcGTflcwQgFFD/pOzUykMbGn5qYSoWdAcH7x
         /NrxH++gcSOB0qtxsxFuLIKbbqgAXOYne3bSaG1hQq/vOQnMCpXLwYzrAB21+gENH2TU
         JfPiDwq3Mo9G9sgDaXWhZ9HpveTyWpSiutybBv86DVSsYqNkOjPWss4/ZvmdOX4degmm
         T+83CdrSRSKKeHJJHmwWUUb12XalVBUn+EGTZI6eOx0aa0SXI8qSvHRTGvPp+gPPteBf
         ipaw==
X-Gm-Message-State: AOJu0YzvwLY6pmBP3mIX/LUr9GslTwPSh3OiY15o/TJ1ww/WRmywd9hH
	BwtgAs8YX05UqvgVKsGVIekQ8KYkN+/bWKTxQ8Z2pOKbzARZ8S1E6cLz
X-Gm-Gg: Acq92OGTuW8kQGxrk6blJViLe4dwWbMCNmDKi3LtUqe4vxyMX9cyoTEnYEoNz71eX+f
	mxh/k4oSOnJAZhXnulzs4m8eX0VywgXp9+K/bqRDrqhmyvusAcYz0FfODl/A7GIM4l3zqkuPS+9
	xGsQk0EtDPeIyVkGSTC7E8/dnmO/lAkIXzuatisxKk7E7PIEYjJ5MG4vLYRnM0d/IyKzZE5IReE
	Lp4pEVq+cEvWNXI9uFxMQy35rq0v3hYq/Mlb42elnyjfKOE0xKhccz1BOMnjnt11y1+97iJEqa9
	wFrpDrg0HUsk/kE33n9XbfXAqoUV4Nm1FxVgr/GkgT4N2W6DwXNfPzu6JeVObGDv5AScHPMAkt1
	qUpLoe/dNEA9mu2nAhiKBeLvWgftQOMRqVuSt7wPb/yJa7U7uQhwrslUfJ0drEwrtBIbSO9gGZV
	1FFtWFJ4Ms/GjPnrghYJvR01W0O9O3WmSsTDdAPKk=
X-Received: by 2002:a05:6a00:3d08:b0:83e:f75d:828d with SMTP id d2e1a72fcca58-8415f15a770mr7487815b3a.16.1779534917676;
        Sat, 23 May 2026 04:15:17 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.15.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:15:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 5/5] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
Date: Sat, 23 May 2026 16:44:24 +0530
Message-ID: <12184d5eda089814659d5a861b3ebc30d42733a3.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
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
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0dc67c1502cf..6a0ee6803623 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1354,6 +1354,9 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+	if (vcpu->fd < 0)
+		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+			vcpu_id, errno);
 	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);

 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
--
2.39.5


