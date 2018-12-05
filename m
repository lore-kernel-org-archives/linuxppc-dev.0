Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B272AC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 06:20:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF76D206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 06:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nM1L4mBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF76D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438pWP3Z0DzDqr6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 17:20:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nM1L4mBo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nM1L4mBo"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438pSZ3l6DzDqpg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 17:18:06 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id 17so8543537pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 22:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DGokyv1niXnGFTPg8KGTLQVn8Pv5B1Y2lLV9MlJJpCk=;
 b=nM1L4mBobV1xVpvzInmQc+lUh6vsmrnAGt+5DZ5/gIJPAaW2z6UNdGlBDDgaMlby3m
 wxX02jEoaMrjOKr0mCdtXSgGeOieCc/cpdzEX/AiAavqAA/Z2Y6+ZcR74aXJqt7V34To
 UD7+EHohKHET5aOa9nc082S2CQby8NxmJsaOhUZ+AOztT0QJE2CcesmFZ0N9LNWMhiEL
 0d6UpINpOezgte/9qqYET1hw6Q7obGyAAOOyXTORAoS0/lYD/L3XvvNO1h/AIr7T/QpX
 HG8yeejJ0wJ4PRMFpNSczgPbdlyOV/KUVlZ6Xoadj1Fq8U0BPoZ0XEZ4orwVqaF2jOZh
 wxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DGokyv1niXnGFTPg8KGTLQVn8Pv5B1Y2lLV9MlJJpCk=;
 b=nRmlcdhlGuMKPqEtTFUuaiAz6r3Q/m65u+Ud7JHDI6dXrwnGqc+INNqlFy9tgFEZGF
 GUPb8z/grqs11pEEHs9SJwyl8n99jAP4++nvixz1fvlG9og5lFce7+g24OeNf7POC2d/
 3XPzWNSnwHArjOGqy837Z8t22cjAq6sXrzNYowagkmj9OgsKbTM5q6ztJCNLPd3lsEYr
 8O357P0hQY32f6Ewm1cIsgQsDnMgdqDsdctlLo45EmaD1aFYGdSYoIeVfteqlIkfBa/Z
 VohAEM+qvXVeJsiVUDo8YHZ+BYOTu8rDpq1gIa2lamrCORFXqR7ci12c0Pzakw1hypNE
 GPjQ==
X-Gm-Message-State: AA+aEWZNJgavlzIsU18ZrK0sy3J5rRCK6sb+Euu+u879LpkjdieYD5Na
 jNMOMq/9xVZbsnTTQ2CoaIZMWg==
X-Google-Smtp-Source: AFSGD/WZkDZBLscgbnyY11YN5y0D3Ig55gBgLOXNLrX4tGmsviMYje35WajbnGhW62qth0aYyDFBvw==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr19351668pgn.162.1543990684235; 
 Tue, 04 Dec 2018 22:18:04 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id w3sm22818880pge.8.2018.12.04.22.17.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 22:18:03 -0800 (PST)
Subject: Re: [PATCH kernel v4 04/19] powerpc/powernv: Move npu struct from
 pnv_phb to pci_controller
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-5-aik@ozlabs.ru> <20181205051424.GB768@umbus.fritz.box>
 <e10bc868-154e-285c-05e9-906b7027dfaf@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <05cb6d97-9949-1d90-33e1-8d5cc1bb83f2@ozlabs.ru>
