Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBDC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:17:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2D420857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="mVXRlN/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2D420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PKTG6bxbzDqNJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 17:17:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="mVXRlN/z"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PKD302f7zDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 17:05:54 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id a22so937187pgg.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p9OEYjwCewDAXMKJz7V/bvzvBrYzKN+sG+SRPZrR9Qk=;
 b=mVXRlN/zEAWY3KnX4ZAPmwSIyt8w7xhQHNO9e4eZaMtbjzw941yf6U8gVK8XMgvO+R
 vGLx6imfiu6qo9aOGH+sPYseenZIUZsBvrwG2eUwmCUBMtNtewSmboLs9PYP9zNo7j6L
 0u//6QgJFeecy0QY9mweW2Lp0027dW/uaO697GVjTeXUQcmmHtPm4gihXz7GuyHp09oc
 lzTdWFfZ+t5V+68fGx8BaIb1ojJsXKvS4hXKFVwF60CGKzTGDNyElwXYatnML9+lmO4p
 nFFTb6VHqlJmDNK8DerPIrnJUJHGD9Mf1tY7Y3J4aL40BCVpROj1v1I3FzGjN2L0pXwk
 0oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=p9OEYjwCewDAXMKJz7V/bvzvBrYzKN+sG+SRPZrR9Qk=;
 b=NtLqy9DcNo2XIYlEv3+RZ2BuTmEjMU7Y3y7c7TjgsamuGtgZM1gSYeldeQ3flDGQlO
 Jjt6aIVr4iG1JynxiuF/ZLcSIG680LeAANzTcsLPSWu3UIud9ygwvfwG82NcXbyeVZhu
 IjbF57JQIalPLQixSIl4qVtYSOGUgz87fMzf8zgfBUpSGdfVKD7LGhgciGwPze3yPjP5
 LIujGspfs3XenA/uPvKBlMbiXPz0jaaYGBTOCivrRWKMSOV0in+hmyQeXKjKNiig3sgl
 Ye+rhP8sybEgcHuzMPBxaIdBOSIqqOgXvtb0DNo8krlE4u/GKeTRvUa1+f8uDs86UhJM
 aOYw==
X-Gm-Message-State: APjAAAXqlyka0zb6JhTRj0gQ2anzfQNiG6y+1Ie57TmeCcDWQDTehGHf
 LYjvce9cjhnzctlbL4nOoK5WIMsIzuU=
X-Google-Smtp-Source: APXvYqxPbbzM9wIWUXA9qwktBSTpten8MIJt7pNE6K02Xujs1f++dIU0MqoqtIGxzhDaevg8PSX7ug==
X-Received: by 2002:a62:4d43:: with SMTP id a64mr5836822pfb.157.1553061952881; 
 Tue, 19 Mar 2019 23:05:52 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id n24sm1855614pfi.123.2019.03.19.23.05.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Mar 2019 23:05:52 -0700 (PDT)
