Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDC681A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:10:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 05:10:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9E1AE2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:10:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TJ9ws054591656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:10:06 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TJ9XYj013089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:09:34 +1000
Message-ID: <560AE21E.8040903@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 00:40:22 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  0/5] powerpc:numa Add serial nid support
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150928173434.GE48470@linux.vnet.ibm.com>
In-Reply-To: <20150928173434.GE48470@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 11:04 PM, Nishanth Aravamudan wrote:
> On 27.09.2015 [23:59:08 +0530], Raghavendra K T wrote:
[...]
>>
>> 2) Map the sparse chipid got from device tree to a serial nid at kernel
>> level (The idea proposed in this series).
>> Pro: It is more natural to handle at kernel level than at lower (OPAL) layer.
>> con: The chipid is in device tree no longer the same as nid in kernel
>
> Is there any debugging/logging? Looks like not -- so how does a sysadmin
> map from firmware-provided values to the Linux values? That's going to
> make debugging of large systems (PowerVM or otherwise) less than
> pleasant, it seems? Possibly you could put something in sysfs?

I see 2 things could be done here:

1) while doing dump_numa_cpu_topology() we can dump nid_to_chipid()
as additional information.

2) sysfs->
Does /sys/devices/system/node/nodeX/*chipid* looks good. May be we
should add only for powerpc or otherwise we need to have chipid = nid
populated for other archs. [ I think this change may be done slowly ]
