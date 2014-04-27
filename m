Return-Path: <jeffm@suse.com>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B59D1400D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 08:10:49 +1000 (EST)
Message-ID: <535D8063.4060407@suse.com>
Date: Sun, 27 Apr 2014 18:10:43 -0400
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: export flush_icache_range
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit aac416fc38c (lkdtm: flush icache and report actions) calls
flush_icache_range from a module. It's exported on most architectures
that implement it, but not on powerpc. This patch exports it to fix
the module link failure.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 arch/powerpc/kernel/ppc_ksyms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -120,6 +120,7 @@ EXPORT_SYMBOL(giveup_spe);
 EXPORT_SYMBOL(flush_instruction_cache);
 #endif
 EXPORT_SYMBOL(flush_dcache_range);
+EXPORT_SYMBOL(flush_icache_range);
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PPC32

-- 
Jeff Mahoney
SUSE Labs
