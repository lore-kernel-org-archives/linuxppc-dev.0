Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41664C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:53:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1E120821
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H56l7khw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1E120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lDv63kchzDqRZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:53:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H56l7khw"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lDsK6mBczDqQ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 19:51:49 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id e6so958024pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version:content-transfer-encoding;
 bh=2q0rntOM1UomMqfxbCPSXtCW3R0YOl55rGLwGA5uryw=;
 b=H56l7khwwbmETBQpczyeOGBrtzN4KxFfnP9ajfJbhWYfS3lN/LePATEqSTNOzQ5oln
 9Vg5uSnuvTQbYwo+i7RVDP+Sb/pFznorL2lcbgMLTTNvp1KAP2TwwX/9crN3WGY/Tf9F
 bEe8b769atcgAzH2B63wKHA5whWnb28AZY57eUZ4v80ZUE80wcqkFAwcRPhijZ52bMnE
 QCUWqgfmrcQWTb123BHQCiD4JDURFKNLvKo+jIFSAEUKBe6iwbrUTwTS7p3FpBTIFk4U
 CIcJYV0wb9yWsd+is0iE492Njh6MgL5aQcMmEv/nu0cIFMBmFa7XwDNrRLJ3Id6SDrpw
 AF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=2q0rntOM1UomMqfxbCPSXtCW3R0YOl55rGLwGA5uryw=;
 b=AFtKxE4ByMnYNHt2LUGX8BT+gxmirkvKsyj51AArmLmiBK+i4OkS1IVNeEaT4AKNAI
 KjblME2p2Z455z8BdoCsS5LZGaTbi7qhM4rYmr7mAbQGDpSzK8xXPWz45W7CIbu2txfz
 OiLj8zfsDqvvVOtgWULiAavRD/mzmrZEL8cDcLsCp83RPfH4Rxu7ut5rEE0+/V5Q2uMR
 /MAffy2bPMmq0G4uPDe5NIpcrKsQNUMFYc+4KlJxygSAOzxbro5JfZE2YReg3yJ1YBY9
 Na0wasG3L+aYy+tdeGD45mSeDIAnYfkeRJGypDZZouke56DcR+SmW6Y0ryyOiwEaUcUY
 aC+Q==
X-Gm-Message-State: APjAAAXIl6MUvUbIswH60DMRo0lHe1pZWqJxXupA06G4y9Bg9NLyW/IP
 6jWE2E1eO1dGVcSDlUUhTM8SplxD
X-Google-Smtp-Source: APXvYqyLHTWhSiy8wp5lESChxwr6pH0owZmLQcMdT4SpWBQTA3HXPHaQ1nHPaGDnhtHOwAWjSSQZqg==
X-Received: by 2002:a63:d256:: with SMTP id t22mr83354594pgi.80.1555581105945; 
 Thu, 18 Apr 2019 02:51:45 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id r27sm4777028pgn.0.2019.04.18.02.51.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Apr 2019 02:51:44 -0700 (PDT)
Message-ID: <1434231d4e8216e5b12382ad081e81c886c33c14.camel@gmail.com>
Subject: Re: [PATCH 3/8] powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
From: Oliver O'Halloran <oohall@gmail.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 18 Apr 2019 19:51:40 +1000
In-Reply-To: <17f0dc9c30a139f19dceefd09689d34c3ad01a17.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <17f0dc9c30a139f19dceefd09689d34c3ad01a17.1553050609.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
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

On Wed, 2019-03-20 at 13:58 +1100, Sam Bobroff wrote:
> The PHB flag, PNV_PHB_FLAG_EEH, is set (on PowerNV) individually on
> each PHB once the EEH subsystem is ready. It is the only use of the
> flags member of the phb struct.
> 
> However there is no need to store this separately on each PHB, so
> convert it to a global flag. For symmetry, the flag is now also set
> for pSeries; although it is currently unused it may be useful in the
> future.

I'd drop this patch and keep it as a seperate flag. Making this a
global flag doesn't really buy us anything either. It's also worth
remembering that we do have virtual PHBs, like the NVLink ones, that
don't have real EEH support and we should be doing something more
intelligent about that.

If you are going to remove the PNV_PHB flag then i would look at moving
that flag into the generic pci_controller structure that we use for
tracking PHBs since that would give us a way to toggle EEH support on a
per PHB basis on pseries and powernv.

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

