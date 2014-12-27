Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com
 [IPv6:2607:f8b0:4002:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8FB11A019C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Dec 2014 04:17:15 +1100 (AEDT)
Received: by mail-yh0-f44.google.com with SMTP id c41so5681174yho.31
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Dec 2014 09:17:13 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/powernv: Select CONFIG_PRINTK to fix build failure
Date: Sat, 27 Dec 2014 12:17:44 -0500
Message-Id: <1419700667-24888-2-git-send-email-bobby.prani@gmail.com>
In-Reply-To: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In an allnoconfig we get the following build failure:

arch/powerpc/platforms/built-in.o: In function `.__machine_initcall_powernv_opal_init':
opal.c:(.init.text+0x468): undefined reference to `.log_buf_addr_get'
opal.c:(.init.text+0x474): undefined reference to `.log_buf_len_get'
make: *** [vmlinux] Error 1

This happens because powernv requires printk() support. Enable it in the config
file.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 45a8ed0..be4f340 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -18,6 +18,7 @@ config PPC_POWERNV
 	select CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_CONSERVATIVE
 	select PPC_DOORBELL
+	select PRINTK
 	default y
 
 config PPC_POWERNV_RTAS
-- 
1.9.1
