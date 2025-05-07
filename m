Return-Path: <linuxppc-dev+bounces-8397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC82C3ABC0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 May 2025 15:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZszMG3mfMz30W5;
	Thu,  8 May 2025 01:14:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746630874;
	cv=none; b=B1Jv7WzLxXbZCkk7v9yWbdULdigG5JS28/ox5OvA4oJzjFM2W7kiIvgNVGn9s9eOpoH6zFQejv/Tks2DmblNE4V8WpVkqHtABLBFaLYClUh9ea2fSY5HPWKTAn6oemGXzgPBpdhYeA0u2Wm5mBUjAANKJ8CVAg3hwcqNMB4OnX2TeIHT7sK/L8TgXOkfnJ5AgIAGvYlCF++opr3tc2R2fMRP3SWxpzqLJWG307x2odrlwoOHg43ihxpVXvvsSblNcxffYW8SkZ5rbxRUR3jEg6dbsws5S8qo7cStL/g3K/t9SvY2IVJwJ5YQkhKkGsKMJtxJuJ3cse6V3sPbwNleJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746630874; c=relaxed/relaxed;
	bh=wYS9gDsgD62VqeStKXk08KvwX5pMCV8rbvgxzL/Sy1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gALkwKo5YkzB1n9P3oEbnQ47hE4Xx7z2lR/FYMWqaAPSG5BqkCWaM7xh8msYn9aBvBth3ez+AkKlfsqxOkqHcZc6tUFC+AL7YFS6j/WmBx2CzN3TKgQF/M7qmb3GqtVGnunghUvOVx2tMz0eNq6vLM+PGdsr+Gt2Tn/IM6U7p7BPNgKN1uyJZYhKiaxdMMs8BvYIvx8sRWsWt1ENsRO6WnOKI0w0jd6nVVKxUsVp8eXdSqM0GC+mOeL5c92yjr5HLJgMjgb8gnzj5d3evpejJX3mdxZJU4yea67sw0uphoqr3QyIdSQTTIMUJVnsUo0oZYRkvewkJGzATufiHUtleQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=alexandru.elisei@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=alexandru.elisei@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZszMF71Hsz30Vn
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2025 01:14:33 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A9C22EA;
	Wed,  7 May 2025 08:13:52 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D3E3F58B;
	Wed,  7 May 2025 08:13:59 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: andrew.jones@linux.dev,
	eric.auger@redhat.com,
	lvivier@redhat.com,
	thuth@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	joey.gouly@arm.com,
	andre.przywara@arm.com
Subject: [kvm-unit-tests PATCH v3 14/16] scripts/mkstandalone: Export $TARGET
Date: Wed,  7 May 2025 16:12:54 +0100
Message-ID: <20250507151256.167769-15-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507151256.167769-1-alexandru.elisei@arm.com>
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
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

$TARGET is needed for the test runner to decide if it should use qemu or
kvmtool, so export it.

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 scripts/mkstandalone.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
index 4f666cefe076..3b2caf198b00 100755
--- a/scripts/mkstandalone.sh
+++ b/scripts/mkstandalone.sh
@@ -47,6 +47,7 @@ generate_test ()
 	config_export ARCH_NAME
 	config_export TARGET_CPU
 	config_export DEFAULT_QEMU_CPU
+	config_export TARGET
 
 	echo "echo BUILD_HEAD=$(cat build-head)"
 
-- 
2.49.0


