Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7DDC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 15:29:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D33D206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 15:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pi+EHYZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D33D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZY2h4g3SzDqf5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 02:29:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pi+EHYZI"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZY0q47pzzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 02:27:54 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id n2so3455806pgm.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2C2snWHRKLn4kJkXeCP/a0zp+l931OoPJBmot/AY+to=;
 b=Pi+EHYZI8+1oSpoFdQsBOc/c6MrQgQnuh5OclYtJ8xs+7ULX+FfM1A4Cjq6EWahovv
 DoZ+qy6g/3Cps2qzTs9+D6QUr+4TqTcLZMM9vepBc9Sfh+5RT3Ey437A0kDaSlozKrZT
 k3c0AWq23fvEd9fOTemTlyISYThWPBBdUbKT6/mnwdHkH209I084DnU0tYtzbMFXm+eb
 vw2MdD2zyhx+YyGFRXUpt9QLLpXO/6Y03RLNj0Y3PCZRerL3gchzOBALO6LjMQzDIWxx
 NIYuDv2FYJ7RC//2nud0BZhT0HINYs81IlQZZ4AziLrs1o4hKw67r1QEpddBiCNPl81X
 5q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2C2snWHRKLn4kJkXeCP/a0zp+l931OoPJBmot/AY+to=;
 b=mvmxGbjumD9spCs5BCrWNK80If522Imq/hzU27PM2pwMhUV9ov/FS4DFZUa8c5oquE
 QxODgEruQtH69bfMfYOBzs509shn29gT+9VW/P/kn6uNtHH5oEPZTLAADgNBGAQYl83T
 QMMWuiDGdOcYBXDv+WUtjYTOf1ilbRv746hOm2n2x/MMaEN+4875kUB8qTrU0opLHHbp
 TR6AUUciDjr4EU3A7969ptAJaXUlz+hsLVyPcg9q6B3E0hiOFtpzBatQmGK43wV41s23
 gBbYfWscggyJek/iKkQE1Qy4bdVp5s7IWwHIsY5sZD+/mN0WGV3SMxr/pg65SF4fxBwD
 fYBw==
X-Gm-Message-State: AJcUuke71jTgjKmUOFTWW2o87fOyMjR/1OHAmjSDw4G/xu+gYOnLVjx2
 z7flAJH5H4TOhX9SPumiGu5HBg==
X-Google-Smtp-Source: ALg8bN5PTEFkU4DezniC2nJ1wMZFeOhp+djX6Fu+GXxks1fE0U3Rr6SDT2Jtedp2XLffR6m4r01rjA==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr5796633pgh.30.1547047671865; 
 Wed, 09 Jan 2019 07:27:51 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 f62sm88015706pgc.67.2019.01.09.07.27.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Jan 2019 07:27:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1ghFll-000255-FV; Wed, 09 Jan 2019 08:27:49 -0700
Date: Wed, 9 Jan 2019 08:27:49 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20190109152749.GA6890@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box>
 <20190105175116.GB14238@ziepe.ca>
 <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
 <20190108040129.GE5336@ziepe.ca>
 <012d24d58a542ed44c8af9f517f1bd61ab912037.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012d24d58a542ed44c8af9f517f1bd61ab912037.camel@kernel.crashing.org>
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
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbest@redhat.com, saeedm@mellanox.com,
 alex.williamson@redhat.com, paulus@samba.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ogerlitz@mellanox.com,
 David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 09, 2019 at 04:09:02PM +1100, Benjamin Herrenschmidt wrote:

> > POWER 8 firmware is good? If the link does eventually come back, is
> > the POWER8's D3 resumption timeout long enough?
> > 
> > If this doesn't lead to an obvious conclusion you'll probably need to
> > connect to IBM's Mellanox support team to get more information from
> > the card side.
> 
> We are IBM :-) So far, it seems to be that the card is doing something
> not quite right, but we don't know what. We might need to engage
> Mellanox themselves.

Sorry, it was unclear, I ment the support team for IBM inside Mellanox
..

There might be internal debugging available that can show if the card
is detecting the beacon, how far it gets in renegotiation, etc.

From all the mails it really has the feel of a PCI-E interop problem between
these two specific chips..

Jason
