Return-Path: <yinghai@kernel.org>
Received: from rcsinet14.oracle.com (rcsinet14.oracle.com [148.87.113.126])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rcsinet14.oracle.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25243B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 15:00:29 +1000 (EST)
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by rcsinet14.oracle.com (Sentrion-MP-4.0.0/Sentrion-MP-4.0.0) with
	ESMTP id o8D4GfPS011411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 04:16:41 GMT
Message-ID: <4C8DA517.9000603@kernel.org>
Date: Sun, 12 Sep 2010 21:14:15 -0700
From: Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: build warnings after merge of the final tree (tip
	treee related)
References: <20100913132721.5a02cfbc.sfr@canb.auug.org.au>
In-Reply-To: <20100913132721.5a02cfbc.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2010 08:27 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-post-merge tree, today's linux-next build (powerpc
> allnoconfig, i386 defconfig and others) produced these warnings (I build
> with CONFIG_DEBUG_SECTION_MISMATCH=y):
> 
> WARNING: mm/built-in.o(.text+0x25910): Section mismatch in reference from the function memblock_find_in_range() to the function .init.text:memblock_find_base()
> The function memblock_find_in_range() references
> the function __init memblock_find_base().
> This is often because memblock_find_in_range lacks a __init 
> annotation or the annotation of memblock_find_base is wrong.

please check it, and it should get into core/memblock branch.

Thanks

Yinghai

[PATCH] memblock: Fix section mismatch warning

for arches that use memblock other than x86

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yinghai Lu <Yinghai@kernel.org>

---
 mm/memblock.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/mm/memblock.c
===================================================================
--- linux-2.6.orig/mm/memblock.c
+++ linux-2.6/mm/memblock.c
@@ -125,8 +125,8 @@ static phys_addr_t __init memblock_find_
 	return MEMBLOCK_ERROR;
 }
 
-static phys_addr_t __init memblock_find_base(phys_addr_t size, phys_addr_t align,
-					phys_addr_t start, phys_addr_t end)
+static phys_addr_t __init_memblock memblock_find_base(phys_addr_t size,
+			phys_addr_t align, phys_addr_t start, phys_addr_t end)
 {
 	long i;
 
@@ -439,12 +439,12 @@ long __init_memblock memblock_remove(phy
 	return __memblock_remove(&memblock.memory, base, size);
 }
 
-long __init memblock_free(phys_addr_t base, phys_addr_t size)
+long __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 {
 	return __memblock_remove(&memblock.reserved, base, size);
 }
 
-long __init memblock_reserve(phys_addr_t base, phys_addr_t size)
+long __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 {
 	struct memblock_type *_rgn = &memblock.reserved;
 
@@ -693,7 +693,7 @@ int __init_memblock memblock_is_region_r
 }
 
 
-void __init memblock_set_current_limit(phys_addr_t limit)
+void __init_memblock memblock_set_current_limit(phys_addr_t limit)
 {
 	memblock.current_limit = limit;
 }
