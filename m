Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E896F2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 05:02:11 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 23:32:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6541F1258054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 23:34:02 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JI23sJ8389082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 23:32:03 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JI20Dj030311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 23:32:01 +0530
Date: Wed, 19 Feb 2014 23:32:00 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>, riel@redhat.com,
 mgorman@suse.de
Subject: Panic on ppc64 with numa_balancing and !sparsemem_vmemmap
Message-ID: <20140219180200.GA29257@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Peter Zijlstra <peterz@infradead.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On a powerpc machine with CONFIG_NUMA_BALANCING=y and CONFIG_SPARSEMEM_VMEMMAP
not enabled,  kernel panics.

This is true of kernel versions 3.13 to the latest commit 960dfc4 which is
3.14-rc3+.  i.e the recent 3 fixups from Aneesh doesnt seem to help this case.

Sometimes it fails on boot up itself. Otherwise a kernel compile is good enough
to trigger the same. I am seeing this on a Power 7 box.

Kernel 3.14.0-rc3-mainline_v313-00168-g960dfc4 on an ppc64

transam2s-lp1 login: qla2xxx [0003:01:00.1]-8038:2: Cable is unplugged...
Unable to handle kernel paging request for data at address 0x00000457
Faulting instruction address: 0xc0000000000d6004
cpu 0x38: Vector: 300 (Data Access) at [c00000171561f700]
    pc: c0000000000d6004: .task_numa_fault+0x604/0xa30
    lr: c0000000000d62fc: .task_numa_fault+0x8fc/0xa30
    sp: c00000171561f980
   msr: 8000000000009032
   dar: 457
 dsisr: 40000000
  current = 0xc0000017155d9b00
  paca    = 0xc00000000ec1e000   softe: 0        irq_happened: 0x00
    pid   = 16898, comm = gzip
enter ? for help
[c00000171561fa70] c0000000001b0fb0 .do_numa_page+0x1b0/0x2a0
[c00000171561fb20] c0000000001b2788 .handle_mm_fault+0x538/0xca0
[c00000171561fc00] c00000000082f498 .do_page_fault+0x378/0x880
[c00000171561fe30] c000000000009568 handle_page_fault+0x10/0x30
--- Exception: 301 (Data Access) at 00000000100031d8
SP (3fffd45ea2d0) is in userspace
38:mon>


(gdb) list *(task_numa_fault+0x604)
0xc0000000000d6004 is in task_numa_fault (/home/srikar/work/linux.git/include/linux/mm.h:753).
748             return cpupid_to_cpu(cpupid) == (-1 & LAST__CPU_MASK);
749     }
750
751     static inline bool __cpupid_match_pid(pid_t task_pid, int cpupid)
752     {
753             return (task_pid & LAST__PID_MASK) == cpupid_to_pid(cpupid);
754     }
755
756     #define cpupid_match_pid(task, cpupid) __cpupid_match_pid(task->pid, cpupid)
757     #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
(gdb) 


However this doesnt seem to happen if we have CONFIG_SPARSEMEM_VMEMMAP=y set in the config.


-- 
Thanks nnn Regards
Srikar Dronamraju
