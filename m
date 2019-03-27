Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:17:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24435206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="qlEJgXST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24435206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tvp83P4dzDqQD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 04:17:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="qlEJgXST"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TvmS4pLjzDq9D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 04:16:24 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id AC00641A44;
 Wed, 27 Mar 2019 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:subject:subject:received
 :received:received; s=mta-01; t=1553706980; x=1555521381; bh=QWA
 HqCqDmbWsBpSOBa7xiV2wNZFRxir9vNiinpxdU14=; b=qlEJgXSTOp3SGrOOKIE
 /kVy2FXfnw2M29Y92keNi3yd6hl7m3YUUeASfZEgYg7YbkUdKhSnId9lMnh6+xOh
 vIEanCKkVbQyKDGXBQ8CTuKiK3vfOFqZ9rZhMbLt+5Dro5Xb4yN6xCZe9XXcafW7
 rRUjhSZlYOZHxKpp8OV9K1Tg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZ8fkIxFbLmX; Wed, 27 Mar 2019 20:16:20 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 14BE041A3C;
 Wed, 27 Mar 2019 20:16:20 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Mar 2019 20:16:19 +0300
Subject: Re: [PATCH RFC v4 05/21] PCI: hotplug: Add a flag for the movable
 BARs feature
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-6-s.miroshnichenko@yadro.com>
 <20190326192455.GN24180@google.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <3d17312b-7c7b-3c42-5901-6a5dcf35aa0d@yadro.com>
Date: Wed, 27 Mar 2019 20:16:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190326192455.GN24180@google.com>
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

On 3/26/19 10:24 PM, Bjorn Helgaas wrote:
> On Mon, Mar 11, 2019 at 04:31:06PM +0300, Sergey Miroshnichenko wrote:
>> If a new PCIe device has been hot-plugged between the two active ones
>> without big enough gap between their BARs, 
> 
> Just to speak precisely here, a hot-added device is not "between" two
> active ones because the new device has zeros in its BARs.
> 
> BARs from different devices can be interleaved arbitrarily, subject to
> bridge window constraints, so we can really only speak about a *BAR*
> (not the entire device) being between two other BARs.
> 
> Also, I don't think there's anything here that is PCIe-specific, so we
> should talk about "PCI", not "PCIe".
> 

I agree, that should be rephrased. This patchset intends to solve the problem when a
bridge window is not big enough (or fragmented too much) to fit new BARs, and it can't be
expanded enough because blocked by "neighboring" BARs.

>> these BARs should be moved
>> if their drivers support this feature. The drivers should be notified
>> and paused during the procedure:
>>
>> 1)                 dev 8 (new)
>>                        |
>>                        v
>> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
>> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>>
>> 2)                             dev 8
>>                                  |
>>                                  v
>> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
>> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
>>
>>  3)
>>
>> .. |  dev 3  |  dev 3  |  dev 8  |  dev 8  |  dev 5  |  dev 7  |
>> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>>
>> Thus, prior reservation of memory regions by BIOS/bootloader/firmware
>> is not required anymore for the PCIe hotplug.
>>
>> The PCI_MOVABLE_BARS flag is set by the platform is this feature is
>> supported and tested, but can be overridden by the following command
>> line option:
>>     pcie_movable_bars={ off | force }
> 
> A chicken switch to turn this functionality off is OK, but I think it
> should be enabled by default.  There isn't anything about this that's
> platform-specific, is there?
> 

I'm a bit afraid to suppose that; I was once surprised that bus numbers can't be assigned
arbitrarily on some platforms [1], so probably there are some similar restrictions on BARs
too.

Was going to propose adding pci_add_flags(PCI_MOVABLE_BARS) into arch/.../init.c for
tested platforms, so there will be less upset people with their BARs suddenly broken. But
this logic can be reversed: pci_clear_flags(PCI_MOVABLE_BARS) for platforms where movable
BARs can't work.

Serge

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-September/178103.html

>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  7 ++++++
>>  drivers/pci/pci.c                             | 24 +++++++++++++++++++
>>  include/linux/pci.h                           |  2 ++
>>  3 files changed, 33 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 2b8ee90bb644..d40eaf993f80 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3417,6 +3417,13 @@
>>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>>  			all PCIe root ports use INTx for all services).
>>  
>> +	pcie_movable_bars=[PCIE]
>> +			Override the movable BARs support detection:
>> +		off
>> +			Disable even if supported by the platform
>> +		force
>> +			Enable even if not explicitly declared as supported
>> +
>>  	pcmv=		[HW,PCMCIA] BadgePAD 4
>>  
>>  	pd_ignore_unused
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 69898fe5255e..4dac49a887ec 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -139,6 +139,30 @@ static int __init pcie_port_pm_setup(char *str)
>>  }
>>  __setup("pcie_port_pm=", pcie_port_pm_setup);
>>  
>> +static bool pcie_movable_bars_off;
>> +static bool pcie_movable_bars_force;
>> +static int __init pcie_movable_bars_setup(char *str)
>> +{
>> +	if (!strcmp(str, "off"))
>> +		pcie_movable_bars_off = true;
>> +	else if (!strcmp(str, "force"))
>> +		pcie_movable_bars_force = true;
>> +	return 1;
>> +}
>> +__setup("pcie_movable_bars=", pcie_movable_bars_setup);
>> +
>> +bool pci_movable_bars_enabled(void)
>> +{
>> +	if (pcie_movable_bars_off)
>> +		return false;
>> +
>> +	if (pcie_movable_bars_force)
>> +		return true;
>> +
>> +	return pci_has_flag(PCI_MOVABLE_BARS);
>> +}
>> +EXPORT_SYMBOL(pci_movable_bars_enabled);
>> +
>>  /* Time to wait after a reset for device to become responsive */
>>  #define PCIE_RESET_READY_POLL_MS 60000
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index cb2760a31fe2..cbe661aff9f5 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -866,6 +866,7 @@ enum {
>>  	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
>>  	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
>>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
>> +	PCI_MOVABLE_BARS	= 0x00000080,	/* Runtime BAR reassign after hotplug */
>>  };
>>  
>>  /* These external functions are only available when PCI support is enabled */
>> @@ -1345,6 +1346,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>>  void pci_setup_bridge(struct pci_bus *bus);
>>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>>  					 unsigned long type);
>> +bool pci_movable_bars_enabled(void);
>>  
>>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
>> -- 
>> 2.20.1
>>
