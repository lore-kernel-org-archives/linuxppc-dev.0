Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E84C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63D3217F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="IB/Y7hTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63D3217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Twqz4NBszDqBZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:04:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="IB/Y7hTG"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TwnD4X9YzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:02:08 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B292341A3E;
 Wed, 27 Mar 2019 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:subject:subject:received
 :received:received; s=mta-01; t=1553709724; x=1555524125; bh=CNS
 e9NFSeRbT8lRLDxsT8CihYFHPcKyA+pYusTN6+Qk=; b=IB/Y7hTGtqZ5AEnrU0D
 pa6YJz6le4q2MuHtjtJKqtWs7+uOJFHyleGzMNhzE6KSzf+clzZgQhPQz5Ca5ZW8
 UWAg63WLLY8VnKF+YTd43gCiXqNMXVCq/p+a+4y0tfZdELiHN9wnfP3isylGrU5L
 eD4Q6JeYLbi9/U1PAOoUQgRQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 54W4ccCUBm-x; Wed, 27 Mar 2019 21:02:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 241FC41860;
 Wed, 27 Mar 2019 21:02:04 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Mar 2019 21:02:03 +0300
Subject: Re: [PATCH RFC v4 12/21] PCI: Don't allow hotplugged devices to steal
 resources
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-13-s.miroshnichenko@yadro.com>
 <20190326205533.GT24180@google.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 xsFNBFm31LoBEAC1wCndw8xXjGaJOinDBeVD1/8TFlVehvafur6V9xH3gsHhs0weDcMgw2Ki
 r5ZVhS8BlltU0snpsnQHxYB5BF0gzCLwwPUjFPZ7E0/++ylbNJoGe53cVbE870NK5WqoSEUg
 QtTQev2/Y5q0v7kfMh9g5p5jzeqfQSZzOrEP4d1cg5tPNKYji5cCfB/NQTHWV9w4EPj3UJQT
 ZPp4xqMAXu0JU1W9/XecNobKaHfEv9T+UWdx2eufiNqCgfAkRVCl8V0tKhQ4PZlZdp0dQH/N
 BreUg1+QJ4/t2SyEsiIPqYxFBW6qWAgOP5fzGNG31VHaQeJCA31keh84/8t632HZ4FDRrS3N
 6V7Oc0ew7h5AwgOca4d3TTn8ATfASQ5vAxHC2ZK9CZhfa3RgK+8X5+vwkqc8O70iTmE9Goap
 uDMtgvIc0r0PHTiB3eZlyHExMD+FIOBOp2GvL7BmFHMgyOjNDdh2vBNqUwiv1RTQVWPhNX/J
 4ZhTAZuAr5+6S/iRFpWspCqKvgonPxSzfWRS5dWJ2kavuvXkSB5eyPx9XRgrWxZwVdseuTpi
 CeTEW9/noDDl1edZdWHGWS9/4BC1nByitYYUcPXuzSkIsuae2tDw+lnsQfgAn+pXT6ESjEnZ
 LGnnWMQNLISf8yIaEh6bft+vXT67o1G2/U6VN1+suUPcDgYEVQARAQABzTJTZXJnZWkgTWly
 b3NobmljaGVua28gPHMubWlyb3NobmljaGVua29AeWFkcm8uY29tPsLBlAQTAQgAPhYhBB1u
 0+6Lz/3BafPm9wx0PmjRU7O1BQJZt9S6AhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4B
 AheAAAoJEAx0PmjRU7O1WfEP/jdWabDp11EdD9ZCK8LlwZ/SgXVfr9lZ5Kx3VVI68KAcfupH
 3m+1lGTOktpRu7gQaj867KCbzRCWJjoVibrBgMMaFZQX2Bf2usxuBN9QxUnehg3R5Yr+c0KS
 9v2oSduWaMJ/Fs3IVg5gh0bhH3lMHISqAQLtl3ncyB+1O+X+MgReRGznj5tkjQWC960t85SO
 hkNkhVMp0z2b1XfY51XxYRESdNkJswxv3UnpAvlgdh+ItzJU8fRmfUtOzRdGD6mukrkpkS1z
 lAGNLayBOiEWUk8E1gm3rK46l/sm6Gq9ExCh+bgkwQHRp/JhyHpsid9V/o5nLh+jbh/CLYIF
 onrG2RN6lePQpyh6TpiZfGbxz/4rny88HdCD31OdvTwbnNp5Fj48YXbUlo8WILg2OHWbSRQ9
 w7OuTLcITPW084E/Uq/nL6+m316OZpY7iiVB+1e2reJRjnsqlK+TX7N1KsAamba3hGSqF8QC
 61RAzXS99D1ohL98G0hJNYyuHaeWus4wJRt8JBEe6D4r0hrS/O97oa0juygwY+zP9mtpYRr4
 t9Im1hpIkV+cC3aJrRiQNaXJN4S+8F8DQnXMUitf0590NNKwYRuQuTg5URoqjYBFZtXGgS7w
 vdyzevMt1bCBtZW6Rbdu6TcHoF3Aminx96wXlSizTGpo+xJ589xQ46U9KWXdzsFNBFm31LoB
 EADAsXCTRufklKBW9jdUMwjltZjXwu5muxcVRj8XICi77oa9DgsGhA5v7vosbpNXzZAL018h
 1khPu6ca6X0shLm0Le2KQ6Q00VHEwrTjXQ0NN0aa+vRG3NKPb9t/SiXg6yNPKuQxTsYm0vP9
 4fIH6nHDtJpBXq8LK5C6GTD6G2R3VTSPpJz6tFPrfLrV4jPARFRAZ483Wjs9iBRygFTtb6YJ
 r1YJnwmXcb8Z/ds3vPo5ULMcMlcXEA7NlkmN7r3LUkmE6Tjr1hZHGwEWRwSiw1CwkAQqLlMX
 xRul5+nPz0pPrB8hBxONjnlGX3f0Ky2xdKxrFxlzd8HtRzhWb4R0vqgWQRXXFeKc++uEyk6g
 KZ48zSjLq0Av4ZS8POCL1JisSV7Hbwe4Ik3qaeR61KEuVtBlySFijwvTs4p5b9PcG2fmNiyo
 aFBdFkbI/pTuORRBYCLbjXwyRWnCGBWZ8b0NSCs4sb9vNyObxoLYN4RdRnKKLpkXz3EXdPWZ
 WswxQQNopKs5pE3aAvYfTitIg0JmKSK57w3UJNS11s5xTRAmKDHj9PmLZcNLFhG7ceb9T41+
 YLNCEu8/xvFEorp+AlJ6n0clfPsNsi8317ZJL0mgZ0XrD9efmuA+xvb/0T67D371qK6xDaZ2
 xN71pfjhZl1OYNZ3FDJLpZSNZKNFluhRWOvTKQARAQABwsF8BBgBCAAmFiEEHW7T7ovP/cFp
 8+b3DHQ+aNFTs7UFAlm31LoCGwwFCQlmAYAACgkQDHQ+aNFTs7XITg/9GHcaTLjsRP7Pacu0
 PFs2ubddBvZPC19sIILUNDlQHsOVKTpuFTtEmA6F4o4gf/SY8AvnHyVVqe8YYsQkPwhwfwbH
 ihoDZyJxyr52mqanez3sQV6RQEqCZtKaJtMdZrtOZcjqrAxEG1arowCKnnoPF+ivtA4ZEtlm
 xt9x5S0UfytTIZR0KKsRfO7XZvqfzbg6/NVRnUibSzCz2yzC5kbsyjPoK+c+C142BlnCdgai
 0It5xKX1BBoVT/YSeB5ACGijuRsuDH2mHzdOeEDlP/UOAB5gx9aBOdP8YMTAk2b4qfANX7Pc
 W8BnI99mWuOP04KVgdQf5vgwMRDlgdtsQJw7l5YBQxprq8edAH3xsKung03qsV2inbQDkMnl
 c+l79kx0ilh0oLwviRft5xVCOfCyVkvekUhN4qG+guGFJbxYffliFB02Kcf2e4CueCnGGZAw
 +OkhHbtDmgmyslv7cxf1qzsObQfYc9eR5f8uiX41bLPwTMy18YnYk2hxJSW0g+LkPqBVQcAO
 Nwdozk9DY6wY9cMQ8coYTctox5VsvYEz2rJCRiIc40NO76gdMVutEORjdSoeZK32srVNoBo9
 L0EK2QCFFRDcslPDpZWE1uDZQPW+GC2Z/dmuEpaMzlrIgfZ8GLXxHbB+VdDQ7QE//lphXskF
 lHi50np+KDDPzZS51tw=
