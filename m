Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FcG71YGzzF3Hj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 20:55:27 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8JAsnbL074074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 06:55:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkmfk1n2f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 06:55:24 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 19 Sep 2018 11:55:21 +0100
Date: Wed, 19 Sep 2018 13:55:12 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH 03/29] mm: remove CONFIG_HAVE_MEMBLOCK
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
 <20180919100449.00006df9@huawei.com>
 <20180919103457.GA20545@rapoport-lnx>
 <20180919114507.000059f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919114507.000059f3@huawei.com>
Message-Id: <20180919105511.GB20545@rapoport-lnx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 11:45:07AM +0100, Jonathan Cameron wrote:
> On Wed, 19 Sep 2018 13:34:57 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Wed, Sep 19, 2018 at 10:04:49AM +0100, Jonathan Cameron wrote:
> > > On Wed, 5 Sep 2018 18:59:18 +0300
> > > Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > >   
> > > > All architecures use memblock for early memory management. There is no need
> > > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>  
> > > 
> > > Hi Mike,
> > > 
> > > A minor editing issue in here that is stopping boot on arm64 platforms with latest
> > > version of the mm tree.  
> > 
> > Can you please try the following patch:
> > 
> > 
> > From 079bd5d24a01df3df9500d0a33d89cb9f7da4588 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Date: Wed, 19 Sep 2018 13:29:27 +0300
> > Subject: [PATCH] of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config
> >  option
> > 
> > The removal of HAVE_MEMBLOCK configuration option, mistakenly dropped the
> > wrong #endif. This patch restores that #endif and removes the part that
> > should have been actually removed, starting from #else and up to the
> > correct #endif
> > 
> > Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Hi Mike,
> 
> That's identical to the local patch I'm carrying to fix this so looks good to me.
> 
> For what it's worth given you'll probably fold this into the larger patch.
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Well, this is up to Andrew now, as the broken patch is already in the -mm
tree.
 
> Thanks for the quick reply.
> 
> Jonathan
> 
> > ---
> >  drivers/of/fdt.c | 21 +--------------------
> >  1 file changed, 1 insertion(+), 20 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 48314e9..bb532aa 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1119,6 +1119,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  #endif
> >  #ifndef MAX_MEMBLOCK_ADDR
> >  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> > +#endif
> >  
> >  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> >  {
> > @@ -1175,26 +1176,6 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> >  	return memblock_reserve(base, size);
> >  }
> >  
> > -#else
> > -void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> > -{
> > -	WARN_ON(1);
> > -}
> > -
> > -int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
> > -{
> > -	return -ENOSYS;
> > -}
> > -
> > -int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> > -					phys_addr_t size, bool nomap)
> > -{
> > -	pr_err("Reserved memory not supported, ignoring range %pa - %pa%s\n",
> > -		  &base, &size, nomap ? " (nomap)" : "");
> > -	return -ENOSYS;
> > -}
> > -#endif
> > -
> >  static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> >  {
> >  	return memblock_alloc(size, align);
> 
> 

-- 
Sincerely yours,
Mike.
