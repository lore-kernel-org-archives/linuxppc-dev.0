Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcsZW5PnGzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 20:59:31 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v279rrv8154814
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 04:59:24 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2917mvf0aw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 04:59:24 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 19:59:21 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A8B333578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 20:59:17 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v279x9S944236980
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 20:59:17 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v279wgcU006220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 20:58:44 +1100
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Peter Zijlstra <peterz@infradead.org>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 7 Mar 2017 15:28:17 +0530
MIME-Version: 1.0
In-Reply-To: <20170306112228.GZ6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 06 March 2017 04:52 PM, Peter Zijlstra wrote:
> On Mon, Mar 06, 2017 at 04:13:08PM +0530, Madhavan Srinivasan wrote:
>> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>>
>> perf_mem_data_src is an union that is initialized via the ->val field
>> and accessed via the bitmap fields. For this to work on big endian
>> platforms, we also need a big-endian represenation of perf_mem_data_src.
> Doesn't this break interpreting the data on a different endian machine?

IIUC, we will need this patch to not to break the interpreting data
on a different endian machine. Data collected from power8 LE/BE
guests with this patchset applied. Kindly correct me if I missed
your question here.


With this patchset applied, perf.data from a power8 BigEndian guest:
==============================================================

$ sudo ./perf record -d -e mem_access ls
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.007 MB perf.data (8 samples) ]

$ sudo ./perf report --mem-mode --stdio
   # To display the perf.data header info, please use 
--header/--header-only options.
   #
   #
   # Total Lost Samples: 0
   #
   # Samples: 8  of event 'mem_access'
   # Total weight : 8
   # Sort order   : 
local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
   #
   # Overhead  Local Weight  Memory access Symbol                       
Shared Object     Data Symbol                             Data 
Object                         Snoop         TLB access              Locked
   # ........  ............  ........................ 
...........................  ................ 
...................................... 
..................................  ............ ......................  
......
   #
       25.00%  0             L2 hit                    [H] 
0xc00000000000c910       [unknown]         [H] 0xc000000f170e5310 
[unknown]                           N/A N/A                     No
       12.50%  0             L2 hit                    [k] 
.idle_cpu                [kernel.vmlinux]  [k] __per_cpu_offset+0x68 
[kernel.vmlinux].data..read_mostly  N/A N/A                     No
       12.50%  0             L2 hit                    [H] 
0xc00000000000ca58       [unknown]         [H] 0xc000000f170e5200 
[unknown]                           N/A N/A                     No
       12.50%  0             L3 hit                    [k] 
.copypage_power7         [kernel.vmlinux]  [k] 0xc00000002f6fc600 
[kernel.vmlinux].bss                N/A N/A                     No
       12.50%  0             L3 hit                    [k] 
.copypage_power7         [kernel.vmlinux]  [k] 0xc00000003f8b1980 
[kernel.vmlinux].bss                N/A N/A                     No
       12.50%  0             Local RAM hit             [k] 
._raw_spin_lock_irqsave  [kernel.vmlinux]  [k] 0xc000000033b5bdf4 
[kernel.vmlinux].bss                Miss N/A                     No
       12.50%  0             Remote Cache (1 hop) hit  [k] 
.perf_iterate_ctx        [kernel.vmlinux]  [k] 0xc000000000e88648 
[kernel.vmlinux]                    HitM N/A                     No


perf report from power8 LittleEndian guest (with this patch applied to 
perf tool):
==================================================================================

$ ./perf report --mem-mode --stdio -i perf.data.p8be.withpatch
   No kallsyms or vmlinux with build-id 
ca8a1a9d4b62b2a67ee01050afb1dfa03565a655 was found
   /boot/vmlinux with build id ca8a1a9d4b62b2a67ee01050afb1dfa03565a655 
not found, continuing without symbols
   No kallsyms or vmlinux with build-id 
ca8a1a9d4b62b2a67ee01050afb1dfa03565a655 was found
   /boot/vmlinux with build id ca8a1a9d4b62b2a67ee01050afb1dfa03565a655 
not found, continuing without symbols
   # To display the perf.data header info, please use 
--header/--header-only options.
   #
   #
   # Total Lost Samples: 0
   #
   # Samples: 8  of event 'mem_access'
   # Total weight : 8
   # Sort order   : 
local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
   #
   # Overhead  Local Weight  Memory access Symbol                  
Shared Object     Data Symbol Data Object       Snoop         TLB 
access              Locked
   # ........  ............  ........................ 
......................  ................  ...................... 
................  ............  ......................  ......
   #
       25.00%  0             L2 hit                    [H] 
0xc00000000000c910  [unknown]         [H] 0xc000000f170e5310 
[unknown]         N/A           N/A                     No
       12.50%  0             L2 hit                    [k] 
0xc0000000000f4d0c  [kernel.vmlinux]  [k] 0xc000000000f2dac8 
[kernel.vmlinux]  N/A           N/A                     No
       12.50%  0             L2 hit                    [H] 
0xc00000000000ca58  [unknown]         [H] 0xc000000f170e5200 
[unknown]         N/A           N/A                     No
       12.50%  0             L3 hit                    [k] 
