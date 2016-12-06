Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXkRg3YpTzDvtg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:23:59 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB61KGEf048564
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 20:23:57 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275h5m7qb6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 20:23:57 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 11:23:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1DAE12CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:23:52 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB61NqRm64094356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:23:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB61NpeI003655
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:23:51 +1100
Subject: Re: [PATCH v8 2/6] powerpc: pSeries/Kconfig: Add qspinlock build
 config
To: Boqun Feng <boqun.feng@gmail.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1480951166-44830-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161206005834.GC18164@tardis.cn.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 09:24:08 +0800
MIME-Version: 1.0
In-Reply-To: <20161206005834.GC18164@tardis.cn.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <2d4eb891-e999-b7f8-52ff-31ef7bb8af6b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/12/6 08:58, Boqun Feng 写道:
> On Mon, Dec 05, 2016 at 10:19:22AM -0500, Pan Xinhui wrote:
>> pSeries/powerNV will use qspinlock from now on.
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>> index bec90fb..8a87d06 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>
> Why here? Not arch/powerpc/platforms/Kconfig?
>
>> @@ -23,6 +23,14 @@ config PPC_PSERIES
>>  	select PPC_DOORBELL
>>  	default y
>>
>> +config ARCH_USE_QUEUED_SPINLOCKS
>> +	default y
>> +	bool "Enable qspinlock"
>
> I think you just enable qspinlock by default for all PPC platforms. I
> guess you need to put
>
> 	depends on PPC_PSERIES || PPC_POWERNV
>
> here to achieve what you mean in you commit message.
>
yes, another good way.
I prefer to put it in pseries/Kconfig as same as pv-qspinlocks config.
when we build nv, it still include pSeries's config anyway.

thanks
xinhui

> Regards,
> Boqun
>
>> +	help
>> +	  Enabling this option will let kernel use qspinlock which is a kind of
>> +	  fairlock.  It has shown a good performance improvement on x86 and also ppc
>> +	  especially in high contention cases.
>> +
>>  config PPC_SPLPAR
>>  	depends on PPC_PSERIES
>>  	bool "Support for shared-processor logical partitions"
>> --
>> 2.4.11
>>
