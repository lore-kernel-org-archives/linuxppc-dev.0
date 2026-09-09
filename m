Return-Path: <linuxppc-dev+bounces-26911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950CFC79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 09:52:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfx1y5R0fz2yql;
	Wed, 09 Sep 2026 19:52:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788947574;
	cv=none; b=AWj3iyHcrW9fb8C8V01EJP+YuKM+9VWfHpbBs0ip1zqfHPh13psdG78lUIo7v7wZsbrtciwOlHv61Hlmj+3SmAha4gawo9L3tWtWYWXS+GXhOqNG3uD2AHwo9l6zjgIk6n9xYWkdPQmstYp+Kwa9fMDtUkP6ps/vjTocqZ5HTtKzOx9D9S6vFZnUnf/On8/R6yQdGyxhRh1J+ppLLpzjioN8zztGcJgSEqfmnDSb6LPfmCo3x0L5GoLmUWEmBHwPXbpE1bkWKP/iKNvFH6b2xf1ROtuoGkhOtwWwyWra9ALYkvlMMwsVo7G1CAjoDSJuJlgFFP9Ukelt8E4sj2pXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788947574; c=relaxed/relaxed;
	bh=4G4Opcw4JTj+bR17mIkz7iPg8GCDaNehmF4Lg6ID+HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0x6i9jx578b8UGiuncyP8jKfiR5oD8rYkFwyXFqUJrcun+whjCG+aAYfALUWL3Xc74oAzDNQx/+0eGL9II7XOHYlnzVm2/eNLNLN09h6AbXbx8SSD0VapTRfWGOHJmztjLLNX9U/4IMlA2NCM+4rjL/+KcVJ+A/xQ2ARaX7OcykzlNLO8nXuQ9Z0lCWbj5uca2J7Vv+fjQSJJg7Kg7d6etu6CtNigndVkRr5Dhj4Ze/R+ri2q34CUFBlhm/NjO6aDIt5futZ1TTy37/fGjMqAGQ5ebwqooEsaWvwwey3yafXjImFyNFeLmZrk/EoVK8iA/+ezOPKG26yjdkblasrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ssgK1avo; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ssgK1avo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfx1x5rkBz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 19:52:52 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1Ucb2262516
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2026 09:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4G4Opc
	w4JTj+bR17mIkz7iPg8GCDaNehmF4Lg6ID+HY=; b=ssgK1avooyPQyacxp9W7Az
	cAKscIGCJqgY2kGQA1rRRgA5qKoVWZZ/PdLF87+5ydX3nyXWueQ0MMnWunME7a7z
	IGHxfyQnUSjTDKnVN8Fw+49QxgZkWsuklSnXJS6YiAKK/ZE3v3kWeViW0pRzhCBV
	MHAZck3dhDVlJUN8I/kDuKEYYyF2NW2zXsK3dXbsOALnGvJpq7Aw+80FBFOKft36
	zhdc8MCEncRkcSQiiDMcRqRJRXdicyx/j6d0v/J5+wNyrsMDH9+L81GJWHfJI06E
	UE3PJj9QTb/Gvte+/0Caa5VsOKIX5LrBR9jRYHCmyyJj83bVbvWuggFJiaMvZAaA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkw2r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 09:52:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6899fJG2021114
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2026 09:52:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymghcvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 09:52:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6899qmiL2294284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 09:52:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D5D55805C;
	Wed,  9 Sep 2026 09:52:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1836258054;
	Wed,  9 Sep 2026 09:52:46 +0000 (GMT)
