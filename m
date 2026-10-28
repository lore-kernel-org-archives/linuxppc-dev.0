Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C9606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QQ1aOpqD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsfZ2DDsz2xlZ;
	Wed, 28 Oct 2026 14:04:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156694;
	cv=none; b=XHW8f7ujPZcFxAN0binSh8Ydya7y138cF6SielJa7KyVnNDX0RvJuqXY51bxE7rw7VjVqqoiJEHp2KFNN5BNCQ/MZuQ5549bn9DCYjlGLewEAhVQV27a4+/zerWDBYkT5JFA+ZSj94Ll/OX75EKMfAYmDx8iqFooP0kqfIgnD0aL5JC/85vJpwszz8Dy4hafx9wM8cDDsdapb0EmzyjxfnxtABaWI4LbZp/Svqyrl3kySuBvNLA3noOlzPyQIEwIPWPFdQ4fTBIcWp2V7oT2hmSrV+EYt2urWett77aH9UuzCKjWilM8GiFHjAdfQOQqvedx6cpSEGM0nWK4n/MI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156694; c=relaxed/relaxed;
	bh=QmKBIsPj275zjC+RHeRaYLF2SPXRKuXi+F+O6Y1Ma/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjTb4qpqyrus8hHpy+HDvd8I58fhXd12SL6aaYsQ8V1yEj0S183aYtv7n7BC9sL/qQ/6WAXHV0wJidGRlDnCPUxVwD9AjSMuFm3EgEDVijhpuSYSDXkz9mZEIeRR2aAkGuFiX6S7LmENKMy7gUE1DXvxlLNRoqjPNeZ0OWT4lo/7FFJHuCqTd7i7wPqrTqNPH+6ZmVwvBNM16NbgnpKWVsd7iEMcHzImL30R2U9T2bukUleWxxPqmlTC7h4UX2jKoB9VJ/b+Sox80cwj4vgz3hM6HFN8IGJBOk1gvEkIQTBmKSiXsI4aX1HkGLzoSNyqOQ1ZMz1IzIWKz9M5579R0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QQ1aOpqD; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QQ1aOpqD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsfV4JhPz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:04:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=QmKBIsPj275zjC+RHeRaYLF2SPXRKuXi+F+O6Y1Ma/A=;
	b=QQ1aOpqDWE8FU3TPOhW+MfG6j6+N0eoK3n+xE4A/cpC2NORjs2103GBylGScI5
	q8c0cxRwAm6kYho2xTHspJS4gAcZRiDhhuVMJ/CBYYkW7Kvn3hy/IMDIL5HpB68D
	/SsVO2fsRmuU7tlU/QFtZKHwEc8PRZPRLuLQieOhufzIw=
Message-ID: <e89439cb-b4cc-44ca-99bd-977e4d659e47@163.com>
Date: Wed, 28 Oct 2026 11:04:11 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] PCI: dwc: Add pcie_cap field and caching helper
To: Shawn Lin <shawn.lin@rock-chips.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 jingoohan1@gmail.com
Cc: imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-2-18255117159@163.com>
 <80f85ae9-7162-4940-8dec-690bc00098b4@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <80f85ae9-7162-4940-8dec-690bc00098b4@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDnL4srZuFqgH73CA--.31342S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1rtF48GFWUGF4rAF4kXrb_yoW7Kw15p3
	yUtF1akFs8JrWav3W2v3W3JF1a9as3JFW7Jwn3Gw13Zr9xur1xKFy0yrWYkF17Crs2gw1j
	9r4jqa4xCrs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuwZcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7A23W2rhZi2d5QAA31
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 21:12, Shawn Lin wrote:
> Hi Hans,
> 
> 在 2026/10/27 星期二 20:28, Hans Zhang 写道:
>> The DWC PCIe core and its platform drivers repeatedly call
>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>> PCI Express Capability structure. Besides being verbose, that performs a
>> DBI read every time, including in paths that run repeatedly such as link
>> up polling, suspend/resume and interrupt handlers.
>>
>> Add a pcie_cap field to struct dw_pcie and a helper
>> dw_pcie_get_pcie_cap() that performs the lookup on first use and caches
>> the result for the subsequent calls.
>>
>> The lookup is deliberately done lazily, at the first place that needs the
>> offset, instead of at a fixed point during controller initialization.
>> This guarantees that the DBI read happens exactly when the open coded
>> dw_pcie_find_capability() call it replaces used to happen, so no DBI
>> access can be made before the controller clocks, resets and power are
> 
> 
> With the controller inaccessible (clocks/power gated), what a DBI
> read returns is platform dependent, most integrations just hang the
> accessing CPU, like Rockchip's SoCs, others might return zero or
> garbage. Zero self-heals as the commit message describes, but a garbage 
> non-zero lookup would now be cached indefinitely, so every later caller
> would use a bogus offset?
> 
> Perhaps the "TX Interface Progression Detection Features" of dwc IP
> could help return a dedicated value? I don't know, so I need to check
> it internally. I will get back to you later.

