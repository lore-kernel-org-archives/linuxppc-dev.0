Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B50606C15A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MDoVmDfF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5LR3BxXz2xLG;
	Sat, 14 Nov 2026 05:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794594383;
	cv=none; b=JdOg0GsvoDRsx/vc909BDEH8xkCph0BvhODp61RhwmjFrtoqX93qg40UWPtTbpxHSBxGFConS+69Ut1ArknLxzTus3vK+e3591eh5AKHhvIpfYZ/4svQ9A0RnIBuFIL84CUGM7BI7Bgzb/KgPZMTFZlXRg550IccgdmNUyzt3tXUZHJx/Yvsec3l3OLh9X222vOfrDn4jzhdrcIWi0FyhgyymEczkUU8d0TlxPWAeqXdUjXnRRCI0SJiIlPDFTZi8oOWh2D5lWgFhGNYgrtr5K/B/VAy8DV5ojf0N+uK6MhfgCaEeRlurrNpv69puAmiGA/kDjfxVF+MOvXRYz92Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794594383; c=relaxed/relaxed;
	bh=L0/xkeoaYWQSJNfGfg1c3/dC03KyiBSAIbTg/u+AAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN3R9e3xX257/3dSUsqmyzUJiRL7HtpfBl08Nfsq0N5o8VSm0VnQIMu+0YiZKnkWk6he3Sqwyz3Ou4YgTrew4/pZl2EYcGFZJaA8fRka+rMvrdnmcS6r8GX/cq4HuVaTrsu3VAReEZi6vVg5UvPAbFaxR1YNHCtURl3V9YaE/5lyjQJUpjsx7rdNSQyeuZs6haKwVhWBaei1X3kj2vpf2c9l4/hOIn8+Qj65v3EDosnX/bk7urdtdaVJRT/EGmRp+IZXPiStcGVNA2rPV+w70Rn2e2CKUuFuH8b4xX3vAK4FNZxnwvu7PVM/9F7CUFZctmUXi6EpdyMbtg3ubxj3hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MDoVmDfF; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+7654657bf7a82263391f+8482+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MDoVmDfF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+7654657bf7a82263391f+8482+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5LJ6NHRz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:26:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L0/xkeoaYWQSJNfGfg1c3/dC03KyiBSAIbTg/u+AAuc=; b=MDoVmDfFjbP858b/jFt58GtX4T
	Pxy1Co3vnlEUbk6lLShLJOcmUhsZrj4d9zQHs4e7mkpiMrPurWdpF9wqXbeKrEQWjptNTCF3XyqRT
	HgqxSr+qjqEk08qIbpPIVurxch4WPFz2iiIG6rIN9CB8J1ovmvuI8A0zghVqWjzGdyOtyrjJXZY2+
	Gwo7aOsrT0F6KzJ0IC2orRGtUs0Q3hK/bAIhDmLJaufaFUDNuUUjzWNwjNcIYk/oZ3ktc86/eIL1s
	EWY7sWZlLutzgIuBacYRikb5udeNwuxXAoe8MahzU7+lBv+p4k96n1QqjcoDIP/3NyhDuk6DfRHtz
	pLgKmx7g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvyR-00000004cSs-2gKx;
	Fri, 13 Nov 2026 18:26:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRvyR-00000000LXz-1tUE;
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
Subject: [RFC PATCH 03/13] KVM: selftests: Add x86 planes lifecycle test
Date: Fri, 13 Nov 2026 11:25:57 -0700
Message-ID: <20261113182607.82813-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113182607.82813-1-dwmw2@infradead.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20261113182607.82813-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

Cover KVM_CAP_PLANES argument validation against the system fd's
ceiling, its split-irqchip and ordering requirements, plane creation
bounds, plane vCPU creation, and per-plane isolation of vCPU register
state. Skip on hosts that cannot give a VM more than one plane, such
as those without TDP.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/x86/planes_test.c | 137 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index cdc6039d32d2..2926817baad0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -111,6 +111,7 @@ TEST_GEN_PROGS_x86 += x86/nested_vmsave_vmload_test
 TEST_GEN_PROGS_x86 += x86/nested_x2apic_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/plane_x86_test
