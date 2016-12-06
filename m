Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXlX30CNvzDvkH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 13:12:50 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB629uTX054704
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:12:48 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 275eg11gu2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 21:12:48 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 07:42:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4D582394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 07:42:42 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB62CgFo16973998
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 07:42:42 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB62CdhY030876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 07:42:41 +0530
Subject: Re: [PATCH v8 2/6] powerpc: pSeries/Kconfig: Add qspinlock build
 config
To: Boqun Feng <boqun.feng@gmail.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1480951166-44830-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161206005834.GC18164@tardis.cn.ibm.com>
 <2d4eb891-e999-b7f8-52ff-31ef7bb8af6b@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 10:12:56 +0800
MIME-Version: 1.0
In-Reply-To: <2d4eb891-e999-b7f8-52ff-31ef7bb8af6b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <945a9698-e02e-e004-f1df-cabded4d8398@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/12/6 09:24, Pan Xinhui 写道:
>
>
> 在 2016/12/6 08:58, Boqun Feng 写道:
>> On Mon, Dec 05, 2016 at 10:19:22AM -0500, Pan Xinhui wrote:
>>> pSeries/powerNV will use qspinlock from now on.
>>>
>>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>>> index bec90fb..8a87d06 100644
>>> --- a/arch/powerpc/platforms/pseries/Kconfig
>>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>>
>> Why here? Not arch/powerpc/platforms/Kconfig?
>>
>>> @@ -23,6 +23,14 @@ config PPC_PSERIES
>>>      select PPC_DOORBELL
>>>      default y
>>>
>>> +config ARCH_USE_QUEUED_SPINLOCKS
>>> +    default y
>>> +    bool "Enable qspinlock"
>>
>> I think you just enable qspinlock by default for all PPC platforms. I
>> guess you need to put
>>
>>     depends on PPC_PSERIES || PPC_POWERNV
>>
>> here to achieve what you mean in you commit message.
>>
oh, yes, need depends on PPC_PSERIES || PPC_POWERNV.

> yes, another good way.
> I prefer to put it in pseries/Kconfig as same as pv-qspinlocks config.
> when we build nv, it still include pSeries's config anyway.
>
> thanks
> xinhui
>
>> Regards,
>> Boqun
>>
>>> +    help
>>> +      Enabling this option will let kernel use qspinlock which is a kind of
>>> +      fairlock.  It has shown a good performance improvement on x86 and also ppc
>>> +      especially in high contention cases.
>>> +
>>>  config PPC_SPLPAR
>>>      depends on PPC_PSERIES
>>>      bool "Support for shared-processor logical partitions"
>>> --
>>> 2.4.11
>>>
