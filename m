Return-Path: <SRS0=Jsh9=UU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96440C43613
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 13:43:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0668206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LOaqH/Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0668206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Vfyp0vVbzDqBM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 23:43:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="LOaqH/Dl"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VftD40fYzDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 23:39:14 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id c70so4407226qkg.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=W1v9REbUjdM2ZPgzn5WvSncnmCktMY/9EZgX6QI0HOA=;
 b=LOaqH/DlAyTiaVsb+/cJ5fNqCKK9dcYheZzqBkbU8/dJCNcbdbTdvycRRW6WsdWNrq
 s1KlIlJ8pqtzQuZr4K+pscDPf+VAoNvvbLh7zGps691WEcEWVHVgG/y+SfGLilLH8xno
 0bDlX2xF7lyCGAB4ZXKagYnPnFu5m/m8VbNEpdAbBtffvGdOG5+2xjfKlD1S7GX/sCJ8
 Tki+kAZuPALbN16uIeo3/RJOzrwHbwCpqBWSiMTS52KfM4E4JV89wOogvhl4vLh60o2b
 9hG2keijKi4DWyDadCzOTDOZpyKgf7ZyhWBT1TsI17RSZcSyUl57cSd5RfTlT2NIe0b0
 X9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=W1v9REbUjdM2ZPgzn5WvSncnmCktMY/9EZgX6QI0HOA=;
 b=enmDQn2UmJrTXvwvCWNMLE7jceJ+Pq2BJkEJXKXJePCrMdWt4XkXa2I6z7i6kSsa3d
 tKAixcAHwV7rQ286VHxqW2mHgqMR/Xok2mAiQDFA3pVhQo6mPGjMpIPKeoSMYR4dWbWc
 9aDqp3wGWEQ8xkY5sAfi1BfpS5V+/fkZKN7RIeBUn3gJqpFSfmS6ZiZUXz1GX+jV8dRe
 Qm5PoCuybIGQdUdT2pz1j5lSxzDLWPJEEWeX/2g38oIhBfrqu6hhBBe2O/JAtAoJrcLH
 l7fH1stMSsa93HcZhbfkX3sDesQZBen2NcAeRDkBuYXg+cH1z8HY2dGOPIcPG5bAYVyw
 4R6g==
X-Gm-Message-State: APjAAAXQFvl3j/jhwET3QgNO9FmEan58BxI6BdEQd4ZfRFKL67SuhcC2
 qGPOfL1XE9N9DPLqLt1FwFPY6A==
X-Google-Smtp-Source: APXvYqwDjXm2EEI8RDeCs7A5M5DgZpv1lwL8EVk5ylfRpHYYLvhclwPmRsPezAJyTvAyxaG7iZQC7A==
X-Received: by 2002:a37:ef01:: with SMTP id j1mr40587433qkk.163.1561124352349; 
 Fri, 21 Jun 2019 06:39:12 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.55.100])
 by smtp.gmail.com with ESMTPSA id a6sm1525606qth.76.2019.06.21.06.39.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Jun 2019 06:39:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1heJl1-00005R-4p; Fri, 21 Jun 2019 10:39:11 -0300
Date: Fri, 21 Jun 2019 10:39:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/16] mm: use untagged_addr() for get_user_pages_fast
 addresses
Message-ID: <20190621133911.GL19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: x86@kernel.org, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Nicholas Piggin <npiggin@gmail.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 11, 2019 at 04:40:47PM +0200, Christoph Hellwig wrote:
> This will allow sparc64 to override its ADI tags for
> get_user_pages and get_user_pages_fast.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..6bb521db67ec 100644
> +++ b/mm/gup.c
> @@ -2146,7 +2146,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long flags;
>  	int nr = 0;
>  
> -	start &= PAGE_MASK;
> +	start = untagged_addr(start) & PAGE_MASK;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
>  	end = start + len;

Hmm, this function, and the other, goes on to do:

        if (unlikely(!access_ok((void __user *)start, len)))
                return 0;

and I thought that access_ok takes in the tagged pointer?

How about re-order it a bit?

diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e410..f48747ced4723b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2148,11 +2148,12 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	start &= PAGE_MASK;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
-	end = start + len;
-
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return 0;
 
+	start = untagged_ptr(start);
+	end = start + len;
+
 	/*
 	 * Disable interrupts.  We use the nested form as we can already have
 	 * interrupts disabled by get_futex_key.