+TEST_GEN_PROGS_x86 += x86/planes_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/x86/planes_test.c b/tools/testing/selftests/kvm/x86/planes_test.c
new file mode 100644
index 000000000000..f7db6cb6807d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_test.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test the KVM_CAP_PLANES opt-in and the plane lifecycle uAPI: plane
+ * creation bounds, plane vCPU creation, and the independence of
+ * per-plane vCPU register state.
+ */
+#include <errno.h>
+#include <string.h>
+
+#include "kvm_util.h"
+
+/*
+ * Whether this host lets a VM have more than one plane: the opt-in also
+ * fails without two-dimensional paging, which the system fd cannot show.
+ */
+static bool have_multiple_planes(void)
+{
+	struct kvm_vm *vm = vm_create_barebones_irqchip(true);
+	bool ok = !__vm_enable_cap(vm, KVM_CAP_PLANES, 2);
+
+	kvm_vm_free(vm);
+	return ok;
+}
+
+static void test_enable_cap_bounds(void)
+{
+	int max_planes = kvm_check_cap(KVM_CAP_PLANES);
+	struct kvm_vm *vm;
+
+	/* Planes require a split irqchip: without one the opt-in fails. */
+	vm = vm_create_barebones();
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 2), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+	kvm_vm_free(vm);
+
+	/*
+	 * With one, the system fd's value is the most a VM may be given,
+	 * and a full in-kernel irqchip cannot replace the split one later.
+	 */
+	vm = vm_create_barebones_irqchip(true);
+
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 0), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	TEST_ASSERT(max_planes > 1 && max_planes <= KVM_MAX_PLANES,
+		    "system fd KVM_CAP_PLANES ceiling %d", max_planes);
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, max_planes + 1), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	vm_enable_cap(vm, KVM_CAP_PLANES, max_planes);
+	TEST_ASSERT_EQ(vm_check_cap(vm, KVM_CAP_PLANES), max_planes);
+
+	/* ENOTTY where KVM_CREATE_IRQCHIP is compiled out (KVM_IOAPIC=n). */
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL), -1);
+	TEST_ASSERT(errno == EEXIST || errno == ENOTTY,
+		    "KVM_CREATE_IRQCHIP after the opt-in: errno %d", errno);
+
+	kvm_vm_free(vm);
+}
+
+static void test_enable_cap_too_late(void)
+{
+	struct kvm_vm *vm = vm_create_barebones_irqchip(true);
+
+	__vm_vcpu_add(vm, 0);
+
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 2), -1);
+	TEST_ASSERT_EQ(errno, EEXIST);
+
+	kvm_vm_free(vm);
+}
+
+static void test_plane_lifecycle(void)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+	struct kvm_plane_vcpu *vcpu1;
+	struct kvm_regs regs0, regs1;
+	struct kvm_plane *plane;
+	struct kvm_vcpu *vcpu0;
+	int r;
+
+	vm_enable_split_irqchip(vm);
+
+	/* Without the opt-in a VM has a single plane. */
+	TEST_ASSERT_EQ(vm_check_cap(vm, KVM_CAP_PLANES), 1);
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	vm_enable_cap(vm, KVM_CAP_PLANES, 2);
+	TEST_ASSERT_EQ(vm_check_cap(vm, KVM_CAP_PLANES), 2);
+
+	/* The configured count is a hard bound, and reconfiguration a hard no. */
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_CREATE_PLANE, (void *)2UL), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	plane = vm_plane_add(vm, 1);
+
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 3), -1);
+	TEST_ASSERT_EQ(errno, EEXIST);
+
+	/* A plane fd takes plane ioctls only; capabilities are a VM matter. */
+	r = __plane_ioctl(plane, KVM_CHECK_EXTENSION, (void *)KVM_CAP_PLANES);
+	TEST_ASSERT(r == -1 && errno == ENOTTY,
+		    "KVM_CHECK_EXTENSION on a plane fd, expecting ENOTTY. ret: %d, errno: %d",
+		    r, errno);
+
+	vcpu0 = __vm_vcpu_add(vm, 0);
+	vcpu1 = __vm_plane_vcpu_add(vcpu0, plane);
+
+	/* Register state is per plane: write plane 1, plane 0 unaffected. */
+	plane_vcpu_ioctl(vcpu1, KVM_GET_REGS, &regs1);
+	regs1.rbx = 0x5157ca11;	/* arbitrary marker */
+	plane_vcpu_ioctl(vcpu1, KVM_SET_REGS, &regs1);
+
+	vcpu_ioctl(vcpu0, KVM_GET_REGS, &regs0);
+	TEST_ASSERT(regs0.rbx != 0x5157ca11,
+		    "plane 0 RBX changed by plane 1 KVM_SET_REGS");
+
+	memset(&regs1, 0, sizeof(regs1));
+	plane_vcpu_ioctl(vcpu1, KVM_GET_REGS, &regs1);
+	TEST_ASSERT_EQ(regs1.rbx, 0x5157ca11);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PLANES));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP));
+	TEST_REQUIRE(have_multiple_planes());
+
+	test_enable_cap_bounds();
+	test_enable_cap_too_late();
+	test_plane_lifecycle();
+
+	return 0;
+}
-- 
2.50.1


