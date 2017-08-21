Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbQp76qzdzDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 17:50:07 +1000 (AEST)
Date: Mon, 21 Aug 2017 09:50:01 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, Joonsoo Kim <js1304@gmail.com>
Subject: Re: [linux-next][bisected c64e09ce] sysctl command hung indefinitely
Message-ID: <20170821075001.GA24530@dhcp22.suse.cz>
References: <1503137971.28497.19.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503137971.28497.19.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat 19-08-17 15:49:31, Abdul Haleem wrote:
> Hi Michal,
> 
> 'sysctl -a' command never completes on my PowerPC machine with latest
> next kernel (As of next-20170811)
> 
> Machine Type : Power8 bare-metal
> Kernel version : 4.13.0-rc4-next-20170817
> gcc version : 4.8.5
> 
> 
> command output
> --------------
> $ sysctl -a
> [...
> vm.hugetlb_shm_group = 0
> vm.laptop_mode = 0
> vm.legacy_va_layout = 0
> vm.lowmem_reserve_ratio = 256	256	32
> vm.max_map_count = 65530
> vm.min_free_kbytes = 6637
> vm.min_slab_ratio = 5
> vm.min_unmapped_ratio = 1
> vm.mmap_min_addr = 4096
> vm.mmap_rnd_bits = 14
> vm.mmap_rnd_compat_bits = 7
> vm.nr_hugepages = 0
> vm.nr_hugepages_mempolicy = 0
> vm.nr_overcommit_hugepages = 0
> vm.nr_pdflush_threads = 0
> vm.numa_zonelist_order = Node
> vm.numa_zonelist_order = e
> vm.numa_zonelist_order = ode
> vm.numa_zonelist_order = 
> vm.numa_zonelist_order = de
> vm.numa_zonelist_order = Node
> vm.numa_zonelist_order = e
> vm.numa_zonelist_order = ode
> vm.numa_zonelist_order = 
> vm.numa_zonelist_order = de
> vm.numa_zonelist_order = Node
> vm.numa_zonelist_order = e
> vm.numa_zonelist_order = ode
> vm.numa_zonelist_order = 
> vm.numa_zonelist_order = de
> vm.numa_zonelist_order = Node
> vm.numa_zonelist_order = e
> vm.numa_zonelist_order = ode
> ....]
> 
> The last string 'vm.numa_zonelist_order = ' keeps flooding the stdout
> and command never exit.
> 
> A bisection resulted commit c64e09ce mm, page_alloc: rip out
> ZONELIST_ORDER_ZONE

Yeah, my read implementation is broken. I do not update the ppos and so
the reader doesn't know it should exit. Mel was suggesting to keep the
proc_dostring but I thought I was more clever. Sigh...

This should do the trick. Andrew, could you fold it into
mm-page_alloc-rip-out-zonelist_order_zone.patch please?

Thanks for the report Abdul!

---
commit 69885605ee3ba681deb54021e3df645f46589ba1
Author: Michal Hocko <mhocko@suse.com>
Date:   Mon Aug 21 09:46:04 2017 +0200

    mmotm: mm-page_alloc-rip-out-zonelist_order_zone-fix
    
    Abdul has noticed that reading sysctl vm.numa_zonelist_order
    read will never terminate. This is because of
    http://lkml.kernel.org/r/20170714080006.7250-2-mhocko@kernel.org
    where the reading side doesn't update ppos and so the reader will
    never get 0. Return back to proc_dostring which does all the necessary
    stuff.
    
    Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
    Signed-off-by: Michal Hocko <mhocko@suse.com>

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fda9afbd14d9..e7e92c8f4883 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -894,6 +894,8 @@ int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 
 extern int numa_zonelist_order_handler(struct ctl_table *, int,
 			void __user *, size_t *, loff_t *);
+extern char numa_zonelist_order[];
+#define NUMA_ZONELIST_ORDER_LEN	16
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0cbce40f5426..655686d546cb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1553,6 +1553,8 @@ static struct ctl_table vm_table[] = {
 #ifdef CONFIG_NUMA
 	{
 		.procname	= "numa_zonelist_order",
+		.data		= &numa_zonelist_order,
+		.maxlen		= NUMA_ZONELIST_ORDER_LEN,
 		.mode		= 0644,
 		.proc_handler	= numa_zonelist_order_handler,
 	},
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5cba36337893..b55e97decac4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4859,6 +4859,8 @@ static __init int setup_numa_zonelist_order(char *s)
 }
 early_param("numa_zonelist_order", setup_numa_zonelist_order);
 
+char numa_zonelist_order[] = "Node";
+
 /*
  * sysctl handler for numa_zonelist_order
  */
@@ -4869,12 +4871,8 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
 	char *str;
 	int ret;
 
-	if (!write) {
-		int len = sizeof("Node");
-		if (copy_to_user(buffer, "Node", len))
-			return -EFAULT;
-		return len;
-	}
+	if (!write)
+		return proc_dostring(table, write, buffer, length, ppos);
 	str = memdup_user_nul(buffer, 16);
 	if (IS_ERR(str))
 		return PTR_ERR(str);
-- 
Michal Hocko
SUSE Labs
