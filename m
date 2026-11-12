Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AA606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0au9kCbQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQK4x3XqPz2xmV;
	Thu, 12 Nov 2026 23:12:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794485521;
	cv=none; b=g4DQFyKolV0VRxx4s+YIWnKvdDiYYdih9/p7mrEIZj/y443vR1gR+cSPCC2JnQIo3JiQESkx4YGIVUZJCTLV6KNsYku++NGRTVMXGD+SQXHxF23HHRf+nWFLQqM8Wh/QfLqOXCYDMLTJAhjB/ykV3iTQjMeUJRwyeoAScUf2ppAbMba+tImqX/zxioXLYj9r9eps08idrETgXz7TeF1tvvoKmlosJjW1JQVi7yArlrfqMtjvF7X0g2XwR23PrRfYRalEJLneF9OmUKaIdAYnozv9wyWqINw05Ss9Rln/iSojKgHFVXji1d+8L6I2uwrDRhuVty+ewwLxmjVUh1JN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794485521; c=relaxed/relaxed;
	bh=xc3dkm2FkTj3bfcx1hRbhfim8mfu2/061yvWmQIUcIs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5jzNKS0heij3X5bEgpHUFgKTSMJ/Yd/rjb1HACywlhEfAMPRvq7cKZ5sRHwOf1rRe0+N6oHUco+czYz8JumyfcvvTIpMkxyLygXapqJxSYHZL9ZO/SJHssKj+ZczLHhusez7BgZAOWE2/+frY77+rP9OKdTViX0si5gP9CAoQoSrBFSrVBcB1xCiwXir5N+98QlX23h4a5yoOPNKsYSeeQ8XqCyde0+wW9Fecb5/+T5B/xtXNQLvBpQcWv9XigDUsfiv8e9kmi+4ktB3a8H5f3Octx0acl6xrlmZf/KO3ud5Ow2cLn+YaV/7FvPQjP+Y8nRU3roBpD+qqYTiHL/4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0au9kCbQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0au9kCbQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQK4w0hQDz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:11:59 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1192477a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 04:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794485514; x=1795090314; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xc3dkm2FkTj3bfcx1hRbhfim8mfu2/061yvWmQIUcIs=;
        b=0au9kCbQMErQ9WFgu6y7Vj2yXHuk6wjYwsKtKAPiZ+1lthYm8PzOf3QQdMrJbGDqj6
         DERghk4ps2BSAC8Oa8PPup5NQ3Xm2IFPVVd6l9saccS2cJ9daR7WiKtXfYESgvCGrqXt
         rWIFj4F2KeeFPvh6nTvh2Q5VWguJT+tG+4ZvqnS/O7dRDFJn2sRDFkMKvbo8w1LwvswM
         z3gapE999H7w/Qc9DfLj6RxFXe/RzAgPrIEqLB4uMFysZKgD9yXF0NDU4ShAcBFe8USf
         EtibaI9KKxFF9/Ekh/1gZNQRsDfpjQVBeI9jOh/KjfqpzrPF3Xk/2J/7K4P6wUVTQEHj
         dfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485514; x=1795090314;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xc3dkm2FkTj3bfcx1hRbhfim8mfu2/061yvWmQIUcIs=;
        b=CVlV1AZMWU17iQHic1FHv/0glQYrSr++A7zwngu2NV4BmORgOF5FwV6F/979JbY4Rd
         PiqhwR6N/e3iLI7IRrE3L1GC4deTJsWQNNfXvTY8ahWKa6jPQ7njaGUt0NhMsr0Gya5Y
         va8AsBe94qDH19ad5W+/R93J3N9WHQSdjS3VSybjk14zi0q7rKcW0/mlDUnE7qtRYsls
         dwf+3iyYQWVZ8YzoA9mQM7Sjnce8IJZ6dAjrjCJUYEbbfCx/FoUbziThHgG0XB/q08b+
         lpmmcUf+NBQvz5hVSQxVFocR1c6YBZPtbbJhWy5Xll75O4O/kdU2ZO3mSlyNAnhUvJbq
         2lIw==
X-Forwarded-Encrypted: i=1; AL+hErH1kBktv7z8mIs+4lhbrH64MqWyvUXAZciNSnQqFWK0eDekcgA9xpubE4pjbEv3PGnoH9dZrKp6xzmTLFY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8TEO9EMUaSJnbTlZ8f826pjvLwZMsarqnLTfTNDUWxyuo3xQCL
	rYIMy6qLwqoGh3SIxzGOKDyU+BbCPLC4n/Nzl0YX7X1hN/0Gtesn3xtO
X-Gm-Gg: AYBFou3Bcb1XC4xRSsh172LdZlYEZ42FaRhDF2bblUOoy1uVb0mWeu+pe7LSRHJuA+O
	VM52q5JzuxdZiJSJ/Z515t07DjzqbmcJ7ZG4SzALXulFVe+D6J/lP1LYTB9xPzDOveZ2ouwWYJS
	9KbLmqmtE2O94eHVbz+C4aw91/uxOcTuD1Lsvq8gIg7UyLI5YO0QTjsEvDY1blWIXAWK3ADLWxV
	lGP1ZB1XYcCrHX23E6GOoG1zyC8NjHMRTYIdJf19MFB1Q/ZUu6H+HEEqduymk+aFP2hMpVaw8Xm
	U+MlXNTDkcrnQzr75peUwiNLlR2ZD7maERRuvVR2c+Qqb8ODEh0cM/yOM3ZwVibi6bNa9j3eilu
	9oEkXeG4VPTuKQ8UojvFczDTzmV16J+KgJmkYS4JDT2vj4aLbT64pENcmgWcmQ7AD2FEth+Q0y5
	9ade4J5NHe0onZkLvFy4Hxl8RBCIW1y9IgyhUBLjsIq92FgJW39tp8NkrO90SdZ6I48jr57ZR5Q
	rkEBGibTeE+JS4UgFXS3lskPvIhuEAumHZaaT+/1kvAGJq/BRcgsuY78nS6md64SP3v/g==
X-Received: by 2002:a05:6402:450a:b0:6b5:875a:c2a0 with SMTP id 4fb4d7f45d1cf-6b7775eb13cmr3884877a12.24.1794485514349;
        Thu, 12 Nov 2026 04:11:54 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm1610428a12.12.2026.11.12.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:11:53 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 12 Nov 2026 13:11:51 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 4/9] mm/vmalloc: BUG_ON() on an unaligned range in
 vmap_pages_range_noflush_walk()
Message-ID: <avWtB-nWZUwLdQdP@milan>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-5-hao.ge@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110112546.261415-5-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:25:41PM +0800, Hao Ge wrote:
> The pte loop of vmap_pages_pte_range() maps whole pages and stops
> only when addr lands exactly on end.  An unaligned end lets addr
> jump over it and the loop keeps mapping into whatever follows the
> range.  An unaligned start maps the page below the range with its
> first pte.  That corruption is impossible to debug afterwards, so
> bug out on addr and end at the entry of
> vmap_pages_range_noflush_walk().
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 27f2674a5556..86fbb1d2b27a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -698,6 +698,8 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>  	pgtbl_mod_mask mask = 0;
>  
>  	BUG_ON(addr >= end);
> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
> +
>
But why do we add this? We used to live without it and as far i see
we have not gotten any report about any unaligned addresses un-maping.

The vmap allocator grantees that va->va_start/end have to be page
aligned.

--
Uladzislau Rezki

