Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A9C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:32:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8538A2146F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="nmXRMbxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8538A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tw6Y07SGzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 04:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="nmXRMbxj"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tw4S2hnjzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 04:30:16 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 77C0841A37;
 Wed, 27 Mar 2019 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:subject:subject:received
 :received:received; s=mta-01; t=1553707811; x=1555522212; bh=kSU
 9y6ZjfbrVlQ76vYI3yO++tQkgaT4bSitwn0LjxrM=; b=nmXRMbxjyp48gljeIhY
 Ad/PzGHGPucERBhyZYdM/GAEvz0aPESvN3Yva7c9lkYui3YAJ6Y6JHZYZM2bnE4N
 cAg2p3s70trOc2LK7g95TO2zLiZchU5dutAx19Ge7Rp9r3/fw5ueSGdJSOZ2vQF0
 XwtJmKWxh2Vl+Rr3e6qD8/uw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Stzs9-EdUjOG; Wed, 27 Mar 2019 20:30:11 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id CA55F41A0C;
 Wed, 27 Mar 2019 20:30:10 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Mar 2019 20:30:10 +0300
Subject: Re: [PATCH RFC v4 08/21] nvme-pci: Handle movable BARs
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-9-s.miroshnichenko@yadro.com>
 <20190326202055.GP24180@google.com>
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
Message-ID: <63989325-c1f8-9579-8405-56dc83751a3b@yadro.com>
Date: Wed, 27 Mar 2019 20:30:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326202055.GP24180@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux@yadro.com,
 Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/26/19 11:20 PM, Bjorn Helgaas wrote:
> [+cc Keith, Jens, Christoph, Sagi, linux-nvme, LKML]
> 
> On Mon, Mar 11, 2019 at 04:31:09PM +0300, Sergey Miroshnichenko wrote:
>> Hotplugged devices can affect the existing ones by moving their BARs.
>> PCI subsystem will inform the NVME driver about this by invoking
>> reset_prepare()+reset_done(), then iounmap()+ioremap() must be called.
> 
> Do you mean the PCI core will invoke ->rescan_prepare() and
> ->rescan_done() (as opposed to *reset*)?
> 

Yes, of course, sorry for the confusion!

These are new callbacks, so drivers can explicitly show their support of movable BARs, and
the PCI core can detect if they don't and note that the corresponding BARs can't be moved
for now.

>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  drivers/nvme/host/pci.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 92bad1c810ac..ccea3033a67a 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -106,6 +106,7 @@ struct nvme_dev {
>>  	unsigned int num_vecs;
>>  	int q_depth;
>>  	u32 db_stride;
>> +	resource_size_t current_phys_bar;
>>  	void __iomem *bar;
>>  	unsigned long bar_mapped_size;
>>  	struct work_struct remove_work;
>> @@ -1672,13 +1673,16 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>>  
>> -	if (size <= dev->bar_mapped_size)
>> +	if (dev->bar &&
>> +	    dev->current_phys_bar == pci_resource_start(pdev, 0) &&
>> +	    size <= dev->bar_mapped_size)
>>  		return 0;
>>  	if (size > pci_resource_len(pdev, 0))
>>  		return -ENOMEM;
>>  	if (dev->bar)
>>  		iounmap(dev->bar);
>> -	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
>> +	dev->current_phys_bar = pci_resource_start(pdev, 0);
>> +	dev->bar = ioremap(dev->current_phys_bar, size);
> 
> dev->current_phys_bar is different from pci_resource_start() in the
> case where the PCI core has moved the nvme BAR, but nvme has not yet
> remapped it.
> 
> I'm not sure it's worth keeping track of current_phys_bar, as opposed
> to always unmapping and remapping.  Is this a performance path?  I
> think there are advantages to always exercising the same code path,
> regardless of whether the BAR happened to be moved, e.g., if there's a
> bug in the "BAR moved" path, it may be a heisenbug because whether we
> exercise that path depends on the current configuration.
> 
> If you do need to cache current_phys_bar, maybe this, so it's a little
> easier to see that you're not changing the ioremap() itself:
> 
>   dev->bar = ioremap(pci_resource_start(pdev, 0), size);
>   dev->current_phys_bar = pci_resource_start(pdev, 0);
> 

Oh, I see now. Rescan is rather a rare event, and unconditional remapping is simpler, so a
bit more resistant to bugs.

>>  	if (!dev->bar) {
>>  		dev->bar_mapped_size = 0;
>>  		return -ENOMEM;
>> @@ -2504,6 +2508,8 @@ static void nvme_reset_work(struct work_struct *work)
>>  	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
>>  		goto out;
>>  
>> +	nvme_remap_bar(dev, db_bar_size(dev, 0));
> 
> How is this change connected to rescan?  This looks reset-related.
> 

Thanks for catching that! This has also slipped form early stage of this pathset, when
reset_done() (which is rescan_done() now) just initiated an NVME reset.

Best regards,
Serge

>>  	/*
>>  	 * If we're called to reset a live controller first shut it down before
>>  	 * moving on.
>> @@ -2910,6 +2916,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
>>  	flush_work(&dev->ctrl.reset_work);
>>  }
>>  
>> +void nvme_rescan_prepare(struct pci_dev *pdev)
>> +{
>> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
>> +
>> +	nvme_dev_disable(dev, false);
>> +	nvme_dev_unmap(dev);
>> +	dev->bar = NULL;
>> +}
>> +
>> +void nvme_rescan_done(struct pci_dev *pdev)
>> +{
>> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
>> +
>> +	nvme_dev_map(dev);
>> +	nvme_reset_ctrl_sync(&dev->ctrl);
>> +}
>> +
>>  static const struct pci_error_handlers nvme_err_handler = {
>>  	.error_detected	= nvme_error_detected,
>>  	.slot_reset	= nvme_slot_reset,
>> @@ -2974,6 +2997,8 @@ static struct pci_driver nvme_driver = {
>>  	},
>>  	.sriov_configure = pci_sriov_configure_simple,
>>  	.err_handler	= &nvme_err_handler,
>> +	.rescan_prepare	= nvme_rescan_prepare,
>> +	.rescan_done	= nvme_rescan_done,
>>  };
>>  
>>  static int __init nvme_init(void)
>> -- 
>> 2.20.1
>>