Message-ID: <73615c60-8b8d-dca6-cdd0-50b481c3d835@yadro.com>
Date: Wed, 27 Mar 2019 21:02:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326205533.GT24180@google.com>
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

On 3/26/19 11:55 PM, Bjorn Helgaas wrote:
> On Mon, Mar 11, 2019 at 04:31:13PM +0300, Sergey Miroshnichenko wrote:
>> When movable BARs are enabled, the PCI subsystem at first releases
>> all the bridge windows and then performs an attempt to assign new
>> requested resources and re-assign the existing ones.
> 
> s/performs an attempt/attempts/
> 
> I guess "new requested resources" means "resources to newly hotplugged
> devices"?
> 

Yes, that's exactly what I've tried to express :) Will rephrase that in v5.

>> If a hotplugged device gets its resources first, there could be no
>> space left to re-assign resources of already working devices, which
>> is unacceptable. If this happens, this patch marks one of the new
>> devices with the new introduced flag PCI_DEV_IGNORE and retries the
>> resource assignment.
>>
>> This patch adds a new res_mask bitmask to the struct pci_dev for
>> storing the indices of assigned resources.
>>
>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  drivers/pci/bus.c       |   5 ++
>>  drivers/pci/pci.h       |  11 +++++
>>  drivers/pci/probe.c     | 100 +++++++++++++++++++++++++++++++++++++++-
>>  drivers/pci/setup-bus.c |  15 ++++++
>>  include/linux/pci.h     |   1 +
>>  5 files changed, 130 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 5cb40b2518f9..a9784144d6f2 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -311,6 +311,11 @@ void pci_bus_add_device(struct pci_dev *dev)
>>  {
>>  	int retval;
>>  
>> +	if (pci_dev_is_ignored(dev)) {
>> +		pci_warn(dev, "%s: don't enable the ignored device\n", __func__);
>> +		return;
> 
> I'm not sure about this.  Even if we're unable to assign space for all
> the device's BARs, it still should respond to config accesses, and I
> think it should show up in sysfs and lspci.
> 

I agree, that would be better.

Also, this patch introduces a new issue to think about: how to recover BARs for such
devices when their neighbors was removed and it's enough space now.

>> +	}
>> +
>>  	/*
>>  	 * Can not put in pci_device_add yet because resources
>>  	 * are not assigned yet for some devices.
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index e06e8692a7b1..56b905068ac5 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -366,6 +366,7 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>>  
>>  /* pci_dev priv_flags */
>>  #define PCI_DEV_ADDED 0
>> +#define PCI_DEV_IGNORE 1
>>  
>>  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>>  {
>> @@ -377,6 +378,16 @@ static inline bool pci_dev_is_added(const struct pci_dev *dev)
>>  	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
>>  }
>>  
>> +static inline void pci_dev_ignore(struct pci_dev *dev, bool ignore)
>> +{
>> +	assign_bit(PCI_DEV_IGNORE, &dev->priv_flags, ignore);
>> +}
>> +
>> +static inline bool pci_dev_is_ignored(const struct pci_dev *dev)
>> +{
>> +	return test_bit(PCI_DEV_IGNORE, &dev->priv_flags);
>> +}
>> +
>>  #ifdef CONFIG_PCIEAER
>>  #include <linux/aer.h>
>>  
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 692752c71f71..62f4058a001f 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -3248,6 +3248,23 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
>>  	return max;
>>  }
>>  
>> +static unsigned int pci_dev_res_mask(struct pci_dev *dev)
>> +{
>> +	unsigned int res_mask = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
>> +		struct resource *r = &dev->resource[i];
>> +
>> +		if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
>> +			continue;
>> +
>> +		res_mask |= (1 << i);
>> +	}
>> +
>> +	return res_mask;
>> +}
>> +
>>  static void pci_bus_rescan_prepare(struct pci_bus *bus)
>>  {
>>  	struct pci_dev *dev;
>> @@ -3257,6 +3274,8 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>>  		struct pci_bus *child = dev->subordinate;
>>  
>> +		dev->res_mask = pci_dev_res_mask(dev);
>> +
>>  		if (child) {
>>  			pci_bus_rescan_prepare(child);
>>  		} else if (dev->driver &&
>> @@ -3318,6 +3337,84 @@ static void pci_setup_bridges(struct pci_bus *bus)
>>  		pci_setup_bridge(bus);
>>  }
>>  
>> +static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *dev;
>> +
>> +	if (!bus)
>> +		return NULL;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		struct pci_bus *child_bus = dev->subordinate;
>> +
>> +		if (!pci_dev_is_added(dev) && !pci_dev_is_ignored(dev))
>> +			return dev;
>> +
>> +		if (child_bus) {
>> +			struct pci_dev *next_new_dev;
>> +
>> +			next_new_dev = pci_find_next_new_device(child_bus);
>> +			if (next_new_dev)
>> +				return next_new_dev;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static bool pci_bus_validate_resources(struct pci_bus *bus)
> 
> The name of this function should tell us what the return value means.
> Just from the name "pci_bus_validate_resources", I can't tell whether we
> call it for side-effects, or whether true or false indicates success.
> 

Sure, now I realize this too. Would the pci_bus_check_all_bars_reassigned() be better choice?

>> +{
>> +	struct pci_dev *dev;
>> +	bool ret = true;
>> +
>> +	if (!bus)
>> +		return false;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		struct pci_bus *child = dev->subordinate;
>> +		unsigned int res_mask = pci_dev_res_mask(dev);
>> +
>> +		if (pci_dev_is_ignored(dev))
>> +			continue;
>> +
>> +		if (dev->res_mask & ~res_mask) {
>> +			pci_err(dev, "%s: Non-re-enabled resources found: 0x%x -> 0x%x\n",
>> +				__func__, dev->res_mask, res_mask);
> 
> I don't think __func__ really tells users anything useful, so I would
> just omit them.  Searching for the text of the message is almost as
> good.
> 

Ok, I'll drop __func__'s.

Serge

>> +			ret = false;
>> +		}
>> +
>> +		if (child && !pci_bus_validate_resources(child))
>> +			ret = false;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void pci_reassign_root_bus_resources(struct pci_bus *root)
>> +{
>> +	do {
>> +		struct pci_dev *next_new_dev;
>> +
>> +		pci_bus_release_root_bridge_resources(root);
>> +		pci_assign_unassigned_root_bus_resources(root);
>> +
>> +		if (pci_bus_validate_resources(root))
>> +			break;
>> +
>> +		next_new_dev = pci_find_next_new_device(root);
>> +		if (!next_new_dev) {
>> +			dev_err(&root->dev, "%s: failed to re-assign resources even after ignoring all the hotplugged devices\n",
>> +				__func__);
>> +			break;
>> +		}
>> +
>> +		dev_warn(&root->dev, "%s: failed to re-assign resources, disable the next hotplugged device %s and retry\n",
>> +			 __func__, dev_name(&next_new_dev->dev));
>> +
>> +		pci_dev_ignore(next_new_dev, true);
>> +	} while (true);
>> +}
>> +
>>  /**
>>   * pci_rescan_bus - Scan a PCI bus for devices
>>   * @bus: PCI bus to scan
>> @@ -3341,8 +3438,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
>>  
>>  		max = pci_scan_child_bus(root);
>>  
>> -		pci_bus_release_root_bridge_resources(root);
>> -		pci_assign_unassigned_root_bus_resources(root);
>> +		pci_reassign_root_bus_resources(root);
>>  
>>  		pci_setup_bridges(root);
>>  		pci_bus_rescan_done(root);
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 36a1907d9509..551108f48df7 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -131,6 +131,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>>  {
>>  	int i;
>>  
>> +	if (pci_dev_is_ignored(dev))
>> +		return;
>> +
>>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>>  		struct resource *r;
>>  		struct pci_dev_resource *dev_res, *tmp;
>> @@ -181,6 +184,9 @@ static void __dev_sort_resources(struct pci_dev *dev,
>>  {
>>  	u16 class = dev->class >> 8;
>>  
>> +	if (pci_dev_is_ignored(dev))
>> +		return;
>> +
>>  	/* Don't touch classless devices or host bridges or ioapics.  */
>>  	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
>>  		return;
>> @@ -284,6 +290,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
>>  	int idx;
>>  
>>  	list_for_each_entry(dev_res, head, list) {
>> +		if (pci_dev_is_ignored(dev_res->dev))
>> +			continue;
>> +
>>  		res = dev_res->res;
>>  		idx = res - &dev_res->dev->resource[0];
>>  		if (resource_size(res) &&
>> @@ -991,6 +1000,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>>  		int i;
>>  
>> +		if (pci_dev_is_ignored(dev))
>> +			continue;
>> +
>>  		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>>  			struct resource *r = &dev->resource[i];
>>  			resource_size_t r_size;
>> @@ -1353,6 +1365,9 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
>>  	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
>>  
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		if (pci_dev_is_ignored(dev))
>> +			continue;
>> +
>>  		pdev_assign_fixed_resources(dev);
>>  
>>  		b = dev->subordinate;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 3d52f5538282..26aa59cb6220 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -369,6 +369,7 @@ struct pci_dev {
>>  	 */
>>  	unsigned int	irq;
>>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
>> +	unsigned int	res_mask;		/* Bitmask of assigned resources */
>>  
>>  	bool		match_driver;		/* Skip attaching driver */
>>  
>> -- 
>> 2.20.1
>>
