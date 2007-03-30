Return-Path: <SRS0+1020516fb0ec803710a0+1314+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1175210608.5624.42.camel@localhost.localdomain>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<1175210608.5624.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 01:27:48 +0100
Message-Id: <1175214468.3122.94.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-30 at 09:23 +1000, Benjamin Herrenschmidt wrote:
> How can this work ? Memory is parsed from early_init_devtree() which is
> called before the platform probe() routines which is the one that sets
> FW_FEATURE_PS3_LV1...  

Ah, good point. I was only testing on a PS3-only kernel -- I hadn't yet
graduated to a multiplatform kernel, because there were other problems
there (check_legacy_ioport).

At your suggestion, how about this approach instead...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- linux-2.6.20.ppc64/include/asm-powerpc/lmb.h~	2007-02-04 18:44:54.000000000 +0000
+++ linux-2.6.20.ppc64/include/asm-powerpc/lmb.h	2007-03-30 01:13:45.000000000 +0100
@@ -51,6 +51,7 @@ extern unsigned long __init __lmb_alloc_
 extern unsigned long __init lmb_phys_mem_size(void);
 extern unsigned long __init lmb_end_of_DRAM(void);
 extern void __init lmb_enforce_memory_limit(unsigned long memory_limit);
+void __init lmb_reset_available(void);
 
 extern void lmb_dump_all(void);
 
--- linux-2.6.20.ppc64/arch/powerpc/mm/lmb.c~	2007-02-04 18:44:54.000000000 +0000
+++ linux-2.6.20.ppc64/arch/powerpc/mm/lmb.c	2007-03-30 01:12:17.000000000 +0100
@@ -338,3 +338,11 @@ void __init lmb_enforce_memory_limit(uns
 		}
 	}
 }
+
+void __init lmb_reset_available(void)
+{
+	lmb.memory.region[0].base = 0;
+	lmb.memory.region[0].size = 0;
+	lmb.memory.cnt = 1;
+	lmb.memory.size = 0;
+}
--- linux-2.6.20.ppc64/arch/powerpc/platforms/ps3/mm.c~	2007-03-29 17:48:27.000000000 +0100
+++ linux-2.6.20.ppc64/arch/powerpc/platforms/ps3/mm.c	2007-03-30 01:24:04.000000000 +0100
@@ -796,6 +796,9 @@ void __init ps3_mm_init(void)
 
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
+	/* If an old-style device-tree registered memory, forget it */
+	lmb_reset_available();
+
 	result = ps3_repository_read_mm_info(&map.rm.base, &map.rm.size,
 		&map.total);
 

-- 
dwmw2
