Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB35C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 21:24:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D8F20989
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 21:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFvCYUdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D8F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434GyK22TbzDqkj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 08:24:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFvCYUdP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=shorne@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFvCYUdP"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434GvV0YlBzDqkd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 08:22:13 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w7so8421118pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=POLOYIiJuU8CSX2TWzyy+YnWmRatYsfe9ljSBPA02cc=;
 b=ZFvCYUdPkDH7NO0rp6JgX1scwTdNTO8jtyDg7Rwsfu2WJCKOnycrvqEYrFlEr/cmKI
 aeOjz2bskKgyZvu8lcXfVqHlDRi4k+fbk+EhjmScBxi53fhER9x9BZuIh3e9DiQDnjfC
 RjfTuHmUzn9LmJsIs5uiHMe1h/8aVb3BUmqJdd/qfjMS679ratilbx3u/6LPkZl+oUGb
 eQ54kVVLrev7o8CxgOLedEcQEP6KaTbhGB49Hvl8daEeetNklnYqDYubYvVENHDZxrwS
 brHRLhvU8eZZBLcZlOlAdQXRnLZjl/sVWsDae715iO1f+vPg9/obZv0J4ZGjRa6wOqad
 TrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=POLOYIiJuU8CSX2TWzyy+YnWmRatYsfe9ljSBPA02cc=;
 b=L4n3nJ9XufLGeX5fxusQ3V1x4mBdDj4X3IoXKgrsJqosTR+Bcn/lAqZdXBWbV/NBj1
 pXTTBhdVHIpV9QOeRDc6X3ytlMEDA3A57IOBNvvCwpL7TkVrDv5sArSDmQwq//V0Vlc6
 DESfGr0M5U4gFeSycPeFjYtEUzQwPJkX9N15OwZNPWDS8LLm2k1CGWPywkiVz2ppXalE
 +xSt7Y/BI+zu8hH85iwVo7v3+Dl1yDWcO0eMHT/VJdnxqHKbV5O8y2PGMpmD88Qx0rbr
 7HmHPkjB4VQNBAbqA59mMIBMbw21VwRIAU0OOjoDoFNoVHqGoto74/g2xL85XEq/wLua
 p0gA==
X-Gm-Message-State: AA+aEWY75ej0tXUG+Obt2DoE6fCpmzcFGR4GuVgqvsuNVjzG59xcMqlc
 a0v/M28tCWyQmzsY0acuekM=
X-Google-Smtp-Source: AFSGD/XiXnPx8nsrAwbkwBA1FsS2iMO2juvBawJVCbnt6kjMC7HFbLiLGwtBdZhmWYphxFeYJ/Q3RA==
X-Received: by 2002:a63:fe48:: with SMTP id x8mr31264176pgj.261.1543353363014; 
 Tue, 27 Nov 2018 13:16:03 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
 by smtp.gmail.com with ESMTPSA id 69sm6193028pgg.86.2018.11.27.13.16.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 27 Nov 2018 13:16:02 -0800 (PST)
Date: Wed, 28 Nov 2018 06:16:00 +0900
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 4/5] openrisc: simplify pte_alloc_one_kernel()
Message-ID: <20181127211600.GB3235@lianli.shorne-pla.net>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-5-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543182277-8819-5-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 25, 2018 at 11:44:36PM +0200, Mike Rapoport wrote:
> The pte_alloc_one_kernel() function allocates a page using
> __get_free_page(GFP_KERNEL) when mm initialization is complete and
> memblock_phys_alloc() on the earlier stages. The physical address of the
> page allocated with memblock_phys_alloc() is converted to the virtual
> address and in the both cases the allocated page is cleared using
> clear_page().
> 
> The code is simplified by replacing __get_free_page() with
> get_zeroed_page() and by replacing memblock_phys_alloc() with
> memblock_alloc().

Hello Mike,

This looks fine to me.  How do you plan to get this merged?  Will you be taking
care of the whole series or so you want me to queue this openrisc part?

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/ioremap.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index c969752..cfef989 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -123,13 +123,10 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm,
>  {
>  	pte_t *pte;
>  
> -	if (likely(mem_init_done)) {
> -		pte = (pte_t *) __get_free_page(GFP_KERNEL);
> -	} else {
> -		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> -	}
> +	if (likely(mem_init_done))
> +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> +	else
> +		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  
> -	if (pte)
> -		clear_page(pte);
>  	return pte;
>  }
> -- 
> 2.7.4
> 
