Return-Path: <linuxppc-dev+bounces-26470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B67C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcw0Wxrz30dL;
	Thu, 03 Sep 2026 17:51:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421903;
	cv=none; b=RL5M8tQwdB30dxxOXCj6ipuNiQ9aDt2UcEnOqOxWA8FQ+elpaG05BEala/fD/TFGYQqYCjokfojTLZE/z9RxUAkkkp1Omwe/X4An9ZtH0KNWrF/MZctQaPmJ0bcGhdX0cTF1oYoq2kN9yqSCHL7GYSCK58eOdwS8iCvY2VazijAf1Vro4lq6NXmolLpzrB+B4OD5AiJXlAV1Iof9uKhOas8NjZC4KkL/wr5Mz9+nkeazhfJmNG9ZQ7M3NPjosgVvdcpUx+6Ykb8WzuVFVDRDSOi8RAGaMX+OmroiY0TiyzXtXf5borp36vxenK88KhC/JyNcr4Bd+qrRwX/IvKgu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421903; c=relaxed/relaxed;
	bh=M7w6IVovisCb503Pkoci8pxom1cMDymO/FBqfuq2HGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7Ul4mbD1plMNzC9aLLCrdNDkO8Qt+T7Sn0RO+u2icGhayGNlBtyTAkfWsANvwX0T4POUVU/XR1Me91/WkCeWgpwDtAHj4S8uuViD76qjsH4rtGf34l3EXkM6fF7ZMrWQwxTrG+BPT4QzL3mQaK79PdWSmlyR8OmT6MWAvpSFH5a/GCEj0e+SBsavL6kRYG0CcrtxpsToo8N20H7kaiTTxIUY9EId4RmvnEsH3UvFExUtCTkt5PMXAyl9Ccuz5AwVrjr1c1ni50En6anU5YRl6wqvcV/18jnbkStBa9JKUBH2QjcgS/84rHIpznEPwuymVVBIqg2+OSnkMtwLDM0Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YUrsKLYp; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aK0JbXjU; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YUrsKLYp;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aK0JbXjU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcs3BGlz3054
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:41 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7w6IVovisCb503Pkoci8pxom1cMDymO/FBqfuq2HGI=;
	b=YUrsKLYpR6VZq3FjSZ0tcH1u/iL3pnEqPkHzaoQflyy4+wMTPZ0gzLpbw3vB+4VDAnG5PH
	cZALG1imAlcNsXtsBsfkzXXtDu4/CILpTvEnECUkH4/6Eymd0VAAx2OHa8vO4HJB9WC50m
	pwxutgnUIdRLMt9P1NVK0ydGcpFQDiUaCW52VKIUOqjDwMcTn5pjVTRZhVUppMT8B99nvz
	MIRuXE5wp91zRf3+wqSlZ56x3BykPmTc2e+RiC/SINOmaTjzLo5hN58eiHfEc8+gpMUebh
	HBcSCjN8rFEv5nUId4u6Gcy7+jfPttRo4pHbHkYZ7T1rTYgSH02AWQdvWf6ZOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7w6IVovisCb503Pkoci8pxom1cMDymO/FBqfuq2HGI=;
	b=aK0JbXjU6gNUAZ7CUfQcDDU1452O226LFxU7OBZ5JiSzeBepGLdhKq3cRUyVBT8BcLiF64
	nYPh4Hh4QgFfyDAw==
Date: Thu, 03 Sep 2026 09:41:21 +0200
Subject: [PATCH v2 06/15] arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-6-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1590;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yzUJPF4+/uSgsYkr+YJKb+Uz3ZiMTGZCOEBRakgLSTw=;
 b=DdZRWT9PaRUgrbKuk0FccoE0UqsO8Wy2gW0MV+ISuIpLSi+dZ054rE9E0nfEX8/hbjKwvu4k3
 XkEx0oppmjkBBuo9UIQSI5eFpWB/CFJrAubMUD+gSbssc81nC2HqkDn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm64/include/asm/auxvec.h      | 7 +++++++
 arch/arm64/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/auxvec.h b/arch/arm64/include/asm/auxvec.h
new file mode 100644
index 000000000000..de24eaaa06e2
--- /dev/null
+++ b/arch/arm64/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 743c0b84fd30..fb51e906813a 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -14,13 +14,11 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_AUXVEC_H
-#define __ASM_AUXVEC_H
+#ifndef __UAPI_ASM_AUXVEC_H
+#define __UAPI_ASM_AUXVEC_H
 
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
 #define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.55.0


