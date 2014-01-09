Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C57082C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 11:02:35 +1100 (EST)
Date: Wed, 8 Jan 2014 18:02:19 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20140109000219.GA6884@home.buserror.net>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
 <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
 <1388796549.11795.100.camel@snotra.buserror.net>
 <20140104063452.GA11548@pek-khao-d1.corp.ad.wrs.com>
 <1389138364.11795.205.camel@snotra.buserror.net>
 <20140108024235.GA20739@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140108024235.GA20739@pek-khao-d1.corp.ad.wrs.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 08, 2014 at 10:42:35AM +0800, Kevin Hao wrote:
> On Tue, Jan 07, 2014 at 05:46:04PM -0600, Scott Wood wrote:
> > Oh.  I think it'd be more readable to do "offset = start -
> > memstart_addr" and add offset instead of subtracting it.
> 
> Yes, I agree. The reason that I use "offset = memstart_addr - start" is that
> it seems "memstart_addr" is always greater than "start" when we are booting
> a kdump kernel with a kernel option like "crashkernel=64M@80M". :-)
> 
> > 
> > Also, offset should be phys_addr_t -- even if you don't expect to
> > support offsets greater than 4G on 32-bit, it's semantically the right
> > type to use.  Plus, "int" would break if this code were ever used with
> > 64-bit.
> 
> I thought about using phy_addr_t for the "offset" originally but gave it up
> for the following reasons:
>   * It will not be greater than 4G.
>   * We have to use the ugly #ifdef CONFIG_PHYS_64BIT in restore_to_as0().
>   * Need more registers for arguments for restore_to_as0().
> 
> Of course you can change it to phys_addr_t if you prefer.

Here's the diff I made when applying (also changed the subf in patch 9 to
add)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 71e08df..b1f7edc 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1251,7 +1251,7 @@ _GLOBAL(switch_to_as1)
  * Restore to the address space 0 and also invalidate the tlb entry created
  * by switch_to_as1.
  * r3 - the tlb entry which should be invalidated
- * r4 - __pa(PAGE_OFFSET in AS0) - __pa(PAGE_OFFSET in AS1)
+ * r4 - __pa(PAGE_OFFSET in AS1) - __pa(PAGE_OFFSET in AS0)
  * r5 - device tree virtual address. If r4 is 0, r5 is ignored.
 */
 _GLOBAL(restore_to_as0)
@@ -1266,8 +1266,8 @@ _GLOBAL(restore_to_as0)
 	 * so we need calculate the right jump and device tree address based
 	 * on the offset passed by r4.
 	 */
-	subf	r9,r4,r9
-	subf	r5,r4,r5
+	add	r9,r9,r4
+	add	r5,r5,r4
 
 2:	mfmsr	r7
 	li	r8,(MSR_IS | MSR_DS)
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index ce0c7d7..95deb9fd 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -291,7 +291,8 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 	 * and do a second relocation.
 	 */
 	if (start != memstart_addr) {
-		int n, offset = memstart_addr - start;
+		int n;
+		long offset = start - memstart_addr;
 
 		is_second_reloc = 1;
 		n = switch_to_as1();
@@ -299,7 +300,7 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 		if (memstart_addr > start)
 			map_mem_in_cams(0x4000000, CONFIG_LOWMEM_CAM_NUM);
 		else
-			map_mem_in_cams_addr(start, PAGE_OFFSET - offset,
+			map_mem_in_cams_addr(start, PAGE_OFFSET + offset,
 					0x4000000, CONFIG_LOWMEM_CAM_NUM);
 		restore_to_as0(n, offset, __va(dt_ptr));
 		/* We should never reach here */

-Scott
