Return-Path: <liwp.linux@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB51BB70B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 23:19:23 +1000 (EST)
Received: by dajt11 with SMTP id t11so4424109daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 06:19:21 -0700 (PDT)
From: Wanpeng Li <liwp.linux@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 5/7][TRIVIAL][resend] mm: cleanup kernel-doc warnings
Date: Fri, 15 Jun 2012 21:18:45 +0800
Message-Id: <1339766328-7683-1-git-send-email-liwp.linux@gmail.com>
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
 Wanpeng Li <liwp.linux@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Mel Gorman <mel@csn.ul.ie>, Jason Wessel <jason.wessel@windriver.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>,
 cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Minchan Kim <minchan@kernel.org>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wanpeng Li <liwp@linux.vnet.ibm.com>

fix kernel-doc warnings just like this one:

Warning(../mm/page_cgroup.c:432): No description found for parameter 'id'
Warning(../mm/page_cgroup.c:432): Excess function parameter 'mem' description in 'swap_cgroup_record'

Signed-off-by: Wanpeng Li <liwp.linux@gmail.com>

---
 mm/memblock.c    |   12 ++++++------
 mm/memcontrol.c  |    4 ++--
 mm/oom_kill.c    |    2 +-
 mm/page_cgroup.c |    4 ++--
 mm/pagewalk.c    |    1 -
 mm/percpu-vm.c   |    1 -
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 952123e..b84f258 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -540,9 +540,9 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
  * __next_free_mem_range - next function for for_each_free_mem_range()
  * @idx: pointer to u64 loop variable
  * @nid: nid: node selector, %MAX_NUMNODES for all nodes
- * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
- * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
- * @p_nid: ptr to int for nid of the range, can be %NULL
+ * @out_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @out_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ * @out_nid: ptr to int for nid of the range, can be %NULL
  *
  * Find the first free area from *@idx which matches @nid, fill the out
  * parameters, and update *@idx for the next iteration.  The lower 32bit of
@@ -616,9 +616,9 @@ void __init_memblock __next_free_mem_range(u64 *idx, int nid,
  * __next_free_mem_range_rev - next function for for_each_free_mem_range_reverse()
  * @idx: pointer to u64 loop variable
  * @nid: nid: node selector, %MAX_NUMNODES for all nodes
- * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
- * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
- * @p_nid: ptr to int for nid of the range, can be %NULL
+ * @out_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @out_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ * @out_nid: ptr to int for nid of the range, can be %NULL
  *
  * Reverse of __next_free_mem_range().
  */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ac35bcc..a9c3d01 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1234,7 +1234,7 @@ int mem_cgroup_inactive_file_is_low(struct lruvec *lruvec)
 
 /**
  * mem_cgroup_margin - calculate chargeable space of a memory cgroup
- * @mem: the memory cgroup
+ * @memcg: the memory cgroup
  *
  * Returns the maximum amount of memory @mem can be charged with, in
  * pages.
@@ -1508,7 +1508,7 @@ static unsigned long mem_cgroup_reclaim(struct mem_cgroup *memcg,
 
 /**
  * test_mem_cgroup_node_reclaimable
- * @mem: the target memcg
+ * @memcg: the target memcg
  * @nid: the node ID to be checked.
  * @noswap : specify true here if the user wants flle only information.
  *
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 416637f..c1956f1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -366,7 +366,7 @@ static struct task_struct *select_bad_process(unsigned int *ppoints,
 
 /**
  * dump_tasks - dump current memory state of all system tasks
- * @mem: current's memory controller, if constrained
+ * @memcg: current's memory controller, if constrained
  * @nodemask: nodemask passed to page allocator for mempolicy ooms
  *
  * Dumps the current memory state of all eligible tasks.  Tasks not in the same
diff --git a/mm/page_cgroup.c b/mm/page_cgroup.c
index 1ccbd71..eb750f8 100644
--- a/mm/page_cgroup.c
+++ b/mm/page_cgroup.c
@@ -392,7 +392,7 @@ static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
 
 /**
  * swap_cgroup_cmpxchg - cmpxchg mem_cgroup's id for this swp_entry.
- * @end: swap entry to be cmpxchged
+ * @ent: swap entry to be cmpxchged
  * @old: old id
  * @new: new id
  *
@@ -422,7 +422,7 @@ unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
 /**
  * swap_cgroup_record - record mem_cgroup for this swp_entry.
  * @ent: swap entry to be recorded into
- * @mem: mem_cgroup to be recorded
+ * @id: mem_cgroup to be recorded
  *
  * Returns old value at success, 0 at failure.
  * (Of course, old value can be 0.)
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index aa9701e..6c118d0 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -162,7 +162,6 @@ static int walk_hugetlb_range(struct vm_area_struct *vma,
 
 /**
  * walk_page_range - walk a memory map's page tables with a callback
- * @mm: memory map to walk
  * @addr: starting address
  * @end: ending address
  * @walk: set of callbacks to invoke for each level of the tree
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 405d331..3707c71 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -360,7 +360,6 @@ err_free:
  * @chunk: chunk to depopulate
  * @off: offset to the area to depopulate
  * @size: size of the area to depopulate in bytes
- * @flush: whether to flush cache and tlb or not
  *
  * For each cpu, depopulate and unmap pages [@page_start,@page_end)
  * from @chunk.  If @flush is true, vcache is flushed before unmapping
-- 
1.7.9.5
