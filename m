Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C622C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 05:48:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF33204EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 05:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HXYIu1bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF33204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXrDP5wTTzDqwV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 15:48:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+a718def99972ac67df6e+6207+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=HXYIu1bn; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXr8S4rVwzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 15:45:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mrGKbmJ1c7ngURPGL3BPovml0cJwz1Kq/Us/whxD7Sc=; b=HXYIu1bnNW/qWXAehQRzq4ZK6I
 V9RA92llGQm+y5SLxiKLrH7jpItu9BFP0M8CUS+vmD/8vQZkR5ZCMkpI+/PFmr3GKApoigmRzl+Jw
 R+q4a1c7tXY/q5zqu/9M8FAIp/AWhUfj7G825d7RMQ4XZdILn+y5JrhQ9hevQTAR7Wwzl9HDhDlei
 GzFX6TlE/eeYqrx7+uDlbdF/YPbcCWIKIHWzS53CvpmH2CQ+9Ivl1NlXJwDvV/HFgX/vSLZr7ME8k
 oAXdDCBZSzovPItK/QL3IzGObSAN723G0X6pt9VTLgUo8Dxyqr6CFCaeprsKkOYgXfGHtJwj4uIBr
 jorGF3Kw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k8zrd-0007WC-Mn; Fri, 21 Aug 2020 05:45:21 +0000
Date: Fri, 21 Aug 2020 06:45:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 4/8] lib/ioremap: rename ioremap_*_range to vmap_*_range
Message-ID: <20200821054521.GB28291@infradead.org>
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044427.736424-5-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 21, 2020 at 02:44:23PM +1000, Nicholas Piggin wrote:
> This will be moved to mm/ and used as a generic kernel virtual mapping
> function, so re-name it in preparation.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  mm/ioremap.c | 55 ++++++++++++++++++++++------------------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 5fa1ab41d152..6016ae3227ad 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -61,9 +61,8 @@ static inline int ioremap_pud_enabled(void) { return 0; }
>  static inline int ioremap_pmd_enabled(void) { return 0; }
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
> -static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
> -		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
> -		pgtbl_mod_mask *mask)
> +static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> +			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)

Same here.
