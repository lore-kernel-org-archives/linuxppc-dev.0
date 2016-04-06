Return-Path: <zhaolei@cn.fujitsu.com>
Received: from heian.cn.fujitsu.com (unknown [59.151.112.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qgC8C66KwzDq65
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 03:17:15 +1000 (AEST)
From: Zhao Lei <zhaolei@cn.fujitsu.com>
To: 'Srikar Dronamraju' <srikar@linux.vnet.ibm.com>, 'Anton Blanchard'
 <anton@samba.org>
CC: 'Peter Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@kernel.org>,
 <tglx@linutronix.de>, <efault@gmx.de>, <htejun@gmail.com>,
 <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
 <torvalds@linux-foundation.org>, <yangds.fnst@cn.fujitsu.com>,
 <hpa@zytor.com>, 'Stephen Rothwell' <sfr@canb.auug.org.au>, 'Michael
 Ellerman' <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
References: <aa171da036b520b51c79549e9b3215d29473f19d.1458635566.git.zhaolei@cn.fujitsu.com>
 <tip-d740037fac7052e49450f6fa1454f1144a103b55@git.kernel.org>
 <20160404140312.GA28495@linux.vnet.ibm.com> <20160406065436.GB3078@gmail.com>
 <20160406203219.788ae7cf@kryten> <20160406110803.GI2906@worktop>
 <20160406215950.04bc3f0b@kryten> <20160406132637.GA2108@linux.vnet.ibm.com>
In-Reply-To: <20160406132637.GA2108@linux.vnet.ibm.com>
Subject: RE: [PATCH] sched/cpuacct: Check for NULL when using task_pt_regs()
Date: Thu, 7 Apr 2016 01:05:52 +0800
Message-ID: <000101d19026$94249f00$bc6ddd00$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Srikar Dronamraju [mailto:srikar@linux.vnet.ibm.com]
> Sent: Wednesday, April 06, 2016 9:27 PM
> To: Anton Blanchard <anton@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@kernel.org>;
> tglx@linutronix.de; efault@gmx.de; htejun@gmail.com;
> linux-kernel@vger.kernel.org; tj@kernel.org; torvalds@linux-foundation.or=
g;
> zhaolei@cn.fujitsu.com; yangds.fnst@cn.fujitsu.com; hpa@zytor.com; Stephen
> Rothwell <sfr@canb.auug.org.au>; Michael Ellerman <mpe@ellerman.id.au>;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] sched/cpuacct: Check for NULL when using task_pt_reg=
s()
>=20
> * Anton Blanchard <anton@samba.org> [2016-04-06 21:59:50]:
>=20
> > Looks good, and the patch below does fix the oops for me.
> >
> > Anton
> > --
> >
> > task_pt_regs() can return NULL for kernel threads, so add a check.
> > This fixes an oops at boot on ppc64.
> >
> > Signed-off-by: Anton Blanchard <anton@samba.org>
>=20
> Works for me too.
>=20
> Reported-and-Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>=20
Thanks, all

I tested it in the vm(can not boot before fix):

[single cpu]
# for f in cpuacct.*; do echo "$f: "; cat $f; done
cpuacct.stat:
user 260
system 451
cpuacct.usage:
6923456654
cpuacct.usage_percpu:
6963446178
cpuacct.usage_percpu_sys:
2610934362
cpuacct.usage_percpu_user:
4451667140
cpuacct.usage_sys:
2612684054
cpuacct.usage_user:
4540275322
#

[2 cpu wih 8 maxcpus]
# for f in cpuacct.*; do echo "$f: "; cat $f; done
cpuacct.stat:
user 205
system 536
cpuacct.usage:
7293688020
cpuacct.usage_percpu:
3785674990 3551323200 0 0 0 0 0 0
cpuacct.usage_percpu_sys:
2227281124 1635060584 0 0 0 0 0 0
cpuacct.usage_percpu_user:
1567487176 1992278818 0 0 0 0 0 0
cpuacct.usage_sys:
3863445982
cpuacct.usage_user:
3643874038
#

# cat /proc/cpuinfo
processor       : 0
cpu             : POWER7 (raw), altivec supported
clock           : 1000.000000MHz
revision        : 2.3 (pvr 003f 0203)

processor       : 1
cpu             : POWER7 (raw), altivec supported
clock           : 1000.000000MHz
revision        : 2.3 (pvr 003f 0203)

timebase        : 512000000
platform        : pSeries
model           : IBM pSeries (emulated by qemu)
machine         : CHRP IBM pSeries (emulated by qemu)
#

Thanks
Zhaolei

> --
> Thanks and Regards
> Srikar Dronamraju
>=20
