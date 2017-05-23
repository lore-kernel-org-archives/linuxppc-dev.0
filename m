Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wX5N93XFNzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:34:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4N6U5MB046828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 02:34:14 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2am85erba5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 02:34:13 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 23 May 2017 16:34:11 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4N6Y10s51970054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:34:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4N6XUYq030478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:33:30 +1000
Subject: Re: [PowerPC][next-20170324][kselftest] kernel Oops when running
 tm/tm-signal-context-chk-vsx
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, sachinp <sachinp@linux.vnet.ibm.com>
Date: Tue, 23 May 2017 12:03:19 +0530
In-Reply-To: <1491210231.7788.12.camel@abdul.in.ibm.com>
References: <1490612559.8344.15.camel@abdul.in.ibm.com>
 <871sthbu12.fsf@concordia.ellerman.id.au>
 <1491209923.7788.9.camel@abdul.in.ibm.com>
 <1491210231.7788.12.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1495521199.9020.13.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 14:33 +0530, Abdul Haleem wrote:
> On Mon, 2017-04-03 at 14:28 +0530, Abdul Haleem wrote:
> > On Tue, 2017-03-28 at 21:00 +1100, Michael Ellerman wrote:
> > > Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > > 
> > > > Hi,
> > > >
> > > > While running kernel self tests on ppc64, tm/tm-signal-context-chk-vsx
> > > > tests fails with Oops message. 
> > > >
> > > > I was able to reproduce only twice out of 20 runs on next-20170324 only.
> > > > so it is difficult to bisect the commit causing the issue.
> > > 
> > > Can you try mainline as of this commit:
> > > 
> > > 605df8d674ac ("selftests/powerpc: Replace stxvx and lxvx with stxvd2x/lxvd2x")
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=605df8d674ac65e044a0bf4998b28c2f350b7f9e
> > > 
> > > cheers
> > > 
> > 
> > 
> > Trace is not reproducible on mainline with above commit.
> > 
> > Cyril was able to reproduce it and is working on it.
> > 
> > 
> > 
> > 
> cc Cyril Bur <cyrilbur@gmail.com>
> 

Hi Cyril,

I see a similar trace, but with 'tm-signal-stack' test for mainline
kernel 4.12.0-rc1 on PowerVM LPAR.

tm-signal-msr-r[7669]: bad frame in rt_sigreturn: 00007fffe8a6a6c0 nip
00007fff8335f094 lr 00007fff835104d8
tm-signal-stack[7675]: bad frame in setup_rt_frame: 0000000000000000 nip
0000000010000d44 lr 0000000010000d28
Bad kernel stack pointer 7fffd8b33530 at c00000000000b660
Oops: Bad kernel stack pointer, sig: 6 [#1]
SMP NR_CPUS=2048 
NUMA 
pSeries
Dumping ftrace buffer: 
   (ftrace buffer empty)
Modules linked in: vmx_crypto(E) pseries_rng(E) rtc_generic(E)
autofs4(E) [last unloaded: torture]
CPU: 8 PID: 8014 Comm: tm-signal-conte Tainted: G            E
4.12.0-rc1-autotest #1
task: c0000007742ac000 task.stack: c000000773b84000
NIP: c00000000000b660 LR: 0000000010001af0 CTR: 0000000000000000
REGS: c00000000ec23d40 TRAP: 0700   Tainted: G            E
(4.12.0-rc1-autotest)
MSR: 8000000102a03031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[E]>
  CR: 42000822  XER: 00000000  
CFAR: c00000000000b5b4 SOFTE: 0 
GPR00: 0000000000000025 00007fffd8b33530 0000000010028200
0000000000000000 
GPR04: 000000000000000a 0000000010020010 0000000000000000
0000000000000000 
GPR08: 00000000000000f8 0000000000000000 0000000000000000
0000000000000000 
GPR12: 0000000000000000 00007fff8b6ac440 0000000000000000
0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000
0000000000000000 
GPR24: 0000000000000000 0000000000000000 0000000000000000
00007fff8b69f948 
GPR28: 0000000010020010 0000000010020304 0000000000001f4e
00000000000333ce 
NIP [c00000000000b660] fast_exception_return+0x90/0x98
LR [0000000010001af0] 0x10001af0
Call Trace:
Instruction dump:
7c40e3a6 e9a100d8 7c7b03a6 e84101a0 7c4ff120 e8410170 7c5a03a6 e8010070 
e8410080 e8610088 e8810090 e8210078 <4c000024> 48000000 e8610178
88ed02bb 
---[ end trace a10b71ed348d921f ]---


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
