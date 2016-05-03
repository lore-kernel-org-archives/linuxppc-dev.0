Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVh308T4zDrNL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:52:51 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:52:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1FF0C2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:52:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435qeKB8388866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:52:48 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435qEwe012372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:52:15 +1000
Subject: Re: [PATCH] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio
 page is exclusive
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1461759740-5072-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F84131D@SHSMSX101.ccr.corp.intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "corbet@lwn.net"
 <corbet@lwn.net>,
 "warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
 "zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
 "nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <00243350-1ccc-75e5-8cd8-a58dfe14637f@linux.vnet.ibm.com>
Date: Tue, 3 May 2016 13:52:08 +0800
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F84131D@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/5/3 10:59, Tian, Kevin wrote:

>> From: Yongji Xie
>> Sent: Wednesday, April 27, 2016 8:22 PM
>>
>> Current vfio-pci implementation disallows to mmap
>> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
>> page may be shared with other BARs. This will cause some
>> performance issues when we passthrough a PCI device with
>> this kind of BARs. Guest will be not able to handle the mmio
>> accesses to the BARs which leads to mmio emulations in host.
>>
>> However, not all sub-page BARs will share page with other BARs.
>> We should allow to mmap those sub-page MMIO BARs which we can
>> make sure will not share page with other BARs.
>>
>> This patch adds support for this case. And we also try to use
>> shadow resource to reserve the remaind of the page which hot-add
>> device's BAR might be assigned into.
> 'shadow' usually means you have a corresponding part being
> shadowed, while here looks you mostly want some 'dummy'
> resource for reservation purpose?

Yes., 'dummy' may be better here. And I would also replace
shadow_res/shadow_resources_list with reserved_res/reserved_resources_list.

>> +
>> +		if (!(res->start & ~PAGE_MASK)) {
>> +			/*
>> +			 * Add shadow resource for sub-page bar whose mmio
>> +			 * page is exclusive in case that hot-add device's
>> +			 * bar is assigned into the mem hole.
>> +			 */
>> +			shadow_res = kzalloc(sizeof(*shadow_res), GFP_KERNEL);
>> +			shadow_res->resource.start = res->end + 1;
>> +			shadow_res->resource.end = res->start + PAGE_SIZE - 1;
> What about res->start not page aligned so you end up still having
> a portion before res->start not exclusively reserved?

Do you mean add a 'dummy' resource to reserve the portion
before res->start if res->start not page aligned?

But would it happen that there is a mem hole in the portion
before res->start? The resource should have been assigned
into the hole at the beginning.

Thanks,
Yongji

>> +			shadow_res->resource.flags = res->flags;
>> +			if (request_resource(res->parent,
>> +					&shadow_res->resource)) {
>> +				kfree(shadow_res);
>> +				return false;
>> +			}
>> +			shadow_res->index = index;
>> +			list_add(&shadow_res->res_next,
>> +					&vdev->shadow_resources_list);
>> +			return true;
> Thanks
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