Received: from [9.61.40.182] (unknown [9.61.40.182])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 09:52:45 +0000 (GMT)
Message-ID: <d353a67a-cbda-467a-9c6b-f2770b34d1ae@linux.ibm.com>
Date: Wed, 9 Sep 2026 15:22:44 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] error path improvement in dlpar add
To: wenxiong@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, haren@linux.ibm.com, tyreld@linux.ibm.com
References: <20260204223844.11441-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260204223844.11441-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfXwCwwg6UTtGM3
 v+qgqsV4UgmujrAgTkha2843YTZ3v6GdEBV2lk4yQCiCRDlM2av0airHG+SmJma/lHXvKFi+V/E
 BKevwrYOXK3n748qOeKl8Qjuw4P+Cts=
X-Proofpoint-ORIG-GUID: 33Js4tC3NKeRpJVF24NmJ5o-X9jdSUW6
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa12c72 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1QeXIFyxU9C7ivriDU0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfXzgHq6Cc4jJDO
 lTJTgHSgXLtp3i7ecPVHTWXMaPTQ5jiIyqIEALaV6Fg3AmDvgxyJhBNc1dFGhKohEXRr0PB1la3
 jMMODHTbqvqYeuvS6JDAnH8cqHFGZtVugHmjGa/heWKUHYlYLIviJIYcmXsQMzBWHwec3/hmIy5
 S1/wjgmYpYCKMA5am7qlEpu26XBfFnaiN6uPqUqPnXU0pSBb2o7wqT2ImymWtH3OzpsPWvYZdN7
 5e/ks3jUqxxlypTrHSZdwT6rLysnCpqg2TKzYvGsojC0AqfhgobTw7pxBBRJ238kJkClp0t+VfX
 8flwxRCLHPq2ntY2QU/USAqH7SMyBJ6gTxNC7+A6T1+LZEvcV2N5frx9yjL6yzMcF3xF/qy5T6F
 orPzSMpoQMxSQO1wVBSjV//7wIjBDtwX4Sode5PllOxeA4LTjYK/mnFCzOkiHKGAp5PSvE0f+LP
 pk5OG126hF5LaUl/17A==
X-Proofpoint-GUID: 33Js4tC3NKeRpJVF24NmJ5o-X9jdSUW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090106

