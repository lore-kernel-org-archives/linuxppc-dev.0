Return-Path: <pbadari@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E76AFDE027
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 01:09:14 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4DF9BgL027246
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 11:09:11 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4DF9B2N094762
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 11:09:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4DF9Ao4020050
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 11:09:11 -0400
Subject: Re: [PATCH 5/5] [PPC] provide walk_memory_resource() for ppc
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4828DDFE.6050805@am.sony.com>
References: <1206664406.19368.2.camel@dyn9047017100.beaverton.ibm.com>
	<1206664795.19368.13.camel@dyn9047017100.beaverton.ibm.com>
	<4828DDFE.6050805@am.sony.com>
Content-Type: text/plain
Date: Tue, 13 May 2008 08:09:25 -0700
Message-Id: <1210691365.15921.6.camel@badari-desktop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-12 at 17:17 -0700, Geoff Levand wrote:
> Hi,
> 
> I've had some trouble with this change.
> 
> Badari Pulavarty wrote:
> > Provide walk_memory_resource() for ppc64. PPC maintains 
> > logic memory region mapping in lmb.memory structures. Walk
> > through these structures and do the callbacks for the
> > contiguous chunks.
> 
> ...
> 
> > --- linux-2.6.25-rc3.orig/arch/powerpc/mm/mem.c	2008-03-05 10:14:28.000000000 -0800
> > +++ linux-2.6.25-rc3/arch/powerpc/mm/mem.c	2008-03-05 10:32:16.000000000 -0800
> > @@ -148,19 +148,35 @@ out:
> >  
> >  /*
> >   * walk_memory_resource() needs to make sure there is no holes in a given
> > - * memory range. On PPC64, since this range comes from /sysfs, the range
> > - * is guaranteed to be valid, non-overlapping and can not contain any
> > - * holes. By the time we get here (memory add or remove), /proc/device-tree
> > - * is updated and correct. Only reason we need to check against device-tree
> > - * would be if we allow user-land to specify a memory range through a
> > - * system call/ioctl etc. instead of doing offline/online through /sysfs.
> > + * memory range. PPC64 does not maintain the memory layout in /proc/iomem.
> > + * Instead it maintains it in lmb.memory structures. Walk through the
> > + * memory regions, find holes and callback for contiguous regions.
> >   */
> >  int
> >  walk_memory_resource(unsigned long start_pfn, unsigned long nr_pages, void *arg,
> >  			int (*func)(unsigned long, unsigned long, void *))
> >  {
> > -	return  (*func)(start_pfn, nr_pages, arg);
> > +	struct lmb_property res;
> > +	unsigned long pfn, len;
> > +	u64 end;
> > +	int ret = -1;
> > +
> > +	res.base = (u64) start_pfn << PAGE_SHIFT;
> > +	res.size = (u64) nr_pages << PAGE_SHIFT;
> > +
> > +	end = res.base + res.size - 1;
> > +	while ((res.base < end) && (lmb_find(&res) >= 0)) {
>                                     ^^^^^^^^^^^^^^
> 
> In the PS3 platform code (arch/pwerpc/platfroms/ps3/mm.c) the hotplug
> memory is added like this:
> 
> 	...
> 	result = add_memory(0, start_addr, map.r1.size);
> 	...
> 	result = online_pages(start_pfn, nr_pages);
> 	...
> 
> In its work, online_pages() eventually calls walk_memory_resource(),
> which has been changed as above to do a test on lmb_find(). I found
> that this lmb_find() test always fails for PS3 since add_memory()
> does not call lmb_add().
> 
> Is it the responsibility of the platform code to call lmb_add(), or
> should that be done by add_memory()?

Since "lmb" code is specific to architecture, I would prefer that
arch specific code is responsible for manipulating "lmb"s instead of
generic code.

In case of ppc64, I added lmb_add() call in /proc/device-tree
manipulation code. Are there any arch specific calls for PS3
when add/remove memory happens ? If there are no other calls,
you can do lmb_add() in ps3_mm_add_memory(). For remove, we
need to find a better place.

Thanks,
Badari
