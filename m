Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1V996W9RzDr3F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 00:37:49 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v63EXpbL081658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 10:37:47 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bfdbcsb77-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 10:37:46 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 4 Jul 2017 00:37:43 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v63EaRBQ66322602
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 00:36:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v63EaOlj018830
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 00:36:25 +1000
Subject: Re: [next-20170609] Oops while running CPU off-on
 (cpuset.c/cpuset_can_attach)
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>, mpe
 <mpe@ellerman.id.au>
Date: Mon, 03 Jul 2017 20:06:22 +0530
In-Reply-To: <20170627153608.GD2289@htj.duckdns.org>
References: <1497266622.15415.39.camel@abdul.in.ibm.com>
 <20170627153608.GD2289@htj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1499092582.10651.15.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-27 at 11:36 -0400, Tejun Heo wrote:
> Hello, Abdul.
> 
> Sorry about the long delay.
> 
> On Mon, Jun 12, 2017 at 04:53:42PM +0530, Abdul Haleem wrote:
> > linux-next kernel crashed while running CPU offline and online.
> > 
> > Machine: Power 8 LPAR
> > Kernel : 4.12.0-rc4-next-20170609
> > gcc : version 5.2.1
> > config: attached
> > testcase: CPU off/on
> > 
> > for i in $(seq 100);do 
> >     for j in $(seq 0 15);do 
> >         echo 0 >  /sys/devices/system/cpu/cpu$j/online
> >         sleep 5
> >         echo 1 > /sys/devices/system/cpu/cpu$j/online
> >     done
> > done
> > 
> ...
> > NIP [c0000000001d6868] cpuset_can_attach+0x58/0x1b0
> 
> Can you please map this to the source line?

Hi Tejun,

Was able to recreate on latest next kernel, from the new trace.

Unable to handle kernel paging request for data at address 0x000009e0
Faulting instruction address: 0xc0000000001dd688

which is:
c0000000001dd688 <cpuset_can_attach+0x58> e0 09 23 e9 ld  r9,2528(r3)

r9 = c000000775cd7950, 2528(0000000000000000) = 0x000009e0


Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 
NUMA 
pSeries
Modules linked in: xt_addrtype xt_conntrack ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 iptable_filter ip_tables x_tables nf_nat nf_conntrack bridge
stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c
vmx_crypto rtc_generic pseries_rng autofs4
CPU: 15 PID: 120 Comm: kworker/15:1 Tainted: G        W
4.12.0-rc7-next-20170630-autotest #1
Workqueue: events cpuset_hotplug_workfn
task: c000000775c5e300 task.stack: c000000775cd4000
NIP: c0000000001dd688 LR: c0000000001dd678 CTR: c0000000001dd630
REGS: c000000775cd7730 TRAP: 0300   Tainted: G        W
(4.12.0-rc7-next-20170630-autotest)
MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
  CR: 44a32222  XER: 20000000
CFAR: c000000000008718 DAR: 00000000000009e0 DSISR: 40000000 SOFTE: 1
GPR00: c0000000001dd678 c000000775cd79b0 c00000000154a400
0000000000000000 
GPR04: c000000775cd79d0 0000000000000000 c000000775cd7ad0
c0000000fb1de480
GPR08: c0000000fb1dda98 c000000775cd7950 c00000000174a400
0000000000000000  
GPR12: c0000000001dd630 c00000000e789600 c000000000128dc8
c000000776bb0080 
GPR16: 0000000000000000 0000000000000000 c00000000bcc91c0
c00000000bcc91e0 
GPR20: c00000000bcc90c0 0000000000000000 0000000000000000
0000000000000000 
GPR24: 0000000000000000 c000000775cd7a30 c000000001428020
c000000001745cdc 
GPR28: c000000001427130 c000000775cd7ac0 c00000000b41b588
0000000000000000 
NIP [c0000000001dd688] cpuset_can_attach+0x58/0x1b0

> gdb -batch vmlinux -ex 'list *(0xc0000000001dd688)'

0xc0000000001dd688 is in cpuset_can_attach (./include/linux/compiler.h:250).
245	})
246	
247	static __always_inline
248	void __read_once_size(const volatile void *p, void *res, int size)
249	{
250		__READ_ONCE_SIZE;
251	}
252	
253	#ifdef CONFIG_KASAN
254	/*

Does this helps, please let me know if you need more debugging. Thanks

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
