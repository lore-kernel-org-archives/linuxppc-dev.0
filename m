Return-Path: <ericvh@gmail.com>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B7A8B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:25:26 +1000 (EST)
Received: by yib2 with SMTP id 2so779095yib.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 14:25:22 -0700 (PDT)
From: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] [RFC] force 32-byte aligned kmallocs
Date: Wed, 18 May 2011 16:24:53 -0500
Message-Id: <1305753895-24845-5-git-send-email-ericvh@gmail.com>
In-Reply-To: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For BGP, it is convenient for 'kmalloc' to come back with 32-byte
aligned units for torus DMA

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 arch/powerpc/include/asm/page_32.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 68d73b2..fb0a7ae 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -9,7 +9,7 @@
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_DEFAULT_FLAGS32
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
+#if defined(CONFIG_NOT_COHERENT_CACHE) || defined(CONFIG_BGP)
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 #endif
 
-- 
1.7.4.1
