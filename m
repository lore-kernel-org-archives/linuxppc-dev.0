Return-Path: <tipbot@zytor.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97251A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 23:48:58 +1000 (AEST)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 908371401AB
 for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2015 23:48:58 +1000 (AEST)
Date: Fri, 8 May 2015 06:24:39 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Michael Ellerman <tipbot@zytor.com>
Message-ID: <tip-cb307113746b4d184155d2c412e8069aeaa60d42@git.kernel.org>
Reply-To: mpe@ellerman.id.au, bp@alien8.de, hpa@zytor.com,
 linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@osdl.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 peterz@infradead.org, anton@samba.org
In-Reply-To: <1430720799-18426-1-git-send-email-mpe@ellerman.id.au>
References: <1430720799-18426-1-git-send-email-mpe@ellerman.id.au>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf_event: Don't allow vmalloc()
 backed perf on powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: akpm@osdl.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org, hpa@zytor.com,
 bp@alien8.de, tglx@linutronix.de, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  cb307113746b4d184155d2c412e8069aeaa60d42
Gitweb:     http://git.kernel.org/tip/cb307113746b4d184155d2c412e8069aeaa60d42
Author:     Michael Ellerman <mpe@ellerman.id.au>
AuthorDate: Mon, 4 May 2015 16:26:39 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 8 May 2015 12:26:01 +0200

perf_event: Don't allow vmalloc() backed perf on powerpc

On powerpc the perf event interrupt is not masked when interrupts are
disabled, allowing it to function as an NMI.

This causes problems if perf is using vmalloc. If we take a page fault
on the vmalloc region the fault handler will fail the page fault because
it detects we are coming in from an NMI (see do_hash_page()).

We don't actually need or want vmalloc backed perf so just disable it on
powerpc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linuxppc-dev@ozlabs.org>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@ghostprotocols.net
Cc: sukadev@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1430720799-18426-1-git-send-email-mpe@ellerman.id.au
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index dc24dec..81050e4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1637,7 +1637,7 @@ config PERF_EVENTS
 config DEBUG_PERF_USE_VMALLOC
 	default n
 	bool "Debug: use vmalloc to back perf mmap() buffers"
-	depends on PERF_EVENTS && DEBUG_KERNEL
+	depends on PERF_EVENTS && DEBUG_KERNEL && !PPC
 	select PERF_USE_VMALLOC
 	help
 	 Use vmalloc memory to back perf mmap() buffers.
