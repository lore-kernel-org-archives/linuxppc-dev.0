Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DCFC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:15:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD20206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="CFknAulS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD20206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TvlK47P5zDqQg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 04:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="CFknAulS"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tvhz0jFwzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 04:13:23 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 471EC41A44;
 Wed, 27 Mar 2019 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:subject:subject:received
 :received:received; s=mta-01; t=1553706799; x=1555521200; bh=K7g
 1/G+fNOX0BFnKr7e0y+67jQd2TaEUx/4VdgjmKMo=; b=CFknAulS/hEZVS2sl3M
 qp4Zdii/CWVsluDfvbxgawvrIPtC6YiJrVBbE9swRQYZi1BVGWxjkS6RyoLIn9e0
 5LGN7X0YHcevUPTlRtz7yV1coWNl9/GLgvTkvp6N5/ZFESF22dSNrRDZT8mn39cY
 WsHMOZsxNMwABzbeN6P+KxoI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EaZtAG3Elj9O; Wed, 27 Mar 2019 20:13:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 434EA41A3C;
 Wed, 27 Mar 2019 20:13:19 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Mar 2019 20:13:18 +0300
Subject: Re: [PATCH RFC v4 03/21] PCI: Enable bridge's I/O and MEM access for
 hotplugged devices
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-4-s.miroshnichenko@yadro.com>
 <20190326191307.GM24180@google.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <e1737a2d-0bbc-7c92-2295-e7520272caef@yadro.com>
Date: Wed, 27 Mar 2019 20:13:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326191307.GM24180@google.com>
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

On 3/26/19 10:13 PM, Bjorn Helgaas wrote:
> On Mon, Mar 11, 2019 at 04:31:04PM +0300, Sergey Miroshnichenko wrote:
>> After updating the bridge window resources, the PCI_COMMAND_IO and
>> PCI_COMMAND_MEMORY bits of the bridge must be addressed as well.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  drivers/pci/pci.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 895201d4c9e6..69898fe5255e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1622,6 +1622,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
>>  		pci_enable_bridge(bridge);
>>  
>>  	if (pci_is_enabled(dev)) {
>> +		int i, bars = 0;
>> +
>> +		for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++) {
>> +			if (dev->resource[i].flags & (IORESOURCE_MEM | IORESOURCE_IO))
>> +				bars |= (1 << i);
>> +		}
>> +		do_pci_enable_device(dev, bars);
> 
> In what situation is this needed, exactly?  This code already exists
> in pci_enable_device_flags().  Why isn't that enough?
> 
> I guess maybe there's some case where we enable the bridge, then
> assign bridge windows, then enable a downstream device?
> 
> Does this fix a bug with current hotplug?
> 

Sure, this change was implemented because of the issue: pci_enable_device_flags() returns
early if the device is already pci_is_enabled(), so if a bridge was already enabled before
the hotplug event, but without MEM and/or IO being set, these bits will not be set even if
a new device wants them.

I've chosen the pci_enable_bridge() for this snippet because it recursively updates all
the parent bridges.

Serge

>>  		if (!dev->is_busmaster)
>>  			pci_set_master(dev);
>>  		mutex_unlock(&dev->enable_mutex);
>> -- 
>> 2.20.1
>>
