Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbS2C12y0zDrLH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 18:45:38 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7L8hqJe069205
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 04:45:36 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cfnkk98a6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 04:45:36 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 18:45:33 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7L8jUTS25362524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 18:45:30 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7L8jTqJ023246
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 18:45:30 +1000
Subject: Re: [linux-next][bisected c64e09ce] sysctl command hung indefinitely
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Joonsoo Kim <js1304@gmail.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Aug 2017 14:15:21 +0530
In-Reply-To: <20170821075001.GA24530@dhcp22.suse.cz>
References: <1503137971.28497.19.camel@abdul>
 <20170821075001.GA24530@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1503305121.3629.2.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-21 at 09:50 +0200, Michal Hocko wrote:
> On Sat 19-08-17 15:49:31, Abdul Haleem wrote:
> > Hi Michal,
> > 
> > 'sysctl -a' command never completes on my PowerPC machine with latest
> > next kernel (As of next-20170811)
> > 
> > Machine Type : Power8 bare-metal
> > Kernel version : 4.13.0-rc4-next-20170817
> > gcc version : 4.8.5
> > 
> > 
> > command output
> > --------------
> > $ sysctl -a
> > [...
> > vm.hugetlb_shm_group = 0
> > vm.laptop_mode = 0
> > vm.legacy_va_layout = 0
> > vm.lowmem_reserve_ratio = 256	256	32
> > vm.max_map_count = 65530
> > vm.min_free_kbytes = 6637
> > vm.min_slab_ratio = 5
> > vm.min_unmapped_ratio = 1
> > vm.mmap_min_addr = 4096
> > vm.mmap_rnd_bits = 14
> > vm.mmap_rnd_compat_bits = 7
> > vm.nr_hugepages = 0
> > vm.nr_hugepages_mempolicy = 0
> > vm.nr_overcommit_hugepages = 0
> > vm.nr_pdflush_threads = 0
> > vm.numa_zonelist_order = Node
> > vm.numa_zonelist_order = e
> > vm.numa_zonelist_order = ode
> > vm.numa_zonelist_order = 
> > vm.numa_zonelist_order = de
> > vm.numa_zonelist_order = Node
> > vm.numa_zonelist_order = e
> > vm.numa_zonelist_order = ode
> > vm.numa_zonelist_order = 
> > vm.numa_zonelist_order = de
> > vm.numa_zonelist_order = Node
> > vm.numa_zonelist_order = e
> > vm.numa_zonelist_order = ode
> > vm.numa_zonelist_order = 
> > vm.numa_zonelist_order = de
> > vm.numa_zonelist_order = Node
> > vm.numa_zonelist_order = e
> > vm.numa_zonelist_order = ode
> > ....]
> > 
> > The last string 'vm.numa_zonelist_order = ' keeps flooding the stdout
> > and command never exit.
> > 
> > A bisection resulted commit c64e09ce mm, page_alloc: rip out
> > ZONELIST_ORDER_ZONE
> 
> Yeah, my read implementation is broken. I do not update the ppos and so
> the reader doesn't know it should exit. Mel was suggesting to keep the
> proc_dostring but I thought I was more clever. Sigh...
> 
> This should do the trick. Andrew, could you fold it into
> mm-page_alloc-rip-out-zonelist_order_zone.patch please?
> 
> Thanks for the report Abdul!
> 
> ---
> commit 69885605ee3ba681deb54021e3df645f46589ba1
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon Aug 21 09:46:04 2017 +0200
> 
>     mmotm: mm-page_alloc-rip-out-zonelist_order_zone-fix
>     
>     Abdul has noticed that reading sysctl vm.numa_zonelist_order
>     read will never terminate. This is because of
>     http://lkml.kernel.org/r/20170714080006.7250-2-mhocko@kernel.org
>     where the reading side doesn't update ppos and so the reader will
>     never get 0. Return back to proc_dostring which does all the necessary
>     stuff.
>     
>     Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
>     Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fda9afbd14d9..e7e92c8f4883 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h

Thanks for the fix Michal, the patch fixes the problem.

Reported-and-Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
