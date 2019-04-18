Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F0C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:03:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE8E21479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYqqognX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE8E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lF6x51cbzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 20:03:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mYqqognX"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lF4m133VzDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 20:01:43 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id v12so981830pgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version:content-transfer-encoding;
 bh=e2Lg+YiMyDAJdqoCYcqDCd+E80ss5QxwF2ltnJY99CY=;
 b=mYqqognXmnFP33EtQzK2dDqzg2xujISojkNBFlJ/tPXe9tuxbppEoHSbqKv7yeHfGJ
 TcEbeNHDs/l5J482pLSeZFNGub4eeUnoOlDNfSH3PYzPr+ZGdYzelL4iyTcz+F0gaAhV
 HSRBqxecvPqI1q09AetuUI1sLodBCCxSq+RPXob3aujIlnYNgG48FtU/dClLhSJUiKgq
 8l3FEAYrrcnrfEA7DajCnnv+9VNwQjiAm85nQBVH4VAJLnwvxXJtxKbR37El9M8en/yw
 SUE5mf6kGXkp9WbbkZfwUC5xYHdwOE5c5eLqXCAN94DEJyf80ItIA+rzJ9jyUf1KkNQA
 b1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=e2Lg+YiMyDAJdqoCYcqDCd+E80ss5QxwF2ltnJY99CY=;
 b=Wv9csNMGZ+zFyTmH8ubrumBOLv7SDSLq3czpmOF5yAVNl2R9/o73TpiW/mH/FJrsBY
 hEjNwj8gQETp8fw4muDAZlUbWvjLKPwtQetf9XV5RQXzgre6/AIo5PK5SZnE7B8WBM7J
 w+vR5bDu/HW32hmr/ww59d2fdlxWgswrOob695BTotRwoYyglgFNZR6MbyL3NxglgB2s
 C+M70bsZOJrftcjWXNw+snfTZSwWVgFac4dC9EWhxxiejUKoCmxu4XF+crq1DoQMMEfY
 7AUo1akbq5+4BOAwBY1JSG0u9q9hy9LZFIEv0kaglgeZa38unwrRNxlxNoX6S9MYQAMp
 ++9g==
X-Gm-Message-State: APjAAAUvS0XPefBm1OGLC4anRSrk+KPpnNuoCe5EJcMmqas1J+l86DGw
 SCeMiayjLZ8OFwNsu4kyHx/b06HC
X-Google-Smtp-Source: APXvYqyoP+9MFTznnD3X7orIsO/C8YBBaFnNr/HmJH187lJgIb9LwEYWtc9DfCOyIyAvzQQj5aAg+Q==
X-Received: by 2002:a63:4644:: with SMTP id v4mr4744284pgk.422.1555581700911; 
 Thu, 18 Apr 2019 03:01:40 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id a80sm3265962pfj.61.2019.04.18.03.01.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Apr 2019 03:01:40 -0700 (PDT)
Message-ID: <7d93d678a1e37a1efb935f88fbc91f134d298ac8.camel@gmail.com>
Subject: Re: [PATCH 5/8] powerpc/eeh: Add eeh_show_enabled()
From: Oliver O'Halloran <oohall@gmail.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 18 Apr 2019 20:01:36 +1000
In-Reply-To: <ad8cf11e3151fd39c6a9deedc0098d50274c75e4.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <ad8cf11e3151fd39c6a9deedc0098d50274c75e4.1553050609.git.sbobroff@linux.ibm.com>
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
> Move the EEH enabled message into it's own function so that future
> work can call it from multiple places.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h |  3 +++
>  arch/powerpc/kernel/eeh.c      | 16 +++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index fe4cf7208890..e217ccda55d0 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -289,6 +289,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
>  
>  struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
>  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
> +void eeh_show_enabled(void);
>  void eeh_probe_devices(void);
>  int __init eeh_ops_register(struct eeh_ops *ops);
>  int __exit eeh_ops_unregister(const char *name);
> @@ -338,6 +339,8 @@ static inline bool eeh_enabled(void)
>          return false;
>  }
>  
> +static inline void eeh_show_enabled(void) { }
> +
>  static inline bool eeh_phb_enabled(void)
>  {
>  	return false;
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index b14d89547895..3dcff29cb9b3 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -163,6 +163,16 @@ static int __init eeh_setup(char *str)
>  }
>  __setup("eeh=", eeh_setup);
>  
> +void eeh_show_enabled(void)
> +{
> +	if (eeh_has_flag(EEH_FORCE_DISABLED))
> +		pr_info("EEH: PCI Enhanced I/O Error Handling DISABLED (by eeh=off)\n");

The allcaps looks kind of stupid.

> +	else if (eeh_enabled())
> +		pr_info("EEH: PCI Enhanced I/O Error Handling ENABLED (capable adapter found)\n");
> +	else
> +		pr_info("EEH: PCI Enhanced I/O Error Handling DISABLED (no capable adapter found)\n");

If we really have to keep these messages then make it say "no EEH
capable buses found" or something. EEH support has absolutely nothing
to do with the adapters and I'm not even sure we can get the "DISABLED"
message on PowerNV since the root port will always be there.

> +}
> +
>  /*
>   * This routine captures assorted PCI configuration space data
>   * for the indicated PCI device, and puts them into a buffer
> @@ -1166,11 +1176,7 @@ void eeh_probe_devices(void)
>  		pdn = hose->pci_data;
>  		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
>  	}
> -	if (eeh_enabled())
> -		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
> -	else
> -		pr_info("EEH: No capable adapters found\n");
> -
> +	eeh_show_enabled();
>  }
>  
>  /**

