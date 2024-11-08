Return-Path: <linuxppc-dev+bounces-3035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B6CD5E147
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Nov 2024 08:55:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlCST1lTRz3bsZ;
	Fri,  8 Nov 2024 19:55:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731056105;
	cv=none; b=VpPQVlPXpa5/POhOUboD1+6bfJkgTLwXAkwh3lbj+/m6ZuLM6fFkeuXdJOPYo66n0PnzGd/g3HLKDwlTgSDzlqDVAfSZRryBLJVIC7aoIqG+Wsa9QEwUnq8PiuEDSGtNI1+jwEyyqiFlQF55aaekz3J7rxo3SfAc4CWhT3M6qy9ByfbkIG3V0ceuk4y5Mx2ZuQj1+Wdb9Vxmc5kcN2ULyXnlMV70CfXO/VvDU+cqSXV9rvEQ54yXMHgmqECk3JjKn9zA0uITx5DnoLfpEfHVd9YSzF5BT/QgJXQgRYT/pHJTheR0bPJNinEQizctCPv0o8FyXj7T0Zgdj2UYy/MCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731056105; c=relaxed/relaxed;
	bh=gdBvhGgwT7J9BqqwWuvbIr961kRp60TDvUtegkTxbbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJ/NVtWabxLn+kScIilTF71noX0BX1lWVpA4Q+pjfVyAsY9w/jIHBZmPpFngLFxwcQXz+r1P7vqdwjMsXwJrrB7tuBf9yKssFgFScU2T2GjpW/6mR35EMCo2w4BKGzCxEbZUr3HeJdfLBzY6VEp/Ok2HfHGP0DKzXiXTgzL/nnMPG4IKXhBm0/H/nf59hIq7pdv4qW23u7q4NzWdx31pJRiAwEW93pX/6huosfqXmuXMpawCo9RZRBn0G3jYAjT7h5SI2+ohPlxxqid2/fEe0xuinZye8oY4ZhXExh3vMdYcOLbaymhNkcx0sYsU0/3FZADiJDphtBDaLoW3juXBFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=yury.khrustalev@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=yury.khrustalev@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlCSS32Ttz2yVD
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2024 19:55:04 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B90D1007;
	Fri,  8 Nov 2024 00:55:03 -0800 (PST)
Received: from udebian.localdomain (unknown [10.57.26.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64A93F66E;
	Fri,  8 Nov 2024 00:54:31 -0800 (PST)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH v4 1/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Fri,  8 Nov 2024 08:53:56 +0000
Message-Id: <20241108085358.777687-2-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108085358.777687-1-yury.khrustalev@arm.com>
References: <20241108085358.777687-1-yury.khrustalev@arm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory protection keys (pkeys) uapi has two macros for pkeys restrictions:

 - PKEY_DISABLE_ACCESS 0x1
 - PKEY_DISABLE_WRITE  0x2

with implicit literal value of 0x0 that means "unrestricted". Code that
works with pkeys has to use this literal value when implying that a pkey
imposes no restrictions. This may reduce readability because 0 can be
written in various ways (e.g. 0x0 or 0) and also because 0 in the context
of pkeys can be mistaken for "no permissions" (akin PROT_NONE) while it
actually means "no restrictions". This is important because pkeys are
oftentimes used near mprotect() that uses PROT_ macros.

This patch adds PKEY_UNRESTRICTED macro defined as 0x0.

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
---
 include/uapi/asm-generic/mman-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..ea40e27e6dea 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -82,6 +82,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_UNRESTRICTED	0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.39.5


