Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0143.outbound.protection.outlook.com [157.56.111.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 243501A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 10:19:47 +1000 (AEST)
Message-ID: <1442967567.19102.318.camel@freescale.com>
Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 22 Sep 2015 19:19:27 -0500
In-Reply-To: <SN1PR0301MB1550726A1D45051888E35EB59B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-3-git-send-email-qiang.zhao@freescale.com>
 <20150921224720.GA12709@home.buserror.net>
 <SN1PR0301MB1550726A1D45051888E35EB59B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-22 at 03:10 -0500, Zhao Qiang-B45475 wrote:
> On Tue, Sep 22, 2015 at 06:47 AM +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, September 22, 2015 6:47 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
> > 
> > On Fri, Sep 18, 2015 at 03:15:19PM +0800, Zhao Qiang wrote:
> > > Use genalloc to manage CPM/QE muram instead of rheap.
> > > 
> > > Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> > > ---
> > > Changes for v9:
> > >   - splitted from patch 3/5, modify cpm muram management functions.
> > > Changes for v10:
> > >   - modify cpm muram first, then move to qe_common
> > >   - modify commit.
> > > 
> > >  arch/powerpc/platforms/Kconfig   |   1 +
> > >  arch/powerpc/sysdev/cpm_common.c | 150
> > > +++++++++++++++++++++++++++------------
> > >  2 files changed, 107 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/Kconfig
> > > b/arch/powerpc/platforms/Kconfig index b7f9c40..01f98a2 100644
> > > --- a/arch/powerpc/platforms/Kconfig
> > > +++ b/arch/powerpc/platforms/Kconfig
> > > @@ -276,6 +276,7 @@ config QUICC_ENGINE
> > >   bool "Freescale QUICC Engine (QE) Support"
> > >   depends on FSL_SOC && PPC32
> > >   select PPC_LIB_RHEAP
> > > + select GENERIC_ALLOCATOR
> > >   select CRC32
> > >   help
> > >     The QUICC Engine (QE) is a new generation of communications diff
> > > --git a/arch/powerpc/sysdev/cpm_common.c
> > > b/arch/powerpc/sysdev/cpm_common.c
> > > index 4f78695..453d18c 100644
> > > --- a/arch/powerpc/sysdev/cpm_common.c
> > > +++ b/arch/powerpc/sysdev/cpm_common.c
> > > @@ -17,6 +17,7 @@
> > >   * published by the Free Software Foundation.
> > >   */
> > > 
> > > +#include <linux/genalloc.h>
> > >  #include <linux/init.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/spinlock.h>
> > > @@ -27,7 +28,6 @@
> > > 
> > >  #include <asm/udbg.h>
> > >  #include <asm/io.h>
> > > -#include <asm/rheap.h>
> > >  #include <asm/cpm.h>
> > > 
> > >  #include <mm/mmu_decl.h>
> > > @@ -65,14 +65,24 @@ void __init udbg_init_cpm(void)  }  #endif
> > > 
> > > +static struct gen_pool *muram_pool;
> > > +static struct genpool_data_align muram_pool_data; static struct
> > > +genpool_data_fixed muram_pool_data_fixed;
> > 
> > Why are these global?  If you keep the data local to the caller (and use
> > gen_pool_alloc_data()) then you probably don't need cpm_muram_lock.
> 
> Ok
> 
> > 
> > >  static spinlock_t cpm_muram_lock;
> > > -static rh_block_t cpm_boot_muram_rh_block[16]; -static rh_info_t
> > > cpm_muram_info;  static u8 __iomem *muram_vbase;  static phys_addr_t
> > > muram_pbase;
> > > 
> > > -/* Max address size we deal with */
> > > +struct muram_block {
> > > + struct list_head head;
> > > + unsigned long start;
> > > + int size;
> > > +};
> > > +
> > > +static LIST_HEAD(muram_block_list);
> > > +
> > > +/* max address size we deal with */
> > >  #define OF_MAX_ADDR_CELLS        4
> > > +#define GENPOOL_OFFSET           4096
> > 
> > Is 4096 bytes the maximum alignment you'll ever need?  Wouldn't it be
> > safer to use a much larger offset?
> 
> Yes, 4096 is the maximum alignment I ever need. 

Still, I'd be more comfortable with a larger offset.

Better yet would be using gen_pool_add_virt() and using virtual addresses for 
the allocations, similar to http://patchwork.ozlabs.org/patch/504000/

