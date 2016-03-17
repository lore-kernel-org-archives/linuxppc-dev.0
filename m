Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQmmZ1MwgzDq70
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:47:10 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 17 Mar 2016 21:36:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A58352CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:36:18 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2HBaA6l6226274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:36:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2HBZjYs003460
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:35:46 +1100
Subject: Re: [RFC PATCH v4 3/7] PCI: Ignore resource_alignment if
 PCI_PROBE_ONLY was set
To: Alex Williamson <alex.williamson@redhat.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160316103151.0269f0c5@t450s.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA9682.5050600@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 19:35:30 +0800
MIME-Version: 1.0
In-Reply-To: <20160316103151.0269f0c5@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/3/17 0:31, Alex Williamson wrote:
> On Mon,  7 Mar 2016 15:48:34 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>
>> The resource_alignment will releases memory resources
>> allocated by firmware so that kernel can reassign new
>> resources later on. But this will cause the problem
>> that no resources can be allocated by kernel if
>> PCI_PROBE_ONLY was set, e.g. on pSeries platform
>> because PCI_PROBE_ONLY force kernel to use firmware
>> setup and not to reassign any resources.
>>
>> To solve this problem, this patch ignores
>> resource_alignment if PCI_PROBE_ONLY was set.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   Documentation/kernel-parameters.txt |    2 ++
>>   drivers/pci/probe.c                 |    3 ++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index d8b29ab..8028631 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -2922,6 +2922,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>   				windows need to be expanded.
>>   				noresize: Don't change the resources' sizes when
>>   				reassigning alignment.
>> +				Note that this option will not work if
>> +				PCI_PROBE_ONLY is set.
> How would a user have any idea if this is set?

I found the PCI_PROBE_ONLY is set on pSeries, maple and
arm with "firmware" kernel parameter enabled.

So can we say: Note that this option will not work on pSeries,
maple and arm with "firmware" kernel parameter enabled?
Or do you have any suggestion?

Thanks,
Yongji Xie
