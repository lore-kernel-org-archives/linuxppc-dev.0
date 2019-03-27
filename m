Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2720C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:42:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF2B20651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="vGyuaLt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF2B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TwLS6m7SzDqQ5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 04:42:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="vGyuaLt8"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TwJk3cTPzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 04:40:54 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id A793A41A37;
 Wed, 27 Mar 2019 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:subject:subject:received
 :received:received; s=mta-01; t=1553708450; x=1555522851; bh=PvP
 YCGFSswVy4YDP6tcndnzCyoVOTwno4RZvjnvDwNY=; b=vGyuaLt871TMt8i/nbG
 2hI94GV38WBoqLVhFaY4dMQxi8CVyWcXgUgxmbj5a8R8AGXrpE5z/ClyQg7g1Nt/
 gdJ0Qy0bHpX+E2mU4SfFqungrZREgSCxHdX5Q+BzsqG8M9whJMnf61slXuaWbnZJ
 D71gZeEILFtuk0KdHFKzDOV4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qu9Rj9UteYu6; Wed, 27 Mar 2019 20:40:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 8168941A0C;
 Wed, 27 Mar 2019 20:40:50 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Mar 2019 20:40:50 +0300
Subject: Re: [PATCH RFC v4 11/21] PCI: Release and reassign the root bridge
 resources during rescan
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-12-s.miroshnichenko@yadro.com>
 <20190326204102.GS24180@google.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <5f7dc5a9-0ae6-1c49-22c2-5eabf3274114@yadro.com>
Date: Wed, 27 Mar 2019 20:40:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326204102.GS24180@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
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
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/26/19 11:41 PM, Bjorn Helgaas wrote:
> On Mon, Mar 11, 2019 at 04:31:12PM +0300, Sergey Miroshnichenko wrote:
>> When the movable BARs feature is enabled, don't rely on the memory gaps
>> reserved by the BIOS/bootloader/firmware, but instead rearrange the BARs
>> and bridge windows starting from the root.
>>
>> Endpoint device's BARs, after being released, are resorted and written
>> back by the pci_assign_unassigned_root_bus_resources().
>>
>> The last step of writing the recalculated windows to the bridges is done
>> by the new pci_setup_bridges() function.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  drivers/pci/pci.h       |  1 +
>>  drivers/pci/probe.c     | 22 ++++++++++++++++++++++
>>  drivers/pci/setup-bus.c | 11 ++++++++++-
>>  3 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 224d88634115..e06e8692a7b1 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -248,6 +248,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
>>  				struct list_head *realloc_head,
>>  				struct list_head *fail_head);
>>  bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
>> +void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
>>  
>>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>>  void pci_disable_bridge_window(struct pci_dev *dev);
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 1cf6ec960236..692752c71f71 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -3299,6 +3299,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
>>  	pm_runtime_put(&bus->dev);
>>  }
>>  
>> +static void pci_setup_bridges(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *dev;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		struct pci_bus *child;
>> +
>> +		if (!pci_dev_is_added(dev) || pci_dev_is_ignored(dev))
>> +			continue;
>> +
>> +		child = dev->subordinate;
>> +		if (child)
>> +			pci_setup_bridges(child);
>> +	}
>> +
>> +	if (bus->self)
>> +		pci_setup_bridge(bus);
>> +}
>> +
>>  /**
>>   * pci_rescan_bus - Scan a PCI bus for devices
>>   * @bus: PCI bus to scan
>> @@ -3321,8 +3340,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
>>  		pci_bus_rescan_prepare(root);
>>  
>>  		max = pci_scan_child_bus(root);
>> +
>> +		pci_bus_release_root_bridge_resources(root);
>>  		pci_assign_unassigned_root_bus_resources(root);
>>  
>> +		pci_setup_bridges(root);
>>  		pci_bus_rescan_done(root);
>>  	} else {
>>  		max = pci_scan_child_bus(bus);
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index be7d4e6d7b65..36a1907d9509 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1584,7 +1584,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>>  		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
>>  					PCI_BRIDGE_RESOURCES + idx, r);
>>  		/* keep the old size */
>> -		r->end = resource_size(r) - 1;
>> +		r->end = pci_movable_bars_enabled() ? 0 : (resource_size(r) - 1);
> 
> Doesn't this mean we're throwing away the information about the BAR
> size, and we'll have to size the BAR again somewhere?  I would like to
> avoid that.  But I don't know yet where you rely on this, so maybe
> it's not possible to avoid it.
> 

This resource is not a BAR, but a bridge window, I'm freeing it intentionally, so
pbus_size_mem() can later recalculate a new size.

Serge

>>  		r->start = 0;
>>  		r->flags = 0;
>>  
>> @@ -1637,6 +1637,15 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
>>  		pci_bridge_release_resources(bus, type);
>>  }
>>  
>> +void pci_bus_release_root_bridge_resources(struct pci_bus *root_bus)
>> +{
>> +	pci_bus_release_bridge_resources(root_bus, IORESOURCE_IO, whole_subtree);
>> +	pci_bus_release_bridge_resources(root_bus, IORESOURCE_MEM, whole_subtree);
>> +	pci_bus_release_bridge_resources(root_bus,
>> +					 IORESOURCE_MEM_64 | IORESOURCE_PREFETCH,
>> +					 whole_subtree);
>> +}
>> +
>>  static void pci_bus_dump_res(struct pci_bus *bus)
>>  {
>>  	struct resource *res;
>> -- 
>> 2.20.1
>>