Date: Wed, 5 Dec 2018 17:17:57 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <e10bc868-154e-285c-05e9-906b7027dfaf@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 05/12/2018 16:47, Alexey Kardashevskiy wrote:
> 
> 
> On 05/12/2018 16:14, David Gibson wrote:
>> On Fri, Nov 23, 2018 at 04:52:49PM +1100, Alexey Kardashevskiy wrote:
>>> The powernv PCI code stores NPU data in the pnv_phb struct. The latter
>>> is referenced by pci_controller::private_data. We are going to have NPU2
>>> support in the pseries platform as well but it does not store any
>>> private_data in in the pci_controller struct; and even if it did,
>>> it would be a different data structure.
>>>
>>> This makes npu a pointer and stores it one level higher in
>>> the pci_controller struct.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>> Changes:
>>> v4:
>>> * changed subj from "powerpc/powernv: Detach npu struct from pnv_phb"
>>> * got rid of global list of npus - store them now in pci_controller
>>> * got rid of npdev_to_npu() helper
>>> ---
>>>  arch/powerpc/include/asm/pci-bridge.h    |  1 +
>>>  arch/powerpc/platforms/powernv/pci.h     | 16 -----
>>>  arch/powerpc/platforms/powernv/npu-dma.c | 81 ++++++++++++++++++------
>>>  3 files changed, 64 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>> index 94d4490..aee4fcc 100644
>>> --- a/arch/powerpc/include/asm/pci-bridge.h
>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>>> @@ -129,6 +129,7 @@ struct pci_controller {
>>>  #endif	/* CONFIG_PPC64 */
>>>  
>>>  	void *private_data;
>>> +	struct npu *npu;
>>>  };
>>>  
>>>  /* These are used for config access before all the PCI probing
>>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>> index 2131373..f2d50974 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.h
>>> +++ b/arch/powerpc/platforms/powernv/pci.h
>>> @@ -8,9 +8,6 @@
>>>  
>>>  struct pci_dn;
>>>  
>>> -/* Maximum possible number of ATSD MMIO registers per NPU */
>>> -#define NV_NMMU_ATSD_REGS 8
>>> -
>>>  enum pnv_phb_type {
>>>  	PNV_PHB_IODA1		= 0,
>>>  	PNV_PHB_IODA2		= 1,
>>> @@ -176,19 +173,6 @@ struct pnv_phb {
>>>  	unsigned int		diag_data_size;
>>>  	u8			*diag_data;
>>>  
>>> -	/* Nvlink2 data */
>>> -	struct npu {
>>> -		int index;
>>> -		__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
>>> -		unsigned int mmio_atsd_count;
>>> -
>>> -		/* Bitmask for MMIO register usage */
>>> -		unsigned long mmio_atsd_usage;
>>> -
>>> -		/* Do we need to explicitly flush the nest mmu? */
>>> -		bool nmmu_flush;
>>> -	} npu;
>>> -
>>>  	int p2p_target_count;
>>>  };
>>>  
>>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>>> index 91d488f..7dd5c0e5 100644
>>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>>> @@ -327,6 +327,25 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>>>  	return gpe;
>>>  }
>>>  
>>> +/*
>>> + * NPU2 ATS
>>> + */
>>> +/* Maximum possible number of ATSD MMIO registers per NPU */
>>> +#define NV_NMMU_ATSD_REGS 8
>>> +
>>> +/* An NPU descriptor, valid for POWER9 only */
>>> +struct npu {
>>> +	int index;
>>> +	__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
>>> +	unsigned int mmio_atsd_count;
>>> +
>>> +	/* Bitmask for MMIO register usage */
>>> +	unsigned long mmio_atsd_usage;
>>> +
>>> +	/* Do we need to explicitly flush the nest mmu? */
>>> +	bool nmmu_flush;
>>> +};
>>> +
>>>  /* Maximum number of nvlinks per npu */
>>>  #define NV_MAX_LINKS 6
>>>  
>>> @@ -478,7 +497,6 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
>>>  	int i, j;
>>>  	struct npu *npu;
>>>  	struct pci_dev *npdev;
>>> -	struct pnv_phb *nphb;
>>>  
>>>  	for (i = 0; i <= max_npu2_index; i++) {
>>>  		mmio_atsd_reg[i].reg = -1;
>>> @@ -493,8 +511,10 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
>>>  			if (!npdev)
>>>  				continue;
>>>  
>>> -			nphb = pci_bus_to_host(npdev->bus)->private_data;
>>> -			npu = &nphb->npu;
>>> +			npu = pci_bus_to_host(npdev->bus)->npu;
>>> +			if (!npu)
>>> +				continue;
>>
>> This patch changes a bunch of places that used to unconditionally
>> locate an NPU now have a failure path.
>>
>> Given that this used to always have an NPU, doesn't that mean that if
>> the NPU is not present something has already gone wrong, and we should
>> WARN_ON() or something?
> 
> 
> 
> That means this is a leftover since I dropped that npdev_to_npu helper
> which could help but there was no real value in it. I'll remove the
> check here in the next respin.


Well, technically kmalloc() can fail in pnv_npu2_init() (but not later)
so can (in theory) end up with an NPU PHB and npu==NULL but it is sooo
unlikely...



> 
> I'll probably add checks for npu!=NULL where we used to have
> firmware_has_feature(FW_FEATURE_OPAL) in 05/19.



-- 
Alexey
