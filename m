Return-Path: <SRS0=Jsh9=UU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A45DC43613
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 13:48:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010E0208C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 13:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iFE5ScFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010E0208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Vg4K1FMKzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 23:48:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="iFE5ScFS"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Vfvb3xLDzDqcP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 23:40:27 +1000 (AEST)
Received: by mail-qt1-x842.google.com with SMTP id d23so6943209qto.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZCrivaPmWHSHjQSdgEw4GI/j98fJxtxh9tp1DIhn9Pk=;
 b=iFE5ScFSlA9eaFIsPJU8p0w1qOx41yW1vrAuYeo+l9Q0KwpkxwhaD346XR6CI3LuMu
 FsUTSf6vE97JnP3EPZrFn46YHJ7vRTKevOvCMH1mna8IGtNFXf48ywkiIrsuxvMz1Lyo
 73WFQX5rdb2D6muLva15ZoWDq9Kj/YcD/y2bpNGuMg6dRxVmYAap99xfHkj4krlsmpA9
 WLzb7MYs8YrQkoW/Cq3RrCPIBJ2bvt0kiEleJq5K2k1LS5IcxoG3chSgmdVQLBLoizx0
 yMC2TCuZc1Ce7lhLmgcinzihQvYINNi8qNCu1nQLWvdKkjW4U7948HBdCkUlKYsn6Uth
 DaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZCrivaPmWHSHjQSdgEw4GI/j98fJxtxh9tp1DIhn9Pk=;
 b=seqD6B7AhiwN65I9Mg8MCVNg/dVqu7ASIdsoCDXtXBhMMbFk5MVn8OFZdngxYIJhov
 DFVJKBT47rSg6qe+Lja0wAWOQISMqx8sEPPGvmhjXbYXNXHWRT4k+MYeAJv1RMzH46qK
 my7DU89+/FsELI/FKOHgW4Ps7OZscyeo1cvaN9zZIL82oaPL2N1SADJ8UODNiG4yk6W/
 86sX/R59G24KYBcJvE4b8WooV1I2aP2/ZQX++VdjV5A2G3O0WHc14jCMnunhlAq9QnvF
 UpLazOdhmuCksZWyX3nWKlm9C1elRAi/WNYoODCkv4cOXHhrTRKYKXQ/ATytGcEeCJD2
 wmUA==
X-Gm-Message-State: APjAAAV68J4dcfC9tt1xbxb6pS+qy/ygBmuRTrwpFUI/IOcYWv9u8CoL
 rRsf6p1jnp+SMsCiI4hFQCCZbg==
X-Google-Smtp-Source: APXvYqzfk92nAm4v0PC/p+cfLaUPeFmmoTuTFE99jGSQ5m486NYHbLSajeoJYynPCh/suXX0ETWpgw==
X-Received: by 2002:ac8:17c1:: with SMTP id r1mr115641302qtk.41.1561124422594; 
 Fri, 21 Jun 2019 06:40:22 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.55.100])
 by smtp.gmail.com with ESMTPSA id i22sm1837536qti.30.2019.06.21.06.40.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Jun 2019 06:40:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1heJm9-000060-L5; Fri, 21 Jun 2019 10:40:21 -0300
Date: Fri, 21 Jun 2019 10:40:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/16] mm: simplify gup_fast_permitted
Message-ID: <20190621134021.GM19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-3-hch@lst.de>
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

On Tue, Jun 11, 2019 at 04:40:48PM +0200, Christoph Hellwig wrote:
> Pass in the already calculated end value instead of recomputing it, and
> leave the end > start check in the callers instead of duplicating them
> in the arch code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/include/asm/pgtable.h   |  8 +-------
>  arch/x86/include/asm/pgtable_64.h |  8 +-------
>  mm/gup.c                          | 17 +++++++----------
>  3 files changed, 9 insertions(+), 24 deletions(-)

Much cleaner

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
