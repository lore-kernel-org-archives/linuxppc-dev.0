Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21D2C1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 18:10:33 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
Date: Tue, 22 Sep 2015 08:10:24 +0000
Message-ID: <SN1PR0301MB1550726A1D45051888E35EB59B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-3-git-send-email-qiang.zhao@freescale.com>
 <20150921224720.GA12709@home.buserror.net>
In-Reply-To: <20150921224720.GA12709@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:47 AM +0800, Wood Scott-B07421 wrote:
> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, September 22, 2015 6:47 AM
> To: Zhao Qiang-B45475
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> Yang-Leo-R58472; paulus@samba.org
> Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
>=20
> On Fri, Sep 18, 2015 at 03:15:19PM +0800, Zhao Qiang wrote:
> > Use genalloc to manage CPM/QE muram instead of rheap.
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> > ---
> > Changes for v9:
> > 	- splitted from patch 3/5, modify cpm muram management functions.
> > Changes for v10:
> > 	- modify cpm muram first, then move to qe_common
> > 	- modify commit.
> >
> >  arch/powerpc/platforms/Kconfig   |   1 +
> >  arch/powerpc/sysdev/cpm_common.c | 150
> > +++++++++++++++++++++++++++------------
> >  2 files changed, 107 insertions(+), 44 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/Kconfig
> > b/arch/powerpc/platforms/Kconfig index b7f9c40..01f98a2 100644
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -276,6 +276,7 @@ config QUICC_ENGINE
> >  	bool "Freescale QUICC Engine (QE) Support"
> >  	depends on FSL_SOC && PPC32
> >  	select PPC_LIB_RHEAP
> > +	select GENERIC_ALLOCATOR
> >  	select CRC32
> >  	help
> >  	  The QUICC Engine (QE) is a new generation of communications diff
> > --git a/arch/powerpc/sysdev/cpm_common.c
> > b/arch/powerpc/sysdev/cpm_common.c
> > index 4f78695..453d18c 100644
> > --- a/arch/powerpc/sysdev/cpm_common.c
> > +++ b/arch/powerpc/sysdev/cpm_common.c
> > @@ -17,6 +17,7 @@
> >   * published by the Free Software Foundation.
> >   */
> >
> > +#include <linux/genalloc.h>
> >  #include <linux/init.h>
> >  #include <linux/of_device.h>
> >  #include <linux/spinlock.h>
> > @@ -27,7 +28,6 @@
> >
> >  #include <asm/udbg.h>
> >  #include <asm/io.h>
> > -#include <asm/rheap.h>
> >  #include <asm/cpm.h>
> >
> >  #include <mm/mmu_decl.h>
> > @@ -65,14 +65,24 @@ void __init udbg_init_cpm(void)  }  #endif
> >
> > +static struct gen_pool *muram_pool;
> > +static struct genpool_data_align muram_pool_data; static struct
> > +genpool_data_fixed muram_pool_data_fixed;
>=20
> Why are these global?  If you keep the data local to the caller (and use
> gen_pool_alloc_data()) then you probably don't need cpm_muram_lock.

Ok

>=20
> >  static spinlock_t cpm_muram_lock;
> > -static rh_block_t cpm_boot_muram_rh_block[16]; -static rh_info_t
> > cpm_muram_info;  static u8 __iomem *muram_vbase;  static phys_addr_t
> > muram_pbase;
> >
> > -/* Max address size we deal with */
> > +struct muram_block {
> > +	struct list_head head;
> > +	unsigned long start;
> > +	int size;
> > +};
> > +
> > +static LIST_HEAD(muram_block_list);
> > +
> > +/* max address size we deal with */
> >  #define OF_MAX_ADDR_CELLS	4
> > +#define GENPOOL_OFFSET		4096
>=20
> Is 4096 bytes the maximum alignment you'll ever need?  Wouldn't it be
> safer to use a much larger offset?

Yes, 4096 is the maximum alignment I ever need.=20