Subject: Re: [PATCH 8/8] powerpc/eeh: Remove eeh_probe_devices() and
 eeh_addr_cache_build()
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <f43eac2b2adf92848afc3304cabd770c9bc976ce.1553050609.git.sbobroff@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <f3acd337-3222-0cdd-4784-b71cbaa44566@ozlabs.ru>
Date: Wed, 20 Mar 2019 17:05:49 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <f43eac2b2adf92848afc3304cabd770c9bc976ce.1553050609.git.sbobroff@linux.ibm.com>
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
> Now that EEH support for all devices (on PowerNV and pSeries) is
> provided by the pcibios bus add device hooks, eeh_probe_devices() and
> eeh_addr_cache_build() are redundant and can be removed.
> 
> Note that previously on pSeries, useless EEH sysfs files were created
> for some devices that did not have EEH support and this change
> prevents them from being created.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |  6 ----
>  arch/powerpc/kernel/eeh.c                    | 13 --------
>  arch/powerpc/kernel/eeh_cache.c              | 32 --------------------
>  arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++-
>  arch/powerpc/platforms/pseries/pci.c         |  3 +-
>  5 files changed, 3 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 791b9e6fcc45..f1eca1757cbc 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -290,13 +290,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
>  struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
>  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
>  void eeh_show_enabled(void);
> -void eeh_probe_devices(void);
>  int __init eeh_ops_register(struct eeh_ops *ops);
>  int __exit eeh_ops_unregister(const char *name);
>  int eeh_check_failure(const volatile void __iomem *token);
>  int eeh_dev_check_failure(struct eeh_dev *edev);
>  void eeh_addr_cache_init(void);
> -void eeh_addr_cache_build(void);
>  void eeh_add_device_early(struct pci_dn *);
>  void eeh_add_device_tree_early(struct pci_dn *);
>  void eeh_add_device_late(struct pci_dev *);
> @@ -347,8 +345,6 @@ static inline bool eeh_phb_enabled(void)
>  	return false;
>  }
>  
> -static inline void eeh_probe_devices(void) { }
> -
>  static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
>  {
>  	return NULL;
> @@ -365,8 +361,6 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>  
>  static inline void eeh_addr_cache_init(void) { }
>  
> -static inline void eeh_addr_cache_build(void) { }
> -
>  static inline void eeh_add_device_early(struct pci_dn *pdn) { }
>  
>  static inline void eeh_add_device_tree_early(struct pci_dn *pdn) { }
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 217e14bb1fb6..cd2abbe41497 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1166,19 +1166,6 @@ static struct notifier_block eeh_reboot_nb = {
>  	.notifier_call = eeh_reboot_notifier,
>  };
>  
> -void eeh_probe_devices(void)
> -{
> -	struct pci_controller *hose, *tmp;
> -	struct pci_dn *pdn;
> -
> -	/* Enable EEH for all adapters */
> -	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> -		pdn = hose->pci_data;
> -		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
> -	}
> -	eeh_show_enabled();
> -}
> -
>  /**
>   * eeh_init - EEH initialization
>   *
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index f93dd5cf6a39..c40078d036af 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -278,38 +278,6 @@ void eeh_addr_cache_init(void)
>  	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
>  }
>  
> -/**
> - * eeh_addr_cache_build - Build a cache of I/O addresses
> - *
> - * Build a cache of pci i/o addresses.  This cache will be used to
> - * find the pci device that corresponds to a given address.
> - * This routine scans all pci busses to build the cache.
> - * Must be run late in boot process, after the pci controllers
> - * have been scanned for devices (after all device resources are known).
> - */
> -void eeh_addr_cache_build(void)
> -{
> -	struct pci_dn *pdn;
> -	struct eeh_dev *edev;
> -	struct pci_dev *dev = NULL;
> -
> -	for_each_pci_dev(dev) {
> -		pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
> -		if (!pdn)
> -			continue;
> -
> -		edev = pdn_to_eeh_dev(pdn);
> -		if (!edev)
> -			continue;
> -
> -		dev->dev.archdata.edev = edev;
> -		edev->pdev = dev;
> -
> -		eeh_addr_cache_insert_dev(dev);
> -		eeh_sysfs_add_device(dev);
> -	}
> -}
> -
>  static int eeh_addr_cache_show(struct seq_file *s, void *v)
>  {
>  	struct pci_io_addr_range *piar;
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 81b0923cc55f..6a08f4fab255 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -240,9 +240,7 @@ int pnv_eeh_post_init(void)
>  	struct pnv_phb *phb;
>  	int ret = 0;
>  
> -	/* Probe devices & build address cache */
> -	eeh_probe_devices();
> -	eeh_addr_cache_build();
> +	eeh_show_enabled();
>  
>  	/* Register OPAL event notifier */
>  	eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
> @@ -360,6 +358,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
>  	return 0;
>  }
>  
> +

Unrelated new line. Otherwise


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




>  /**
>   * pnv_eeh_probe - Do probe on PCI device
>   * @pdn: PCI device node
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 7be80882c08d..7c781b04fb15 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -242,8 +242,7 @@ void __init pSeries_final_fixup(void)
>  
>  	pSeries_request_regions();
>  
> -	eeh_probe_devices();
> -	eeh_addr_cache_build();
> +	eeh_show_enabled();
>  #ifdef CONFIG_EEH
>  	if (eeh_enabled())
>  		eeh_add_flag(EEH_PHB_ENABLED);
> 

-- 
Alexey
