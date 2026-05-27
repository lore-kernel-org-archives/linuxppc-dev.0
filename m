Return-Path: <linuxppc-dev+bounces-21599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B359CCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 16:07:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQZJV2G0Fz3cnS;
	Thu, 28 May 2026 02:07:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::830"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779898042;
	cv=none; b=RlDn5WJUUHk0i0qhjtHsWyiPQofKlov/SBsC2zz9jLDOa6ODxnrXGo7cDBAXG4oJzs07dfM1xTHUGN5PdVGEZOJjwCuudZi9HSz8hCm7Podsq3/pqxw7RCn6Ezw2UoEQJy0LspF0oHNjNY0BzLtPJibCMKZtAseNy/OO+wKv/u7ZTlN7Y1PA2UlWMgn8rRbDhUVdvghQgDjtBxcdbIolo3XQDkE4gS9BFlltFHGNhe4kRCCjt0+dFZ9l5vuVRq4MHyP+x4/HNCNWEdO430fS5kjseXvnwChmeGtVhFW/1QdbPo1CVcb72ZCPxCvlr5b9DBgPFTgnOdv7l5BCJ6Yhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779898042; c=relaxed/relaxed;
	bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiJ8OfN8ljDIZoLKkAiE4jEo8Cl1JwdWgWVskB/edB5KLD8e5ExOp1ojOPdUV1QoVSoiTEQIqGtECetQWqrxVAU7Wjak5RUomzuqKA/yqa4FzrmhP6sHx3peIqk5thvK5kp3QuWgHF+HS2YqEZu4kNGmrsHH+RYnUe0Zvad1XZoS+JiFBjIEk+P78WYnkAldyODSdnDzh9uK8f0ZUu9KD8EJKMC7AIH7h24wzVafqKpYlyIVkrjaRNHzk4pCyLlL4aH9tW+Uf48ZhkuQl3thdcVcKnDPvDetRJQT+E6OvIWE0gId0wO01RYBa3cPLI1ZtV2ujCZ89YfMKKeYBLgZIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MPRhinmG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MPRhinmG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQZJS467Mz3cZd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 02:07:20 +1000 (AEST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-516cbde40f2so68114431cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779898037; x=1780502837; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
        b=MPRhinmGlXigVBPAPbsjzzEAoMPz3FR8et9jYBFU2IBnQH15goE3PIvV2084SOe5uA
         yd0yjlUBUfo+nw07ZeIwq2mEpINlPsfUiAxD1Wda/PJPP6RZd6PnRc55aUSdS0O2ZrE7
         bp4gJ7O9MZ4sPGPjM66sbNwsI5W+bBiI4EH4AFdSdOXviw/1baz3+P670+ovLaVAvZrC
         zEGFaRE6w+rbf2JuYIh8eVv+ga7Qh3UuaMy4Wv60nXgrUGhNlqSQRXTOBYz12KYyjZlH
         7U+P0eqBxNCYM3Vjycuu341RewI8wL6qfH2lkU6UjCX9rWAtcutyqq0UHEQTjJXSH9YO
         NFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898037; x=1780502837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
        b=VGA1JIoGiDaWodVJCUwmnYdoLPH0cd5GC4/DCPw1wmIi104mK7JKrIN21Loxg2z5gf
         2EHXTo4qGXqfb+cs9sNq6wamLnLqNul6fFbKbBZVD+tis9UgqnhLcIFyLpT5dTpgBBc9
         Wwu2mwJmvk9PjqbiLDaL/OXu2XNli/fzrX4y4VpsC5gw6s+exawZ1GX1uz4je77d1cdV
         YqDFB4+14rkjfgLFzfiN4XBdR8RYHVoOmOQSoXLoPaycDyk9771Q4Y6FRysqXJY2Ydm+
         /9eFmzktVU7XFRG8R4FT/kZSbkYARo1NLxcCtarnunUPLXZJquHkiGA7JGVcKo8i5TgW
         H8QA==
X-Forwarded-Encrypted: i=1; AFNElJ8wzcCMelN+vW7yBNExrltV7/UQNeouLXV2tWBAQ8heHqs2lM3o4VmsOGHs2ClaI1qC8dIDFWGqePakSMg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmNbP3M7ffCUownFqZwS/thYn7zI/HQUm6/FsMk6mbEYz4+6SE
	2V47HJ5Hv3Ro/93wQLVoen/sAiXxXB6TDa0dRy3yp4tG26k28cvVO3OOcLElIoNtjZQ=
X-Gm-Gg: Acq92OG1lc3znGzY+qdz0KMaHJRUkp7r7ZT1L8FARFlX1ZCC9VwxkiCu5sYVMbHgaMs
	Eih8tZG95ZFwSE6V+9zg4v/mNwXIE3c8BffU5DBaZTaXdDXf3SfbhdckFUkpySn8BzFP285xFub
	brnPy4C0J41/1BOuix1TezNxqFVhey0sr6WJZgQOLLWgRH9HCmwyymtRNq+nWhJTq0vzRltym9g
	HEDnf+nOwLTg/n/cp+8XWrDPUZIZYm9RaEN1G2IzQ1xyEchHmJNLV9/mL0/uvPIA4f7l+3yX8rn
	4vyiJqDiVKdyP3E8RRF+/nayDT0Wy+LPxREqoFVlXLU+bOg/3ySUs4WjqmyOH5jV7Pt+BFkafuP
	zRWOM/AfcQLwyvjOYzhTINVj2b4PPiyXhjmK3jq6nmxJDywICGo87ILkCOVSQ41OkRf/oeCg1kZ
	VscsvldEFufRVSWLKmefNkXGOnOCHIpi1VWdzgR4jLWR8W7YEmx5jx0B6Fy9PZBakGfLRNgwlL9
	5V90g==
X-Received: by 2002:a05:620a:1b89:b0:914:c246:aca0 with SMTP id af79cd13be357-914c246b146mr2808635885a.36.1779898037030;
        Wed, 27 May 2026 09:07:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e8e13sm505133685a.2.2026.05.27.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:07:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSGmq-0000000FI8B-0NaX;
	Wed, 27 May 2026 13:07:16 -0300
Date: Wed, 27 May 2026 13:07:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mripard@kernel.org,
	sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260527160716.GN2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPqbfH54R3JJyaV@infradead.org>

On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > module") the system dma-buf heaps can be built as a module. The
> > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > but those functions are not exported on powerpc. This can result in a
> > build error like:
> 
> I'd much rather revert the above commit.  Yes, x86 has exported these
> since 2017, but that's a really bad idea, and we should fix it instead
> of spreading the export.
> 
> Setting memory decrypted is a dangerous operations and should only
> be available to core code.  We should have various allocators for
> decrypted code, but not export the functionality to random code.

At the very least an EXPORT_SYMBOL_NS.

Looks like there are about 3 modules using it already..

Jason