>=20
> >  int cpm_muram_init(void)
> >  {
> > @@ -86,113 +96,165 @@ int cpm_muram_init(void)
> >  	if (muram_pbase)
> >  		return 0;
> >
> > -	spin_lock_init(&cpm_muram_lock);
>=20
> Why are you eliminating the lock init, given that you're not getting rid
> of the lock?
>=20
> > -	/* initialize the info header */
> > -	rh_init(&cpm_muram_info, 1,
> > -	        sizeof(cpm_boot_muram_rh_block) /
> > -	        sizeof(cpm_boot_muram_rh_block[0]),
> > -	        cpm_boot_muram_rh_block);
> > -
> >  	np =3D of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
> >  	if (!np) {
> >  		/* try legacy bindings */
> >  		np =3D of_find_node_by_name(NULL, "data-only");
> >  		if (!np) {
> > -			printk(KERN_ERR "Cannot find CPM muram data node");
> > +			pr_err("Cannot find CPM muram data node");
> >  			ret =3D -ENODEV;
> >  			goto out;
> >  		}
> >  	}
> >
> > +	muram_pool =3D gen_pool_create(1, -1);
>=20
> Do we really need byte-granularity?

It is 2byte-granularity, 4byte-granularity is needed=20

>=20
> >  	muram_pbase =3D of_translate_address(np, zero);
> >  	if (muram_pbase =3D=3D (phys_addr_t)OF_BAD_ADDR) {
> > -		printk(KERN_ERR "Cannot translate zero through CPM muram
> node");
> > +		pr_err("Cannot translate zero through CPM muram node");
> >  		ret =3D -ENODEV;
> > -		goto out;
> > +		goto err;
> >  	}
> >
> >  	while (of_address_to_resource(np, i++, &r) =3D=3D 0) {
> >  		if (r.end > max)
> >  			max =3D r.end;
> > +		ret =3D gen_pool_add(muram_pool, r.start - muram_pbase +
> > +				   GENPOOL_OFFSET, resource_size(&r), -1);
> > +		if (ret) {
> > +				pr_err("QE: couldn't add muram to pool!\n");
> > +				goto err;
> > +			}
> >
> > -		rh_attach_region(&cpm_muram_info, r.start - muram_pbase,
> > -				 resource_size(&r));
> >  	}
> >
> >  	muram_vbase =3D ioremap(muram_pbase, max - muram_pbase + 1);
> >  	if (!muram_vbase) {
> > -		printk(KERN_ERR "Cannot map CPM muram");
> > +		pr_err("Cannot map QE muram");
> >  		ret =3D -ENOMEM;
> > +		goto err;
> >  	}
> > -
> > +	goto out;
> > +err:
> > +	gen_pool_destroy(muram_pool);
> >  out:
> >  	of_node_put(np);
> >  	return ret;
>=20
> Having both "err" and "out" is confusing.  Instead call it "out_pool" or
> similar.

Ok

> >  {
> > -	int ret;
> > +
> > +	unsigned long start;
> >  	unsigned long flags;
> > +	unsigned long size_alloc =3D size;
> > +	struct muram_block *entry;
> > +	int end_bit;
> > +	int order =3D muram_pool->min_alloc_order;
> >
> >  	spin_lock_irqsave(&cpm_muram_lock, flags);
> > -	ret =3D rh_free(&cpm_muram_info, offset);
> > +	end_bit =3D (offset >> order) + ((size + (1UL << order) - 1) >>
> order);
> > +	if ((offset + size) > (end_bit << order))
> > +		size_alloc =3D size + (1UL << order);
>=20
> Why do you need to do all these calculations here?

So do it in gen_pool_fixed_alloc? gen_pool_fixed_alloc just=20
Can see numbers of blocks. It can't do calculations in gen_pool_fixed_alloc=
.

>=20
> > +	muram_pool_data_fixed.offset =3D offset + GENPOOL_OFFSET;
> > +	gen_pool_set_algo(muram_pool, gen_pool_fixed_alloc,
> > +			  &muram_pool_data_fixed);
> > +	start =3D gen_pool_alloc(muram_pool, size_alloc);
> > +	if (!start)
> > +		goto out2;
> > +	start =3D start - GENPOOL_OFFSET;
> > +	memset(cpm_muram_addr(start), 0, size_alloc);
> > +	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> > +	if (!entry)
> > +		goto out1;
> > +	entry->start =3D start;
> > +	entry->size =3D size_alloc;
> > +	list_add(&entry->head, &muram_block_list);
> >  	spin_unlock_irqrestore(&cpm_muram_lock, flags);
>=20
> Please factor out the common alloc code.

The common code is as below, what's the function name of this common code, =
cpm_muram_alloc_common?
        gen_pool_set_algo(muram_pool, gen_pool_fixed_alloc,
                          &muram_pool_data_fixed);
        start =3D gen_pool_alloc(muram_pool, size_alloc);
        if (!start)
                goto out2;
        start =3D start - GENPOOL_OFFSET;
        memset(cpm_muram_addr(start), 0, size_alloc);
        entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
        if (!entry)
                goto out1;
        entry->start =3D start;
        entry->size =3D size_alloc;
        list_add(&entry->head, &muram_block_list);
        spin_unlock_irqrestore(&cpm_muram_lock, flags);

        return start;
out1:
        gen_pool_free(muram_pool, start, size_alloc);
out2:
        spin_unlock_irqrestore(&cpm_muram_lock, flags);
        return (unsigned long) -ENOMEM;

-Zhao
