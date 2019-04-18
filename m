Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD4EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:15:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE00B214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmPIk1/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lFNp1rNfzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 20:15:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmPIk1/f"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lFLx2PV8zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 20:14:01 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id h5so909106pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version:content-transfer-encoding;
 bh=dR7Gt6tcyjgT9LZ702S4OxYoLIrt43+TxzAz5SjYw9Y=;
 b=TmPIk1/fmmX5954lD5g9RB3AX5o7AxvKfMihwzpE77BXaE5r7VGiQQtrJjkA59A5hc
 BDJdDpTgN/TUB+0CkWnfw5tj6EQGsVDcinkNMOYUvWpvUnYcmXjF2AnyLR3sL3/OK3CZ
 Wra+s4QsBf9TzDv6GngiEqlCHlifHvxa+8eP3v6X9ElBhL81456IeCrrcPxWlXeXLz8J
 Da/ZEofb6nthluURmdUBpWAUuAQhR9FHW5SYL2OTxE/lV377HcXalBgJDhwodHdNEz92
 TNN05E3EbSKs8lgSwxXKfwa++F4XjwZzYfrbG1QUmLC72EHsXsUh+B9NtOpemdblkCjE
 z0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=dR7Gt6tcyjgT9LZ702S4OxYoLIrt43+TxzAz5SjYw9Y=;
 b=FG3YZImwB9ZoAAFsL3+wvShGoQPS3mUOXzfsxZZTMgX+3kzeC8rP1Hi8UHkloagOr2
 nAhQvVbGnwV2Ur8U+HLZfoT56imS3PNVzuj1sOtACYIx1cCRffgq8B01eTobVLAry6rD
 5v8+PW7+s5df70EeXogFgajTZuFD7a8e9845YOcX0E0wtNzkj1DFlzDeYDdJdFTDntWh
 WIDehqh94jejOaUKTD4JMA8huM9xqluj6kBWO47iGchd/kwWJTztrc4HA0Y+TTPthmgY
 FCwHlMRMiJH8dfqYgmhOXDhqIi+UnumZ4/idmUaEhy53S6uUqkW0G2AWBo99CN6851L7
 1oMw==
X-Gm-Message-State: APjAAAU/zPl4CN10BOUK7x2Uh912l8X5vP2JcgLyoH1b+33ilFP0/GfI
 f0FVne6NtyOfYJbKGmEiaaE=
X-Google-Smtp-Source: APXvYqxPfj/4io7Byc/IkAOxU0c2Q2BELSd3jmRe6RHbd8MyLT8xpunVnrYWhIotxjnkmWXMiCP+QA==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr89622673pgh.263.1555582437735; 
 Thu, 18 Apr 2019 03:13:57 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id v9sm2233993pgf.73.2019.04.18.03.13.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Apr 2019 03:13:56 -0700 (PDT)
Message-ID: <ab420fc4bdfae1bd85f3e478eb1629b1e41f768c.camel@gmail.com>
Subject: Re: [PATCH 6/8] powerpc/eeh: Initialize EEH address cache earlier
From: Oliver O'Halloran <oohall@gmail.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 18 Apr 2019 20:13:53 +1000
In-Reply-To: <0ca5b600a69f73323b269e4bfdaec1a53cdb4282.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <0ca5b600a69f73323b269e4bfdaec1a53cdb4282.1553050609.git.sbobroff@linux.ibm.com>
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
> The EEH address cache is currently initialized and populated by a
> single function: eeh_addr_cache_build().  While the initial population
> of the cache can only be done once resources are allocated,
> initialization (just setting up a spinlock) could be done much
> earlier.
> 
> So move the initialization step into a separate function and call it
> from a core_initcall (rather than a subsys initcall).
> 

> This will allow future work to make use of the cache during boot time
> PCI scanning.

What's the idea there? Checking for overlaps in the BAR assignments?

> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h  |  3 +++
>  arch/powerpc/kernel/eeh.c       |  2 ++
>  arch/powerpc/kernel/eeh_cache.c | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index e217ccda55d0..791b9e6fcc45 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -295,6 +295,7 @@ int __init eeh_ops_register(struct eeh_ops *ops);
>  int __exit eeh_ops_unregister(const char *name);
>  int eeh_check_failure(const volatile void __iomem *token);
>  int eeh_dev_check_failure(struct eeh_dev *edev);
> +void eeh_addr_cache_init(void);
>  void eeh_addr_cache_build(void);
>  void eeh_add_device_early(struct pci_dn *);
>  void eeh_add_device_tree_early(struct pci_dn *);
> @@ -362,6 +363,8 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>  
>  #define eeh_dev_check_failure(x) (0)
>  
> +static inline void eeh_addr_cache_init(void) { }
> +
>  static inline void eeh_addr_cache_build(void) { }
>  
>  static inline void eeh_add_device_early(struct pci_dn *pdn) { }
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 3dcff29cb9b3..7a406d58d2c0 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1219,6 +1219,8 @@ static int eeh_init(void)
>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
>  		eeh_dev_phb_init_dynamic(hose);
>  
> +	eeh_addr_cache_init();
> +
>  	/* Initialize EEH event */
>  	return eeh_event_init();
>  }
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index 9c68f0837385..f93dd5cf6a39 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -267,6 +267,17 @@ void eeh_addr_cache_rmv_dev(struct pci_dev *dev)
>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>  }
>  
> +/**
> + * eeh_addr_cache_init - Initialize a cache of I/O addresses
> + *
> + * Initialize a cache of pci i/o addresses.  This cache will be used to
> + * find the pci device that corresponds to a given address.
> + */
> +void eeh_addr_cache_init(void)
> +{
> +	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
> +}

You could move this out of the pci_io_addr_cache structure and use
DEFINE_SPINLOCK() too. We might even be able to get rid of the hand-
rolled interval tree in eeh_cache.c in favour of the generic
implementation (see mm/interval_tree.c). I'm pretty sure the generic
one is a drop-in replacement, but I haven't had a chance to have a
detailed look to see if there's any differences in behaviour.

> +
>  /**
>   * eeh_addr_cache_build - Build a cache of I/O addresses
>   *
> @@ -282,8 +293,6 @@ void eeh_addr_cache_build(void)
>  	struct eeh_dev *edev;
>  	struct pci_dev *dev = NULL;
>  
> -	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
> -
>  	for_each_pci_dev(dev) {
>  		pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
>  		if (!pdn)

