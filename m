Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: fix call to subpage_protection()
In-reply-to: <1290020404.2974.15.camel@localhost>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost> <17075.1289877977@neuling.org>
	<1289958663.3028.175.camel@localhost>
	<27638.1289959435@neuling.org> <1290020404.2974.15.camel@localhost>
Date: Thu, 18 Nov 2010 13:32:59 +1100
Message-ID: <13149.1290047579@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In: 
  powerpc/mm: Fix pgtable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
  commit d28513bc7f675d28b479db666d572e078ecf182d
  Author: David Gibson <david@gibson.dropbear.id.au>

subpage_protection() was changed to to take an mm rather a pgdir but it
didn't change calling site in hashpage_preload().  The change wasn't
noticed at compile time since hashpage_preload() used a void* as the
parameter to subpage_protection().

This is obviously wrong and can trigger the following crash when
CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_PPC_64K_PAGES
CONFIG_PPC_SUBPAGE_PROT are enabled.

Freeing unused kernel memory: 704k freed
Unable to handle kernel paging request for data at address 0x6b6b6b6b6b6c49b7
Faulting instruction address: 0xc0000000000410f4
cpu 0x2: Vector: 300 (Data Access) at [c00000004233f590]
    pc: c0000000000410f4: .hash_preload+0x258/0x338
    lr: c000000000041054: .hash_preload+0x1b8/0x338
    sp: c00000004233f810
   msr: 8000000000009032
   dar: 6b6b6b6b6b6c49b7
 dsisr: 40000000
  current = 0xc00000007e2c0070
  paca    = 0xc000000007fe0500
    pid   = 1, comm = init
enter ? for help
[c00000004233f810] c000000000041020 .hash_preload+0x184/0x338 (unreliable)
[c00000004233f8f0] c00000000003ed98 .update_mmu_cache+0xb0/0xd0
[c00000004233f990] c000000000157754 .__do_fault+0x48c/0x5dc
[c00000004233faa0] c000000000158fd0 .handle_mm_fault+0x508/0xa8c
[c00000004233fb90] c0000000006acdd4 .do_page_fault+0x428/0x6ac
[c00000004233fe30] c000000000005260 handle_page_fault+0x20/0x74
--- Exception: 401 (Instruction Access) at 00000000f7937794
SP (ffef72c0) is in userspace

The following changes this subpage_protection() call.

Reported-by: Jim Keniston <jkenisto@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Tested-by: Jim Keniston <jkenisto@linux.vnet.ibm.com>
cc: David Gibson <david@gibson.dropbear.id.au>
cc: stable@kernel.org (only 2.6.33 and newer)
---
> It boots fine with pseries_defconfig.
> 
> Attached is the config file that I've been using, which is probably
> descended over many generations of kernels from some config file in my
> machine's distant past.  (Enable DEBUG_SLAB or DEBUG_PAGEALLOC and it
> will fail to boot.)  After I run 'make menuconfig' starting from
> pseries_defconfig...
> $ diff config_ok .config | wc -l
> 2052

I narrowed this down to adding the following on pseries_defconfig:
  +CONFIG_SLAB=y
  +CONFIG_PPC_64K_PAGES=y
  +CONFIG_PPC_SUBPAGE_PROT=y
  +CONFIG_DEBUG_SLAB=y
To reproduce the fail.  

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 83f534d..5e95844 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1123,7 +1123,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
 		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
-				    subpage_protection(pgdir, ea));
+				    subpage_protection(mm, ea));
 
 	/* Dump some info in case of hash insertion failure, they should
 	 * never happen so it is really useful to know if/when they do
