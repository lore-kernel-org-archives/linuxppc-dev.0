Return-Path: <linuxppc-dev+bounces-16138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF5FC44500
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 10:23:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxcbV5LhFz2yFm;
	Thu, 22 Jan 2026 21:23:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769077414;
	cv=none; b=mO9dHy2lLTB1Ra0ES/vSQeP5yWnYJ90gXI3JVlzWwMFynySvusno7j4js6b9J+fIcnwUAuleYAJTAY+UFce6WhyUnC+4Im2Y/ry5iX+0sJ/2EQbt3xEGCwsL5HW5Zdyk4cjR8UYBP1zvubOT9MFJFpCEMZ6t+4p3OTDhAM47eDgghPhCWMr87S092bknH08Caw4TF5Jrp4Gtxka0tEtaEhVoxnp1FgbYIP1DcJZbBDT1GoAqlWNoPonQHcW8sdEzNVPDH1GtbzEYn33HYNS8VoSPDBbe4LgZ7eLJp0oYqtnVdfOlNYZJ6kmXSPXE9+66rfqzcwZFRNpoopWnl2RLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769077414; c=relaxed/relaxed;
	bh=fm50/tGbng8CPrJ5pxlBGJVNYim53O0nEqjQ/KJUWQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOUcAzCrhltdLTav/FD2jDhncOzeyPWnTvSP4MVMs/2aOz4ppnEnfXUXcdt7bcpXMzxQsDlTylE1JPmU6Sakh9pmja//SBFzq2R+Vmld3JYXKeuMOV8pjWpcAcIz7WqR3ya2AQtqDl7OJHES3JCm1I+EbCR117qUTXxQ0PeThq0oNfWHiasx/oj3Zjes03hCrnwsPDCoeFvEmtKe4dPwUM0qXsThDZxqjq0sfWeuo+1gAvHSESAdoPg/3ikhr4t3pe+LimX2NAuARwLbN39w3CQcMJXhwf4XGX+LvDV+q9Fon1hYPnc2VYYeO/xQeBNRGQiu7riLlK8MzxwQaCgGlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (unknown [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxcbT2tZnz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 21:23:27 +1100 (AEDT)
Received: from [10.213.20.167] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABXZ85++nFpwkNDBg--.14326S2;
	Thu, 22 Jan 2026 18:22:56 +0800 (CST)
Message-ID: <8e0cae73-3ca0-47a8-8ac7-aa8edba3e0f9@iscas.ac.cn>
Date: Thu, 22 Jan 2026 18:22:54 +0800
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
Subject: Re: [PATCH v2 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Han Gao <gaohan@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>
References: <20260121233804.GA1221537@bhelgaas>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260121233804.GA1221537@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowABXZ85++nFpwkNDBg--.14326S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3GF15Cr48tryxAFy3twb_yoW8CFyxpa
	yDKa1qyrsYk3yUJrsFqw1UXF1jvFZYqayfGrWUK34Y9FnIvFnFyrySka47u3srXF1xGw10
	vF1Yya1UJFs09aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRVVbgUUUUU=
X-Originating-IP: [210.73.43.101]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 1/22/26 07:38, Bjorn Helgaas wrote:
> [+cc Thomas, thread at https://lore.kernel.org/r/20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn]
>
> On Wed, Jan 21, 2026 at 11:49:38AM +0800, Vivian Wang wrote:
>> Instead of a 32-bit/64-bit dichotomy, check the MSI address against
>> msi_addr_mask.
>>
>> This allows platforms with MSI doorbell above 32-bit address space to
>> work with devices without full 64-bit MSI address support, as long as
>> the doorbell is within addressable range of MSI of the device.
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>>
>> ---
>> v2: No changes
>> ---
>>  drivers/pci/msi/msi.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 48f5f03d1479..2ecbcd6c436a 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -321,14 +321,17 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>>  static int msi_verify_entries(struct pci_dev *dev)
>>  {
>>  	struct msi_desc *entry;
>> +	u64 address;
>>  
>>  	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>>  		return 0;
>>  
>>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>> -		if (entry->msg.address_hi) {
>> -			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
>> -				entry->msg.address_hi, entry->msg.address_lo);
>> +		address = (u64)entry->msg.address_hi << 32 |
>> +			  entry->msg.address_lo;
>> +		if (address & ~dev->msi_addr_mask) {
>> +			pci_err(dev, "arch assigned 64-bit MSI address %llx above device MSI address mask %llx\n",
> Use %#llx so it's clear these addresses are hex.  The previous message
> did that, not sure why you dropped it.

Thanks for catching. I misunderstood the purpose of the original message
formatting.

I will fix this in v3.

Vivian "dramforever" Wang


