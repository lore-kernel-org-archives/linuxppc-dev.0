Return-Path: <SRS0=ktNZ=HT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B80C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Feb 2021 19:33:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6530164E45
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Feb 2021 19:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6530164E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dgp0f0l79z3cxc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Feb 2021 06:33:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=kRNTVaud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::736;
 helo=mail-qk1-x736.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kRNTVaud; dkim-atps=neutral
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dgp0759q1z3cHl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2021 06:32:54 +1100 (AEDT)
Received: by mail-qk1-x736.google.com with SMTP id w19so13913217qki.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2021 11:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=TRLf1G8f2Go1VE645xdlH8BG2DStOsSzPhXA0pRDJR4=;
 b=kRNTVaudWjexbvvommo9ZCKBIqaSKiymVPnn7WIbKB7wtdSdXFkRmnOk5llZOoym5H
 poqHg2pyNXl07F6LJTgvspwqzS8uFVcvxFumlosxKZmIngh5l6Ik5TC5U1SYq0KhOCR8
 43+cGVU+ZkH3pdyDaVjSkGydOtve2FLlX03pjBrqIeonhg3tVGWhG0h6kESokx0+Ggnb
 SvGTmWEpmrClGZj89P5kWK4/4FiOspRDyZcq7gzfmEqEjo9kYCwBd7ZRRonuCCmSHuAZ
 iInnIbyxgSg6j7fs2RArx5iZvt6IDyt/WXP3NOc9O26UaS4UTchYt/kZ1BmZXriYyWYq
 TwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=TRLf1G8f2Go1VE645xdlH8BG2DStOsSzPhXA0pRDJR4=;
 b=qntVKnYATHIAyC2jSNyQvqK6CKb2e2qxwSaW3lDSF5j/SKjRliwQZtYPerqic3Tzba
 c7kRRRZu5iGOwCWAsexNNKDU0dm827XITJ1bEaD9d6g9Nde98YEe208JSlGrUyhTYKgD
 +F2vLiH2sJ+5AOrnW2Txxl2++YvzDfgrUiDPu7dkON6DqGyuVwXRgupNhkcNlWZu3PtA
 EFotD4VhhTZ5uxlvIUCQOgX6oyeeHndM/UpzcLgwVQpA2/XYcem42SFxcYzThRgqtZMa
 0fJ9j2trnuuvXt0uEGEwb+VNc95aPbfbzWZNJWv/T7kIK/wAKUqxX7nkO2UrI9m1YdhA
 NOWw==
X-Gm-Message-State: AOAM532nB0ZPo8SfDMXoKIOXvvMeoastYvRoopb1242VEtTT6pimOZg/
 zcwDSs9yASx5MHQ7Al75l18=
X-Google-Smtp-Source: ABdhPJzkR0AEx/9kpX4bJfW097t4PrjwjMgeaNwZpP8gKyBd/1UPcooKJA9XkH/8zFt8KFxkCEWTIA==
X-Received: by 2002:a37:a395:: with SMTP id m143mr739218qke.439.1613590370927; 
 Wed, 17 Feb 2021 11:32:50 -0800 (PST)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 (177-131-90-207.dynamic.desktop.com.br. [177.131.90.207])
 by smtp.gmail.com with ESMTPSA id u20sm1914972qtb.63.2021.02.17.11.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:32:50 -0800 (PST)
Message-ID: <433396d9ef216aa090e32bb344d42f60de1fb9aa.camel@gmail.com>
Subject: Re: [PATCH kernel 2/2] powerpc/iommu: Do not immediately panic when
 failed IOMMU table allocation
From: Leonardo Bras <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Feb 2021 16:32:45 -0300
In-Reply-To: <20210216033307.69863-3-aik@ozlabs.ru>
References: <20210216033307.69863-1-aik@ozlabs.ru>
 <20210216033307.69863-3-aik@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2021-02-16 at 14:33 +1100, Alexey Kardashevskiy wrote:
> Most platforms allocate IOMMU table structures (specifically it_map)
> at the boot time and when this fails - it is a valid reason for panic().
> 
> However the powernv platform allocates it_map after a device is returned
> to the host OS after being passed through and this happens long after
> the host OS booted. It is quite possible to trigger the it_map allocation
> panic() and kill the host even though it is not necessary - the host OS
> can still use the DMA bypass mode (requires a tiny fraction of it_map's
> memory) and even if that fails, the host OS is runnnable as it was without
> the device for which allocating it_map causes the panic.
> 
> Instead of immediately crashing in a powernv/ioda2 system, this prints
> an error and continues. All other platforms still call panic().
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Hello Alexey,

This looks like a good change, that passes panic() decision to platform
code. Everything looks pretty straightforward, but I have a question
regarding this:

> @@ -1930,16 +1931,16 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
>  		res_start = pe->phb->ioda.m32_pci_base >> tbl->it_page_shift;
>  		res_end = min(window_size, SZ_4G) >> tbl->it_page_shift;
>  	}
> -	iommu_init_table(tbl, pe->phb->hose->node, res_start, res_end);
> -	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
> 
> +	if (iommu_init_table(tbl, pe->phb->hose->node, res_start, res_end))
> +		rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
> +	else
> +		rc = -ENOMEM;
>  	if (rc) {
> -		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
> -				rc);
> +		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n", rc);
>  		iommu_tce_table_put(tbl);
> -		return rc;
> +		tbl = NULL; /* This clears iommu_table_base below */
>  	}
> -
>  	if (!pnv_iommu_bypass_disabled)
>  		pnv_pci_ioda2_set_bypass(pe, true);
>  
> 

If I could understand correctly, previously if iommu_init_table() did
not panic(), and pnv_pci_ioda2_set_window() returned something other
than 0, it would return rc in the if (rc) clause, but now it does not
happen anymore, going through if (!pnv_iommu_bypass_disabled) onwards.

Is that desired?

As far as I could see, returning rc there seems a good procedure after
iommu_init_table returning -ENOMEM.

Best regards, 
Leonardo Bras  