On 2/5/26 4:08 AM, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> When doing a dlpar adding a device back, expect not loading device driver
> if claiming pci resource failed.
> 
> Validating PHB DLPAR capability...yes.
> [ 4928.798012] pci_bus 0187:c0: root bus resource [bus c0-ff]
> [ 4928.798038] pci 0187:c0:00.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
> [ 4928.815867] pci 0187:c0:00.0: BAR 0 [mem 0xb0020000-0xb0027fff 64bit]: can't claim; no compatible bridge window
> 
> ---> Expect to exit if claiming resources fails(BAR0)
> 
> [ 4928.815899] pci 0187:c0:00.0: ROM [mem 0xb0000000-0xb001ffff]: can't claim; no compatible bridge window
> 
> --->Expect to exit if claiming resources fails(ROM), don't load device
> driver anymore, showed "dlpar add failed"
> 
> [ 4928.815913] pci 0187:c0:00.0: ROM [mem 0x40000000000-0x4000001ffff]: assigned
> [ 4928.815923] pci 0187:c0:00.0: BAR 0 [mem 0x40800000000-0x40800007fff 64bit]: assigned
> [ 4928.816220] pci 0187:c0:00.0: BAR 0: error updating (0x00000004 != 0xffffffff)
> [ 4928.816364] pci 0187:c0:00.0: BAR 0: error updating (high 0x00060238 != 0xffffffff)
> [ 4928.816839] pci 0187:c0:00.0: ibm,query-pe-dma-windows(53) b00000 8000000 20000187 returned -3, lb=0 ps=0 wn=0
> [ 4928.816855] pci 0187:c0:00.0: spapr_tce_init_table_group: query_ddw failed
> [ 4928.816871] pci 0187:c0:00.0: Adding to iommu group 1
> [ 4928.816952] pci 0187:c0:00.0: of_irq_parse_pci: no interrupt-map found, INTx interrupts not available
> [ 4928.818135] nvme 0187:c0:00.0: ibm,query-pe-dma-windows(53) b00000 8000000 20000187 returned -3, lb=0 ps=0 wn=0
> [ 4928.818284] nvme nvme1: pci function 0187:c0:00.0
> [ 4928.819321] rpaphp: Slot [U78DB.ND0.WZS08E2-P1-C7] registered
> [ 4928.819338] rpadlpar_io: slot PHB 391 added
> 
> With adding error path checking, didn't load the device driver anymore
> if claiming resources failed.
> 
> Validating PHB DLPAR capability...yes.
> [  260.414453] PCI host bridge /pci@800000020000187  ranges:
> [  260.414473]  MEM 0x0000040000000000..0x0000040007ffffff -> 0x00000000b8000000
> [  260.414480]  MEM 0x0000040800000000..0x0000040fffffffff -> 0x0006023800000000
> [  260.414915] PCI host bridge to bus 0187:c0
> [  260.414922] pci_bus 0187:c0: root bus resource [mem 0x40000000000-0x40007ffffff] (bus address [0xb8000000-0xbfffffff])
> [  260.414929] pci_bus 0187:c0: root bus resource [mem 0x40800000000-0x40fffffffff 64bit] (bus address [0x6023800000000-0x6023fffffffff])
> [  260.414936] pci_bus 0187:c0: root bus resource [bus c0-ff]
> [  260.414948] pci 0187:c0:00.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
> [  260.423439] pci 0187:c0:00.0: BAR 0 [mem 0xb0020000-0xb0027fff 64bit]: can't claim; no compatible bridge window
> [  260.423463] after pci_cliam_Resource=-22   ----> pci_claim_resources fails.
> 
> [  260.423471] rpadlpar_io: slot PHB 391 added failed rc=-5  -----> added failed.
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
> Reviewed-by: Haren Myneni <haren@linux.ibm.com>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/pci.h             |  4 ++--
>   arch/powerpc/kernel/pci-common.c           | 23 +++++++++++++++++-----
>   arch/powerpc/kernel/pci-hotplug.c          |  5 ++++-
>   arch/powerpc/platforms/pseries/pci_dlpar.c |  3 ++-
>   drivers/pci/hotplug/rpadlpar_core.c        |  7 ++++++-
>   5 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index 46a9c4491ed0..ebeb912a92bf 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -86,9 +86,9 @@ extern void pci_adjust_legacy_attr(struct pci_bus *bus,
>   				   enum pci_mmap_state mmap_type);
>   #define HAVE_PCI_LEGACY	1
>   
> -extern void pcibios_claim_one_bus(struct pci_bus *b);
> +extern int pcibios_claim_one_bus(struct pci_bus *b);
>   
> -extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
> +extern int pcibios_finish_adding_to_bus(struct pci_bus *bus);
>   
>   extern void pcibios_resource_survey(void);
>   
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index eac84d687b53..b16f43c7f02e 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1446,10 +1446,11 @@ void __init pcibios_resource_survey(void)
>    * rest of the code later, for now, keep it as-is as our main
>    * resource allocation function doesn't deal with sub-trees yet.
>    */
> -void pcibios_claim_one_bus(struct pci_bus *bus)
> +int pcibios_claim_one_bus(struct pci_bus *bus)
>   {
>   	struct pci_dev *dev;
>   	struct pci_bus *child_bus;
> +	int ret = 0;
>   
>   	list_for_each_entry(dev, &bus->devices, bus_list) {
>   		struct resource *r;
> @@ -1462,15 +1463,20 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
>   			pr_debug("PCI: Claiming %s: Resource %d: %pR\n",
>   				 pci_name(dev), i, r);
>   
> -			if (pci_claim_resource(dev, i) == 0)
> +			ret = pci_claim_resource(dev, i);
> +			if (ret == 0)
>   				continue;
> +			else
> +				return ret;
>   
This looks incorrect. With this change we would always skip
pci_claim_bridge_resource(). In case pci_claim_resource() fails, the
existing fallback is to try pci_claim_bridge_resource(). So rather than
returning immediately after pci_claim_resource() fails, I think we
should preserve this fallback and propagate the failure only if the
bridge-resource claim also fails.

There is also another issue to handle: if the fallback
pci_claim_bridge_resource() fails, we may have already successfully
claimed resources earlier in this traversal. Since the caller now
treats this as an error and aborts adding the bus, we need to make sure
those resources are properly rolled back/cleaned up before returning
the failure.
>   			pci_claim_bridge_resource(dev, i);
>   		}
>   	}
>   
>   	list_for_each_entry(child_bus, &bus->children, node)
> -		pcibios_claim_one_bus(child_bus);
> +		ret = pcibios_claim_one_bus(child_bus);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
>   
> @@ -1481,14 +1487,19 @@ EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
>    * added to a bus, this include calling it for a PHB that is just
>    * being added
>    */
> -void pcibios_finish_adding_to_bus(struct pci_bus *bus)
> +int pcibios_finish_adding_to_bus(struct pci_bus *bus)
>   {
> +	int ret = 0;
> +
>   	pr_debug("PCI: Finishing adding to hotplug bus %04x:%02x\n",
>   		 pci_domain_nr(bus), bus->number);
>   
>   	/* Allocate bus and devices resources */
>   	pcibios_allocate_bus_resources(bus);
> -	pcibios_claim_one_bus(bus);
> +	ret = pcibios_claim_one_bus(bus);
> +	if (ret)
> +		return ret;
> +
>   	if (!pci_has_flag(PCI_PROBE_ONLY)) {
>   		if (bus->self)
>   			pci_assign_unassigned_bridge_resources(bus->self);
> @@ -1498,6 +1509,8 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
>   
>   	/* Add new devices to global lists.  Register in proc, sysfs. */
>   	pci_bus_add_devices(bus);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
>   
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 6f444d0822d8..133ce03fdd82 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -140,6 +140,7 @@ void pci_hp_add_devices(struct pci_bus *bus)
>   	struct pci_dev *dev;
>   	struct pci_controller *phb;
>   	struct device_node *dn = pci_bus_to_OF_node(bus);
> +	int ret = 0;
>   
>   	if (!dn)
>   		return;
> @@ -176,6 +177,8 @@ void pci_hp_add_devices(struct pci_bus *bus)
>   		for_each_pci_bridge(dev, bus)
>   			max = pci_scan_bridge(bus, dev, max, 1);
>   	}
> -	pcibios_finish_adding_to_bus(bus);
> +	ret = pcibios_finish_adding_to_bus(bus);
> +	if (ret)
> +		pr_err("Unable to add hotplug pci device!\n");

I think, it would be useful to include the PCI bus/domain in this error message,
so that we can identify which hotplug bus failed.

>   }
>   EXPORT_SYMBOL_GPL(pci_hp_add_devices);
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index 8c77ec7980de..2b78faba40f6 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -58,7 +58,8 @@ struct pci_controller *init_phb_dynamic(struct device_node *dn)
>   		pseries_eeh_init_edev_recursive(PCI_DN(dn));
>   
>   	pcibios_scan_phb(phb);
> -	pcibios_finish_adding_to_bus(phb->bus);
> +	if (pcibios_finish_adding_to_bus(phb->bus))
> +		return NULL;
> 
Here as well, when pcibios_finish_adding_to_bus() fails, I think we
need to clean up the PHB before returning NULL. pcibios_scan_phb() has
already created/scanned the PCI bus hierarchy, so simply returning NULL
may leave the partially initialized PHB and scanned PCI devices behind.

Overall I think the intent is correct, however the commit message
should also be tightened up a bit to make the problem and the expected
behavior more descriptive.

Thanks,
--Nilay


