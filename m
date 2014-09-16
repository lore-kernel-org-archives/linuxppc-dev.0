Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8B601A0020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:49:13 +1000 (EST)
Date: Tue, 16 Sep 2014 10:49:14 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 torvalds@linux-foundation.org
Subject: [PATCH 2/2] powerpc: Use CONFIG_ARCH_HAS_FAST_MULTIPLIER
Message-ID: <20140916104914.66abcca1@kryten>
In-Reply-To: <20140916104749.35b84da8@kryten>
References: <20140916104749.35b84da8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I ran some tests to compare hash_64 using shifts and multiplies.
The results:

POWER6:	~2x slower
POWER7: ~2x faster
POWER8: ~2x faster

Now we have a proper config option, select
CONFIG_ARCH_HAS_FAST_MULTIPLIER on POWER7 and POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -116,10 +116,12 @@ config POWER6_CPU
 config POWER7_CPU
 	bool "POWER7"
 	depends on PPC_BOOK3S_64
+	select ARCH_HAS_FAST_MULTIPLIER
 
 config POWER8_CPU
 	bool "POWER8"
 	depends on PPC_BOOK3S_64
+	select ARCH_HAS_FAST_MULTIPLIER
 
 config E5500_CPU
 	bool "Freescale e5500"
