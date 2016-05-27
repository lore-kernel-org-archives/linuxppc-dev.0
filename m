Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGNCw1PdczDqbW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 20:53:31 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4RAo5EJ048580
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 06:53:29 -0400
Message-Id: <201605271053.u4RAo5EJ048580@mx0a-001b2d01.pphosted.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 236ayme8gy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 06:53:29 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 27 May 2016 16:23:25 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3D6583940065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:23:21 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4RArLU038207592
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:23:21 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4RArGmN006212
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:23:20 +0530
Date: Fri, 27 May 2016 18:52:58 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, jeremy@goop.org, chrisw@sous-sol.org,
 akataria@vmware.com, rusty@rustcorp.com.au
Subject: Re: [PATCH v3 0/6] powerpc use pv-qpsinlock as the default spinlock
 implemention
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160526165047.GM3206@twins.programming.kicks-ass.net>
In-Reply-To: <20160526165047.GM3206@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年05月27日 00:50, Peter Zijlstra wrote:
> On Wed, May 25, 2016 at 04:18:03PM +0800, Pan Xinhui wrote:
>
>> _____test________________spinlcok______________pv-qspinlcok_____
>> |futex hash	|	556370 ops	|	629634 ops	|
>> |futex lock-pi	|	362 ops		|	367 ops		|
>>
>> scheduler test:
>> Test how many loops of schedule() can finish within 10 seconds on all cpus.
>>
>> _____test________________spinlcok______________pv-qspinlcok_____
>> |schedule() loops|	322811921 	|	311449290	|
>>
>> kernel compiling test:
>> build a linux kernel image to see how long it took
>>
>> _____test________________spinlcok______________pv-qspinlcok_____
>> | compiling takes|	22m 		|	22m		|
>
>
> s/spinlcok/spinlock/
>
Oh, foolish mistake...sorry

> Is 'spinlcok' the current test-and-set lock?
>
Yes. I will describe it in a clear way in the next patchset.
  
> And what about regular qspinlock, in case of !SHARED_PROCESSOR?
>

You mean the test results on powerNV?

yes, I make a kernel build with !SHARED_PROCESSOR.
and do perf tests and scheduler tests on same machine(32 cpus). performance is better than current spinlock

  _____test________________spinlock________________qspinlock_____
  |futex hash	|	533060 ops	|	541513 ops	|
  |futex lock-pi	|	357 ops		|	356 ops		|


  _____test________________spinlock________________qspinlock_____
  |schedule() loops|	337691713 	|	361935207	|


NOTE: I have updated the scheduler test tools, and the new performance test results show that both pv-spinlock and qspinlock is better than current spinlock.
I will also update the test result in my next patchset.

thanks
xinhui
