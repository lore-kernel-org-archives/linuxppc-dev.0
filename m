Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYR3m64kFzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 20:54:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4PArc43110337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 06:54:40 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2anq28qje1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 06:54:40 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 25 May 2017 20:54:36 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4PAsQWJ29491332
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 20:54:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4PAs1IS002438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 20:54:02 +1000
Subject: Re: [PowerPC][next-20170324][kselftest] kernel Oops when running
 tm/tm-signal-context-chk-vsx
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Cyril Bur <cyrilbur@gmail.com>, sachinp <sachinp@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Thu, 25 May 2017 16:23:39 +0530
In-Reply-To: <87mva2a2yb.fsf@concordia.ellerman.id.au>
References: <1490612559.8344.15.camel@abdul.in.ibm.com>
 <871sthbu12.fsf@concordia.ellerman.id.au>
 <1491209923.7788.9.camel@abdul.in.ibm.com>
 <1491210231.7788.12.camel@abdul.in.ibm.com>
 <1495521199.9020.13.camel@abdul.in.ibm.com>
 <87mva2a2yb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1495709619.27765.11.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-24 at 21:50 +1000, Michael Ellerman wrote:
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > Hi Cyril,
> >
> > I see a similar trace, but with 'tm-signal-stack' test for mainline
> > kernel 4.12.0-rc1 on PowerVM LPAR.
> 
> I can't reproduce this here.
It is not reproducible all the times.
> 
> Can you please retest on rc2.

With rc2, I see a similar call trace for the test
'tm_signal_context_chk_fpu'

I tried running tm-signal-stack alone, but no luck.
> 
> Also please include the exact version of the test (it prints it), and
> what toolchain you built it with.

test: tm_signal_context_chk_fpu
tags: git_version:v4.12-rc2-62-g2426125
success: tm_signal_context_chk_fpu

toolchain : gcc version 5.2.1


latest trace:
[ 1953.024563] Bad kernel stack pointer 7fffe0a1ddc0 at c00000000000b660
[ 1953.024582] Oops: Bad kernel stack pointer, sig: 6 [#1]
[ 1953.024585] SMP NR_CPUS=2048 
[ 1953.024585] NUMA 
[ 1953.024587] pSeries
[ 1953.024590] Modules linked in: rtc_generic vmx_crypto pseries_rng
autofs4
[ 1953.024597] CPU: 14 PID: 27145 Comm: tm-signal-conte Not tainted
4.12.0-rc2-00062-g2426125-dirty #1
[ 1953.024601] task: c0000007699f8600 task.stack: c00000076a24c000
[ 1953.024603] NIP: c00000000000b660 LR: 0000000010001aac CTR:
0000000000000000
[ 1953.024608] REGS: c00000000ebdbd40 TRAP: 0700   Not tainted
(4.12.0-rc2-00062-g2426125-dirty)
[ 1953.024610] MSR: 8000000102a03031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[E]>
[ 1953.024615]   CR: 42000822  XER: 00000000
[ 1953.024618] CFAR: c00000000000b5b4 SOFTE: 0 
               GPR00: 0000000000000025 00007fffe0a1ddc0 0000000010028200
0000000000000000 
               GPR04: 000000000000000a 0000000000000000 0000000000000000
0000000000000000 
               GPR08: 00000000000000f8 0000000000000000 0000000000000000
0000000000000000 
               GPR12: 0000000000000000 00007fff8878c440 ffffffffffffffff
fffffffffffffffe 
               GPR16: fffffffffffffffd fffffffffffffffc fffffffffffffffb
fffffffffffffffa 
               GPR20: fffffffffffffff9 fffffffffffffff8 fffffffffffffff7
fffffffffffffff6 
               GPR24: fffffffffffffff5 fffffffffffffff4 fffffffffffffff3
fffffffffffffff2 
               GPR28: fffffffffffffff1 fffffffffffffff0 ffffffffffffffef
ffffffffffffffee 
[ 1953.024652] NIP [c00000000000b660] fast_exception_return+0x90/0x98
[ 1953.024655] LR [0000000010001aac] 0x10001aac
[ 1953.024657] Call Trace:
[ 1953.024658] Instruction dump:
[ 1953.024661] 7c40e3a6 e9a100d8 7c7b03a6 e84101a0 7c4ff120 e8410170
7c5a03a6 e8010070 
[ 1953.024666] e8410080 e8610088 e8810090 e8210078 <4c000024> 48000000
e8610178 88ed02bb 
[ 1953.024671] ---[ end trace 3e1eeb3cfb1260c1 ]---

> 
> cheers
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
