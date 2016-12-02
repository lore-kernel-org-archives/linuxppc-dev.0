Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVMnK1pRWzDvtR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 16:16:05 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB25EdgK084197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 00:16:02 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 272mvjrd2t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Dec 2016 00:16:02 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 2 Dec 2016 10:45:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id BD5EE3940064
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 10:45:55 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB25Ft6w32309354
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 10:45:55 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB25FqlO000577
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 10:45:54 +0530
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
To: yjin <yanjiang.jin@windriver.com>, Balbir Singh <bsingharora@gmail.com>
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
 <874m2n7yrf.fsf@concordia.ellerman.id.au>
 <CAKTCnzkY_g8Z61K_rQetLGbcGdJ-VUV79MEBkZej=yCM3=KJkw@mail.gmail.com>
 <5840FA25.3010009@windriver.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, oss@buserror.net, jinyanjiang@gmail.com,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Fri, 2 Dec 2016 13:15:39 +0800
MIME-Version: 1.0
In-Reply-To: <5840FA25.3010009@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <546ba7c8-999c-b393-b4b3-ee8602b724fd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/12/2 12:35, yjin 写道:
>
> On 2016年12月02日 12:22, Balbir Singh wrote:
>> On Fri, Dec 2, 2016 at 3:15 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> yanjiang.jin@windriver.com writes:
>>>
>>>> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
>>>> index 4f60db0..4423e97 100644
>>>> --- a/arch/powerpc/include/asm/cputime.h
>>>> +++ b/arch/powerpc/include/asm/cputime.h
>>>> @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const unsigned long clk)
>>>>        return (__force cputime_t) ct;
>>>>   }
>>>>
>>>> -#define cputime64_to_clock_t(ct)     cputime_to_clock_t((cputime_t)(ct))
>>>> +#define cputime64_to_clock_t(ct)     \
>>>> +     (__force u64)(cputime_to_clock_t((cputime_t)(ct)))
>>> Given the name of the function is "cputime64 to clock_t", surely we
>>> should be returning a clock_t ?
>> Please fix it in cpuacct.c  Also check out git commit
>> 527b0a76f41d062381adbb55c8eb61e32cb0bfc9
>> sched/cpuacct: Avoid %lld seq_printf warning
>
> Hi Balbir,
>
> Where can I find this commit?
>
hello,
	it is in next tree. :)

commit 527b0a76f41d062381adbb55c8eb61e32cb0bfc9
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Fri Nov 11 15:27:49 2016 +0100

     sched/cpuacct: Avoid %lld seq_printf warning
     
     For s390 kernel builds I keep getting this warning:
     
      kernel/sched/cpuacct.c: In function 'cpuacct_stats_show':
      kernel/sched/cpuacct.c:298:25: warning: format '%lld' expects argument of type 'long long int', but argument 4 has type 'clock_t {aka long int}' [-Wformat=]
        seq_printf(sf, "%s %lld\n",
     
     Silence the warning by adding an explicit cast.
     
     Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Peter Zijlstra <peterz@infradead.org>
     Cc: Thomas Gleixner <tglx@linutronix.de>
     Link: http://lkml.kernel.org/r/20161111142749.6545-1-schwidefsky@de.ibm.com
     Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index bc0b309c..9add206 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -297,7 +297,7 @@ static int cpuacct_stats_show(struct seq_file *sf, void *v)
         for (stat = 0; stat < CPUACCT_STAT_NSTATS; stat++) {
                 seq_printf(sf, "%s %lld\n",
                            cpuacct_stat_desc[stat],
-                          cputime64_to_clock_t(val[stat]));
+                          (long long)cputime64_to_clock_t(val[stat]));
         }
  
         return 0;

> Thanks!
> Yanjiang
>>
>> Balbir
>