Hi,

Thanks for the review.


You are right that the cache must not turn a bogus value into a permanent
one. Some details and one change in v5:

- dw_pcie_get_pcie_cap() is only called at the sites that previously
   called dw_pcie_find_capability() directly, so this series does not add
   or move a DBI access. It does not try to fix the "DBI accessed while
   the controller is inaccessible" problem; that behavior is platform
   specific and pre-existing.
- dw_pcie_find_capability() already rejects offsets below the standard
   header, unaligned offsets, and entries whose capability ID is not
   PCI_CAP_ID_EXP, so a bogus value has to look like a valid capability
   entry to be returned at all.
- To make sure that a transient bogus read cannot stick anyway, v5 only
   caches the offset after the capability ID has been read back at that
   offset. If the read-back does not confirm PCI_CAP_ID_EXP, the offset is
   still used for the current access (same as the open coded search
   before), but it is not cached, and the next call searches again - the
   same self-healing behavior as the zero/not-found case.

If the DWC IP has a reliable way to tell whether the core is accessible
(the "TX Interface Progression Detection" feature you mentioned), that
would be even better than validating the value. I would be glad to use it
if you can share the details; it probably deserves a separate patch so
that all DBI accesses can be guarded, not only this lookup.

Best regards,
Hans

> 
> 
>> enabled. This matters for endpoint controllers such as qcom-ep and
>> tegra194, where DBI is only accessible after PERST# is deasserted, and it
>> also means platform drivers do not have to call the helper from a
>> specific callback at the right time.
>>
>> The cached value is accessed with READ_ONCE()/WRITE_ONCE(), because the
>> first lookup may be triggered from different contexts, for example the
>> qcom-ep global IRQ and PERST# IRQ handlers. A concurrent lookup stores
>> the same value, so this race is benign.
>>
>> A return value of 0 means that the capability is not present. This
>> cannot happen on real DWC hardware, where the PCI Express Capability is
>> mandatory, so a negative result is not cached separately: it only causes
>> the search to be repeated, which does not affect correctness.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.h | 34 ++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/ 
>> pci/controller/dwc/pcie-designware.h
>> index 0735ae940924..fa31e8b763bc 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -592,6 +592,8 @@ struct dw_pcie {
>>        * use_parent_dt_ranges to true to avoid this warning.
>>        */
>>       bool            use_parent_dt_ranges;
>> +
>> +    u8            pcie_cap;    /* Offset of PCI_CAP_ID_EXP */
>>   };
>>   #define to_dw_pcie_from_pp(port) container_of((port), struct 
>> dw_pcie, pp)
>> @@ -830,6 +832,38 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct 
>> dw_pcie *pci)
>>       dw_pcie_writel_dbi(pci, reg, val);
>>   }
>> +/**
>> + * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
>> + * @pci: DWC instance
>> + *
>> + * The offset of the PCI Express Capability structure is read once from
>> + * the DBI configuration space on the first call and cached in
>> + * @pci->pcie_cap for the subsequent ones.
>> + *
>> + * The lookup is done lazily at the first place that actually needs the
>> + * offset, so the DBI read happens exactly when it used to happen before
>> + * caching was introduced, i.e. never before the controller's clocks,
>> + * resets and power are enabled.
>> + *
>> + * DWC PCIe controllers always implement the PCI Express Capability, 
>> so a
>> + * return value of 0 means that the hardware is not usable. Callers that
>> + * check the returned offset keep working, and the (never expected)
>> + * lookup is simply repeated on the next call.
>> + *
>> + * Return: the cached offset, or 0 if the capability is not present.
>> + */
>> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
>> +{
>> +    u8 cap = READ_ONCE(pci->pcie_cap);
>> +
>> +    if (!cap) {
>> +        cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +        WRITE_ONCE(pci->pcie_cap, cap);
>> +    }
>> +
>> +    return cap;
>> +}
>> +
>>   static inline int dw_pcie_start_link(struct dw_pcie *pci)
>>   {
>>       if (pci->ops && pci->ops->start_link)


