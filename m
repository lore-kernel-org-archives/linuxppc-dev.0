Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE3CC77B72
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Apr 2023 13:40:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PycyT180Sz3fq3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Apr 2023 23:40:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=hGGuyp/I;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pyccv1bSRz3fTL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2023 23:25:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=hGGuyp/I;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pyccv0jRQz4xN1;
	Fri, 14 Apr 2023 23:25:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1681478703;
	bh=YGOYFRl3rrbA/EPs+QenrfhI7Gj23R5ghzpu7PW1ips=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hGGuyp/ILAg78qRSKftnBGjsiSQs//+9wneSmtNPwkjHuOlNiMn1ELOGVSRjQV2jZ
	 f8ObYYwf2itNCKTkxnbsC4yKM3I/mEpBaHlbXJrbi5BRc8VjUQsPJ1HKE5weXK8tY+
	 hg8UFX4oK3gUEk9w6nrVFp0XZRopJEtcWqbQbXLSeDMEz/ynUzAEBrDrXqvi1Fzxqx
	 YjbbWK4D0ZFwcptg2bn3Kk9JrrNozQsJeY8UAp8OfqiaOpFCJapfYqMuUOxo/xokNK
	 DsOSwZUxIWYWGzWZ9Apkgnz5f50LljOpzJfNs+QxHLlpjVos3AJwsvjMoAzeTFO7B5
	 kOvb9EcpYbWVA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 20/32] powerpc/configs/64s: Enable DEBUG_VM & other options
Date: Fri, 14 Apr 2023 23:24:03 +1000
Message-Id: <20230414132415.821564-20-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414132415.821564-1-mpe@ellerman.id.au>
References: <20230414132415.821564-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fedora enables DEBUG_VM, which has led to occasions where a VM_BUG_ON()
is not caught by upstream testing, but rather is first found in Fedora,
which is not how it's meant to be.

PAGE_OWNER & PAGE_POISONING both need to be enabled on the kernel
command line, so should not add much overhead in normal operation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index c8b49e33fd81..3154f307bba6 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -397,14 +397,20 @@ CONFIG_PRINTK_TIME=y
 CONFIG_PRINTK_CALLER=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PAGE_OWNER=y
+CONFIG_PAGE_POISONING=y
 CONFIG_DEBUG_RODATA_TEST=y
+CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_DEBUG_VM=y
+# CONFIG_DEBUG_VM_PGTABLE is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_FUNCTION_TRACER=y
 CONFIG_LOCK_TORTURE_TEST=m
+CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_STACK_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
-- 
2.39.2