> > > int cpm_muram_init(void)
> > >  {
> > > @@ -86,113 +96,165 @@ int cpm_muram_init(void)
> > >   if (muram_pbase)
> > >           return 0;
> > > 
> > > - spin_lock_init(&cpm_muram_lock);
> > 
> > Why are you eliminating the lock init, given that you're not getting rid
> > of the lock?
> > 
> > > - /* initialize the info header */
> > > - rh_init(&cpm_muram_info, 1,
> > > -         sizeof(cpm_boot_muram_rh_block) /
> > > -         sizeof(cpm_boot_muram_rh_block[0]),
> > > -         cpm_boot_muram_rh_block);
> > > -
> > >   np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
> > >   if (!np) {
> > >           /* try legacy bindings */
> > >           np = of_find_node_by_name(NULL, "data-only");
> > >           if (!np) {
> > > -                 printk(KERN_ERR "Cannot find CPM muram data node");
> > > +                 pr_err("Cannot find CPM muram data node");
> > >                   ret = -ENODEV;
> > >                   goto out;
> > >           }
> > >   }
> > > 
> > > + muram_pool = gen_pool_create(1, -1);
> > 
> > Do we really need byte-granularity?
> 
> It is 2byte-granularity, 4byte-granularity is needed 
> 
> > 
> > >   muram_pbase = of_translate_address(np, zero);
> > >   if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> > > -         printk(KERN_ERR "Cannot translate zero through CPM muram
> > node");
> > > +         pr_err("Cannot translate zero through CPM muram node");
> > >           ret = -ENODEV;
> > > -         goto out;
> > > +         goto err;
> > >   }
> > > 
> > >   while (of_address_to_resource(np, i++, &r) == 0) {
> > >           if (r.end > max)
> > >                   max = r.end;
> > > +         ret = gen_pool_add(muram_pool, r.start - muram_pbase +
> > > +                            GENPOOL_OFFSET, resource_size(&r), -1);
> > > +         if (ret) {
> > > +                         pr_err("QE: couldn't add muram to pool!\n");
> > > +                         goto err;
> > > +                 }
> > > 
> > > -         rh_attach_region(&cpm_muram_info, r.start - muram_pbase,
> > > -                          resource_size(&r));
> > >   }
> > > 
> > >   muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
> > >   if (!muram_vbase) {
> > > -         printk(KERN_ERR "Cannot map CPM muram");
> > > +         pr_err("Cannot map QE muram");
> > >           ret = -ENOMEM;
> > > +         goto err;
> > >   }
> > > -
> > > + goto out;
> > > +err:
> > > + gen_pool_destroy(muram_pool);
> > >  out:
> > >   of_node_put(np);
> > >   return ret;
> > 
> > Having both "err" and "out" is confusing.  Instead call it "out_pool" or
> > similar.
> 
> Ok
> 
> > >  {
> > > - int ret;
> > > +
> > > + unsigned long start;
> > >   unsigned long flags;
> > > + unsigned long size_alloc = size;
> > > + struct muram_block *entry;
> > > + int end_bit;
> > > + int order = muram_pool->min_alloc_order;
> > > 
> > >   spin_lock_irqsave(&cpm_muram_lock, flags);
> > > - ret = rh_free(&cpm_muram_info, offset);
> > > + end_bit = (offset >> order) + ((size + (1UL << order) - 1) >>
> > order);
> > > + if ((offset + size) > (end_bit << order))
> > > +         size_alloc = size + (1UL << order);
> > 
> > Why do you need to do all these calculations here?
> 
> So do it in gen_pool_fixed_alloc? 

Could you explain why they're needed at all?

> gen_pool_fixed_alloc just
> Can see numbers of blocks. It can't do calculations in gen_pool_fixed_alloc.

Are you saying that this:

struct genpool_data_fixed {
       unsigned long offset;           /* The offset of the specific region */
};

refers to blocks and not bytes?  And you didn't even mention that in the 
comment?

It should be bytes.  Actually, it should be an address, not an offset.  It 
should be the same value that you receive back from the allocator.  And I'm 
not sure how this is going to work with genalloc chunks that don't start at 
zero.  I think it really does need to be a separate toplevel function, and 
not just an allocation algorithm (or else the allocation algorithm is going 
to need more context on what chunk it's working on).

Speaking of chunks and the allocation function, I wonder what happens if you 
hit "if (start_bit >= end_bit) continue;" and then enter the loop with a new 
chunk and start_bit != 0...

-Scott
