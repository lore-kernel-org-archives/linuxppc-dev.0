Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54412C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 10:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF02A2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 10:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF02A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437hFH6R9lzDqWC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437hBy2JHtzDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 21:32:26 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E9FE2D2BFE;
 Mon,  3 Dec 2018 10:32:23 +0000 (UTC)
Received: from [10.36.118.125] (unknown [10.36.118.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 164D6662D2;
 Mon,  3 Dec 2018 10:32:17 +0000 (UTC)
Subject: Re: [PATCH RFCv2 1/4] mm/memory_hotplug: Introduce memory block types
To: Wei Yang <richard.weiyang@gmail.com>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-2-david@redhat.com>
 <20181201012507.lxfscl6ho3gc6gnn@master>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
Date: Mon, 3 Dec 2018 11:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181201012507.lxfscl6ho3gc6gnn@master>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 03 Dec 2018 10:32:23 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Oscar Salvador <osalvador@suse.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org,
 x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Michal Such??nek <msuchanek@suse.de>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Banman <andrew.banman@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01.12.18 02:25, Wei Yang wrote:
> On Fri, Nov 30, 2018 at 06:59:19PM +0100, David Hildenbrand wrote:
>> Memory onlining should always be handled by user space, because only user
>> space knows which use cases it wants to satisfy. E.g. memory might be
>> onlined to the MOVABLE zone even if it can never be removed from the
>> system, e.g. to make usage of huge pages more reliable.
>>
>> However to implement such rules (especially default rules in distributions)
>> we need more information about the memory that was added in user space.
>>
>> E.g. on x86 we want to online memory provided by balloon devices (e.g.
>> XEN, Hyper-V) differently (-> will not be unplugged by offlining the whole
>> block) than ordinary DIMMs (-> might eventually be unplugged by offlining
>> the whole block). This might also become relevat for other architectures.
>>
>> Also, udev rules right now check if running on s390x and treat all added
>> memory blocks as standby memory (-> don't online automatically). As soon as
>> we support other memory hotplug mechanism (e.g. virtio-mem) checks would
>> have to get more involved (e.g. also check if under KVM) but eventually
>> also wrong (e.g. if KVM ever supports standby memory we are doomed).
>>
>> I decided to allow to specify the type of memory that is getting added
>> to the system. Let's start with two types, BOOT and UNSPECIFIED to get the
>> basic infrastructure running. We'll introduce and use further types in
>> follow-up patches. For now we classify any hotplugged memory temporarily
>> as as UNSPECIFIED (which will eventually be dropped later on).
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Andrew Banman <andrew.banman@hpe.com>
>> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
>> Cc: Oscar Salvador <osalvador@suse.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Michal Such??nek <msuchanek@suse.de>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/base/memory.c  | 38 +++++++++++++++++++++++++++++++++++---
>> include/linux/memory.h | 27 +++++++++++++++++++++++++++
>> 2 files changed, 62 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 0c290f86ab20..17f2985c07c5 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -381,6 +381,29 @@ static ssize_t show_phys_device(struct device *dev,
>> 	return sprintf(buf, "%d\n", mem->phys_device);
>> }
>>
>> +static ssize_t type_show(struct device *dev, struct device_attribute *attr,
>> +			 char *buf)
>> +{
>> +	struct memory_block *mem = to_memory_block(dev);
>> +	ssize_t len = 0;
>> +
>> +	switch (mem->type) {
>> +	case MEMORY_BLOCK_UNSPECIFIED:
>> +		len = sprintf(buf, "unspecified\n");
>> +		break;
>> +	case MEMORY_BLOCK_BOOT:
>> +		len = sprintf(buf, "boot\n");
>> +		break;
>> +	default:
>> +		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
>> +				mem->state);
>> +		WARN_ON(1);
>> +		break;
>> +	}
>> +
>> +	return len;
>> +}
>> +
>> #ifdef CONFIG_MEMORY_HOTREMOVE
>> static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
>> 		unsigned long nr_pages, int online_type,
>> @@ -442,6 +465,7 @@ static DEVICE_ATTR(phys_index, 0444, show_mem_start_phys_index, NULL);
>> static DEVICE_ATTR(state, 0644, show_mem_state, store_mem_state);
>> static DEVICE_ATTR(phys_device, 0444, show_phys_device, NULL);
>> static DEVICE_ATTR(removable, 0444, show_mem_removable, NULL);
>> +static DEVICE_ATTR_RO(type);
> 
> This is correct, while looks not consistent with other attributes.
> 
> Not that beautiful :-)

I might change the other ones first, too (or keep this one consistent to
the existing ones). Thanks!

> 
>>
>> /*
>>  * Block size attribute stuff
>> @@ -620,6 +644,7 @@ static struct attribute *memory_memblk_attrs[] = {
>> 	&dev_attr_state.attr,
>> 	&dev_attr_phys_device.attr,
>> 	&dev_attr_removable.attr,
>> +	&dev_attr_type.attr,
>> #ifdef CONFIG_MEMORY_HOTREMOVE
>> 	&dev_attr_valid_zones.attr,
>> #endif
>> @@ -657,13 +682,17 @@ int register_memory(struct memory_block *memory)
>> }
>>
>> static int init_memory_block(struct memory_block **memory,
>> -			     struct mem_section *section, unsigned long state)
>> +			     struct mem_section *section, unsigned long state,
>> +			     int type)
>> {
>> 	struct memory_block *mem;
>> 	unsigned long start_pfn;
>> 	int scn_nr;
>> 	int ret = 0;
>>
>> +	if (type == MEMORY_BLOCK_NONE)
>> +		return -EINVAL;
> 
> No one will pass in this value. Can we omit this check for now?

I could move it to patch nr 2 I guess, but as I introduce
MEMORY_BLOCK_NONE here it made sense to keep it in here.

(and I think at least for now it makes sense to not squash patch 1 and
2, to easier discuss the new user interface/concept introduced in this
patch).

Thanks!

-- 

Thanks,

David / dhildenb
