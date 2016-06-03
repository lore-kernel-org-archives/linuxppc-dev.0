Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLZnC11XPzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 17:03:26 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5370RXD035331
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 03:03:25 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23b3g1c1d4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jun 2016 03:03:25 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 3 Jun 2016 17:03:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7BD9F3578067
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 17:02:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5372mLU65994858
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 17:02:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5372k0e017929
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 17:02:47 +1000
Date: Fri, 03 Jun 2016 15:02:11 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
CC: paulus@samba.org, mpe@ellerman.id.au, peterz@infradead.org,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com
Subject: Re: [PATCH v5 1/6] qspinlock: powerpc support qspinlock
References: <1464859370-5162-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464859370-5162-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464917520.26773.11.camel@kernel.crashing.org>
 <1464917548.26773.12.camel@au1.ibm.com> <57510353.1020209@linux.vnet.ibm.com>
 <1464928427.26773.26.camel@kernel.crashing.org>
In-Reply-To: <1464928427.26773.26.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57512B73.5010005@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月03日 12:33, Benjamin Herrenschmidt wrote:
> On Fri, 2016-06-03 at 12:10 +0800, xinhui wrote:
>> On 2016年06月03日 09:32, Benjamin Herrenschmidt wrote:
>>> On Fri, 2016-06-03 at 11:32 +1000, Benjamin Herrenschmidt wrote:
>>>> On Thu, 2016-06-02 at 17:22 +0800, Pan Xinhui wrote:
>>>>>
>>>>> Base code to enable qspinlock on powerpc. this patch add some
>>>>> #ifdef
>>>>> here and there. Although there is no paravirt related code, we
>> can
>>>>> successfully build a qspinlock kernel after apply this patch.
>>>> This is missing the IO_SYNC stuff ... It means we'll fail to do a
>>>> full
>>>> sync to order vs MMIOs.
>>>>
>>>> You need to add that back in the unlock path.
>>>
>>> Well, and in the lock path as well...
>>>
>> Oh, yes. I missed IO_SYNC stuff.
>>
>> thank you, Ben :)
>
> Ok couple of other things that would be nice from my perspective (and
> Michael's) if you can produce them:
>
>   - Some benchmarks of the qspinlock alone, without the PV stuff,
>     so we understand how much of the overhead is inherent to the
>     qspinlock and how much is introduced by the PV bits.
>
>   - For the above, can you show (or describe) where the qspinlock
>     improves things compared to our current locks. While there's
>     theory and to some extent practice on x86, it would be nice to
>     validate the effects on POWER.
>
>   - Comparative benchmark with the PV stuff in on a bare metal system
>     to understand the overhead there.
>
>   - Comparative benchmark with the PV stuff under pHyp and KVM
>
Will do such benchmark tests in next days.
thanks for your kind suggestions. :)

> Spinlocks are fiddly and a critical piece of infrastructure, it's
> important we fully understand the performance implications before we
> decide to switch to a new model.
>
yes, We really need understand how {pv}qspinlock works in more complex cases.

thanks
xinhui
> Cheers,
> Ben.
>
