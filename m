Return-Path: <SRS0=qk5f=QD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE823C282C7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jan 2019 03:08:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB2021909
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jan 2019 03:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQJUgaYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB2021909
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43nHlf0llfzDqNN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jan 2019 14:08:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=shorne@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQJUgaYy"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43nHjx0NGGzDqKb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jan 2019 14:07:13 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id e5so6247547plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 19:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5gqtElyGAjgWA1IcD3f1+6EYOKOhZl25WPW+/clLjQw=;
 b=DQJUgaYyc2s9cDIgDXTbhgKcePEzBol2WZvwvI6xmrwG+LJZGqMLESHYlxBSvlyyQ+
 oUI2SaaDg/nIxSIVyyBEipyPmK2fYHmtCyy+DuhILnqyKmu6E9VS52zUYIar2ouPKRdT
 spF0yBPuFHYuwM3tKB7m/bM+hdtYY8xeINYQ75T8D69QJml4TyVnU8zheDFZ5xRv/+d0
 fZacP6AYd7yMLzeYEBYuBCZR0ps5yO4SEfRDf0avcrWF/WhVzAvlgh4beOcKHCs3Rmim
 bGR8TFht5XxX3GHKhLXiZmgiwFe5kndg4WxAiv/zrboSXN3mxjy6wEx8Agq+Buk9nU7Q
 w6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5gqtElyGAjgWA1IcD3f1+6EYOKOhZl25WPW+/clLjQw=;
 b=g4ZXAJ3KXrDCZY/3efO/Ur/8ortNzMvGCROiZE/RzxgfT3pBSrJPh78sFBmwaffkN4
 5UcNE8PekTS8dal6eJviqETtRdlKY9iKcxs526I5oUjFQH8kkWtoMZU2io4tT79nG8Dl
 r6pXOClWuvFXvrjjRpQwmElqepLOmLqmXxdYD9Nw7V8hRudXz2f254Nc6m/Ynn2D2+9X
 Z6dPRwJS6ZhGgCKbx/NtO3mmwK5vG9rbrE5kv5RZAv6bkbnvW0Oboqyam8Mvo3PfK7lF
 bJen7U4F2AZjOfgkY+Tr9wRLibH/N9LwNnnxB7+SqHOgdeJ/1wGHXQ1ec9nrIsERJW1k
 fGDA==
X-Gm-Message-State: AJcUukfPao+zilibdzpc8LREov2vTtbM2ILZlt2A31s65MIIg2ScbmHO
 ax2Qhhr2MjAG8oOuRU1Iunc=
X-Google-Smtp-Source: ALg8bN5eshCohDgRr4aNT4DHZbbxXbPGsl6tcfcU1p2ZW+JtAH0/P63w9fWMtbQ4B+tA+eLKxDtTiQ==
X-Received: by 2002:a17:902:584:: with SMTP id
 f4mr17453617plf.28.1548558431604; 
 Sat, 26 Jan 2019 19:07:11 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
 by smtp.gmail.com with ESMTPSA id t24sm53501159pfm.127.2019.01.26.19.07.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Jan 2019 19:07:10 -0800 (PST)
Date: Sun, 27 Jan 2019 12:07:08 +0900
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 01/21] openrisc: prefer memblock APIs returning
 virtual address
Message-ID: <20190127030708.GU3235@lianli.shorne-pla.net>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 10:03:48AM +0200, Mike Rapoport wrote:
> The allocation of the page tables memory in openrics uses
> memblock_phys_alloc() and then converts the returned physical address to
> virtual one. Use memblock_alloc_raw() and add a panic() if the allocation
> fails.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/openrisc/mm/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index d157310..caeb418 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -105,7 +105,10 @@ static void __init map_ram(void)
>  			}
>  
>  			/* Alloc one page for holding PTE's... */
> -			pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> +			pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> +			if (!pte)
> +				panic("%s: Failed to allocate page for PTEs\n",
> +				      __func__);
>  			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
>  
>  			/* Fill the newly allocated page with PTE'S */

This seems reasonable to me.

Acked-by: Stafford Horne <shorne@gmail.com>