0xc00000000006b560  [kernel.vmlinux]  [k] 0xc00000002f6fc600 
[kernel.vmlinux]  N/A           N/A                     No
       12.50%  0             L3 hit                    [k] 
0xc00000000006b560  [kernel.vmlinux]  [k] 0xc00000003f8b1980 
[kernel.vmlinux]  N/A           N/A                     No
       12.50%  0             Local RAM hit             [k] 
0xc00000000094ad14  [kernel.vmlinux]  [k] 0xc000000033b5bdf4 
[kernel.vmlinux]  Miss          N/A                     No
       12.50%  0             Remote Cache (1 hop) hit  [k] 
0xc0000000001ce31c  [kernel.vmlinux]  [k] 0xc000000000e88648 
[kernel.vmlinux]  HitM          N/A                     No



With this patch, perf.data from a power8 LE guest:
===================================================

$ sudo ./perf record -d -e mem_access ls
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.010 MB perf.data (6 samples) ]

$ sudo ./perf report --mem-mode --stdio
   # To display the perf.data header info, please use 
--header/--header-only options.
   #
   #
   # Total Lost Samples: 0
   #
   # Samples: 6  of event 'mem_access'
   # Total weight : 6
   # Sort order   : 
local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
   #
   # Overhead  Local Weight  Memory access Symbol                  
Shared Object     Data Symbol Data Object       Snoop         TLB 
access              Locked
   # ........  ............  ........................ 
......................  ................  ...................... 
................  ............  ......................  ......
   #
       16.67%  0             L2 hit                    [.] 
_init               ls                [.] 0x000001002ef4dd71 
[heap]            N/A           N/A                     No
       16.67%  0             L2 hit                    [k] 
irq_exit            [kernel.vmlinux]  [k] 0xc0000000ff6e2080 
[kernel.vmlinux]  N/A           N/A                     No
       16.67%  0             L2 hit                    [H] 
0xc0000000000ba210  [unknown]         [H] 0xc00000075ce2fe38 
[unknown]         N/A           N/A                     No
       16.67%  0             L2 hit                    [H] 
0xc00000000000bdb0  [unknown]         [H] 0xc00000075ce2fee0 
[unknown]         N/A           N/A                     No
       16.67%  0             L2 hit                    [H] 
0xc0000000000bb444  [unknown]         [H] 0xc00000075ce30490 
[unknown]         N/A           N/A                     No
       16.67%  0             L3 hit                    [H] 
0x0000000000066524  [unknown]         [H] 0xc0000000014e0000 
[unknown]         N/A           N/A                     No

perf report from power7 BE guest(with this patch applied to perf tool):
=========================================================================

$ ./perf report --mem-mode --stdio
   No kallsyms or vmlinux with build-id 
06240a7589956e7d388bdffdab9f7f138834fa81 was found
   /lib/modules/4.10.0-rc5+/build/vmlinux with build id 
06240a7589956e7d388bdffdab9f7f138834fa81 not found, continuing without 
symbols
   No kallsyms or vmlinux with build-id 
06240a7589956e7d388bdffdab9f7f138834fa81 was found
   /lib/modules/4.10.0-rc5+/build/vmlinux with build id 
06240a7589956e7d388bdffdab9f7f138834fa81 not found, continuing without 
symbols
   /usr/bin/ls with build id cf69c39cf0d28e5be86c03de5c556e3ce8d6ce27 
not found, continuing without symbols
   # To display the perf.data header info, please use 
--header/--header-only options.
   #
   #
   # Total Lost Samples: 0
   #
   # Samples: 6  of event 'mem_access'
   # Total weight : 6
   # Sort order   : 
local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked
   #
   # Overhead  Local Weight  Memory access Symbol                  
Shared Object     Data Symbol Data Object       Snoop         TLB 
access              Locked
   # ........  ............  ........................ 
......................  ................  ...................... 
................  ............  ......................  ......
   #
       16.67%  0             L2 hit                    [k] 
0xc0000000000d3cc8  [kernel.vmlinux]  [k] 0xc0000000ff6e2080 
[kernel.vmlinux]  N/A           N/A                     No
       16.67%  0             L2 hit                    [.] 
0x0000000000012ba8  ls                [.] 0x000001002ef4dd71 
[heap]            N/A           N/A                     No
       16.67%  0             L2 hit                    [H] 
0xc0000000000ba210  [unknown]         [H] 0xc00000075ce2fe38 
[unknown]         N/A           N/A                     No
       16.67%  0             L2 hit                    [H] 
0xc00000000000bdb0  [unknown]         [H] 0xc00000075ce2fee0 
[unknown]         N/A           N/A                     No
       16.67%  0             L2 hit                    [H] 
0xc0000000000bb444  [unknown]         [H] 0xc00000075ce30490 
[unknown]         N/A           N/A                     No
       16.67%  0             L3 hit                    [H] 
0x0000000000066524  [unknown]         [H] 0xc0000000014e0000 
[unknown]         N/A           N/A                     No


Maddy


>
