Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:10:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581CE2184D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="KU0CnPzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581CE2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PKKX1N2BzDqFt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 17:10:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="KU0CnPzs"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PK8V1rgVzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 17:02:50 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id k11so951214pgb.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ZUSkGbEVGrVy6Lb93DgRFKuyTelskAuC47p+xVbQcQ=;
 b=KU0CnPzsNkK/envZ/NNBZ6VFyfKAYNuql9fl6QAeDXt8cVYc6FBfUXgDEbS13GKTJu
 cI2clsn5F9aFVkjlL304rzl7W2krdViYzIfLuIMZw5sThMieI2nEHb8z8w1FambC5w+6
 W0J4pI3IRj2Yd+ardcbqavx6X+1I4fw7ClWQZgxJYxx4sjKPOz94zYhsIn5b4vRzgN9m
 8rPJnT4N/FX/YxoekdYO01PTPG+Qo2sHmv6z130e6kDTLmmCEtXSOxKVtujl1tGtTEv7
 zHQAnXdzUg+8nl+dG3vXOewjvOLVXP1gwWli/MX8h/t/a7wCyHijqcwTGhOgfvphk9+A
 nb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3ZUSkGbEVGrVy6Lb93DgRFKuyTelskAuC47p+xVbQcQ=;
 b=hVTNF7FIEl9MypN/zsIUqEyN6UtAVW5KNkPyasgI/PRLgRFA+rbb3CRfLY2ZM9gtuc
 VvOpiclFyyEEK5pCl9xCF1lajo/fcCQ3+DyTAXkb612N+LJQ7ZDd4LnpQheUa8f23qRQ
 OPNkVmNe8FJjnOEYgiYwiGSfBU7ZTUL0AMB3+sxLMt8/ND2vGAKgzehE7UGxfjwL8Il1
 7r1mk9+y7uzUYQ65xkHVvc5rAT0tM9HnvpvOW9KPI+p6yhFsO7lCOBzlSihhSl4QoA7u
 fChV/pXr2acNS+AOHXBYU0tcmZQiok9UUdXFGggZyYbcPJI79t7tYd8Dvb/V/r5OlstT
 Tm4Q==
X-Gm-Message-State: APjAAAWEVgGETgpI8EaYVCrrlqLSekW5f3jooM/ee+l2g3m+m8gFY7pe
 rsuDLFvtgr5vqCqs6dQFzDKAu0nymPA=
X-Google-Smtp-Source: APXvYqwHiiywcaFwe7Jv3I3wb2CGj4//hKa9ZOIoXYzrGDRoYNeDIp2toBNHXeB5/1UzH7IYyRFzHg==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr5738985pgr.48.1553061767884; 
 Tue, 19 Mar 2019 23:02:47 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id j71sm1862238pfc.6.2019.03.19.23.02.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Mar 2019 23:02:47 -0700 (PDT)
Subject: Re: [PATCH 3/8] powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <17f0dc9c30a139f19dceefd09689d34c3ad01a17.1553050609.git.sbobroff@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <680b2264-93a8-6c75-88c1-ad0520b8e8a7@ozlabs.ru>
Date: Wed, 20 Mar 2019 17:02:44 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <17f0dc9c30a139f19dceefd09689d34c3ad01a17.1553050609.git.sbobroff@linux.ibm.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 20/03/2019 13:58, Sam Bobroff wrote:
> The PHB flag, PNV_PHB_FLAG_EEH, is set (on PowerNV) individually on
> each PHB once the EEH subsystem is ready. It is the only use of the
> flags member of the phb struct.


Then why to keep pnv_phb::flags?

> However there is no need to store this separately on each PHB, so
> convert it to a global flag. For symmetry, the flag is now also set
> for pSeries; although it is currently unused it may be useful in the
> future.

Just using eeh_enabled() instead of (phb->flags & PNV_PHB_FLAG_EEH)
seems easier and cleaner; also pseries does not use it so there is no
point defining it there either.


> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               | 11 +++++++++++
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 14 +++-----------
>  arch/powerpc/platforms/powernv/pci.c         |  7 +++----
>  arch/powerpc/platforms/powernv/pci.h         |  2 --
>  arch/powerpc/platforms/pseries/pci.c         |  4 ++++
>  5 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 3613a56281f2..fe4cf7208890 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -43,6 +43,7 @@ struct pci_dn;
>  #define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid		     */
>  #define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log		     */
>  #define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately		     */
> +#define EEH_PHB_ENABLED		0x80	/* PHB recovery uses EEH	     */
>  
>  /*
>   * Delay for PE reset, all in ms
> @@ -245,6 +246,11 @@ static inline bool eeh_enabled(void)
>  	return eeh_has_flag(EEH_ENABLED) && !eeh_has_flag(EEH_FORCE_DISABLED);
>  }
>  
> +static inline bool eeh_phb_enabled(void)
> +{
> +	return eeh_has_flag(EEH_PHB_ENABLED);
> +}
> +
>  static inline void eeh_serialize_lock(unsigned long *flags)
>  {
>  	raw_spin_lock_irqsave(&confirm_error_lock, *flags);
> @@ -332,6 +338,11 @@ static inline bool eeh_enabled(void)
>          return false;
>  }
>  
> +static inline bool eeh_phb_enabled(void)
> +{
> +	return false;
> +}
> +
>  static inline void eeh_probe_devices(void) { }
>  
>  static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 6fc1a463b796..f0a95f663810 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -264,22 +264,14 @@ int pnv_eeh_post_init(void)
>  		return ret;
>  	}
>  
> -	if (!eeh_enabled())
> +	if (eeh_enabled())
> +		eeh_add_flag(EEH_PHB_ENABLED);
> +	else
>  		disable_irq(eeh_event_irq);
>  
>  	list_for_each_entry(hose, &hose_list, list_node) {
>  		phb = hose->private_data;
>  
> -		/*
> -		 * If EEH is enabled, we're going to rely on that.
> -		 * Otherwise, we restore to conventional mechanism
> -		 * to clear frozen PE during PCI config access.
> -		 */
> -		if (eeh_enabled())
> -			phb->flags |= PNV_PHB_FLAG_EEH;
> -		else
> -			phb->flags &= ~PNV_PHB_FLAG_EEH;
> -
>  		/* Create debugfs entries */
>  #ifdef CONFIG_DEBUG_FS
>  		if (phb->has_dbgfs || !phb->dbgfs)
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 307181fd8a17..d2b50f3bf6b1 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -717,10 +717,9 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
>  static bool pnv_pci_cfg_check(struct pci_dn *pdn)
>  {
>  	struct eeh_dev *edev = NULL;
> -	struct pnv_phb *phb = pdn->phb->private_data;
>  
>  	/* EEH not enabled ? */
> -	if (!(phb->flags & PNV_PHB_FLAG_EEH))
> +	if (!eeh_phb_enabled())
>  		return true;
>  
>  	/* PE reset or device removed ? */
> @@ -761,7 +760,7 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>  
>  	ret = pnv_pci_cfg_read(pdn, where, size, val);
>  	phb = pdn->phb->private_data;
> -	if (phb->flags & PNV_PHB_FLAG_EEH && pdn->edev) {
> +	if (eeh_phb_enabled() && pdn->edev) {
>  		if (*val == EEH_IO_ERROR_VALUE(size) &&
>  		    eeh_dev_check_failure(pdn->edev))
>                          return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -789,7 +788,7 @@ static int pnv_pci_write_config(struct pci_bus *bus,
>  
>  	ret = pnv_pci_cfg_write(pdn, where, size, val);
>  	phb = pdn->phb->private_data;
> -	if (!(phb->flags & PNV_PHB_FLAG_EEH))
> +	if (!eeh_phb_enabled())
>  		pnv_pci_config_check_eeh(pdn);
>  
>  	return ret;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 8e36da379252..eb0add61397b 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -85,8 +85,6 @@ struct pnv_ioda_pe {
>  	struct list_head	list;
>  };
>  
> -#define PNV_PHB_FLAG_EEH	(1 << 0)
> -
>  struct pnv_phb {
>  	struct pci_controller	*hose;
>  	enum pnv_phb_type	type;
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 37a77e57893e..7be80882c08d 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -244,6 +244,10 @@ void __init pSeries_final_fixup(void)
>  
>  	eeh_probe_devices();
>  	eeh_addr_cache_build();
> +#ifdef CONFIG_EEH
> +	if (eeh_enabled())
> +		eeh_add_flag(EEH_PHB_ENABLED);
> +#endif
>  
>  #ifdef CONFIG_PCI_IOV
>  	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
> 

-- 
Alexey
