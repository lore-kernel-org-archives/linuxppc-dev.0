Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570DEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:09:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9136F2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JpZ8ZbCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9136F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440Fb61Gk7zDqXG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:09:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="JpZ8ZbCo"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440FY04RKkzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 10:07:31 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id p8so1959861plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ycGZ/lql/XedLXMhQw613j8q5/nW7HtOXu0fJma7tbU=;
 b=JpZ8ZbCoGmgsStGrD7Ces+eiaAcEBDwP2MwHm1odgXkmFHZ61NwFL4leS20cW9WLfo
 FGa7uTtaOlqE4a7hhtN87sFCdcCrbr3+9j+g8Zt/SEDaGmT1DL6reEqmJ+sl9zPfB/ZL
 sIvXBaZIjR95Sae1LORKUqxDVbVAdr+AtYHnQl+AMJJuZk44ObCM+ljD1a66/KrTAs1u
 uQuAyBu/AGqV21vCZmuyQyTqyTcG+0nfpmGMLnXNosPfVrazfmWI/04pmdJ2OPq1avXF
 +ffFBzKHBjoz5yrs/5QRZCMudXVQUio/NrXOJ/xwNF8mKZP97g59R7MdV+4bD0TjA6yW
 JyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ycGZ/lql/XedLXMhQw613j8q5/nW7HtOXu0fJma7tbU=;
 b=QDwq2slwN66vaiTvLR2sXSkBGFXLY9HnbtjCRDPvlyk3zyT+474oA0Ono5k2rI+tDC
 qG0ULbndR/2BqYnYsb5DVx0m1Fsfxgh6sznOHqnmjyhDI7BDuD6Gw2js74WGml67+tNq
 mj60dwQWyIAbSRDTD+jVIoxRkFJeF6bc3lVaLBT7qJgI6ZOYUaQOgrIbAhZo4nhPB1BL
 UR9JsC6wSgSkI3Jsl0Be+/ffn4tbNxdk6Kt3IQgMDjKmjo/faZMlIMW+DbLW9qh4JlLQ
 Vy+DydVHZHPii/ZlzkjfYZTch8JCPBjPQLbZLL8Gw1Tn+AtSiviS6DiXL2ygRV5M4ucn
 XQaw==
X-Gm-Message-State: AHQUAuZ2/aZnwQGoNDJ4iC27lCI1cofwgri+DO85dVQJQYpoB2CkZIZC
 qxz1T86FkysX1bYfI7YGheV3wA==
X-Google-Smtp-Source: AHgI3IbZxmz9Cji7ywEHkD4zdpRd9ZWq16bVDbDKyOfZsY/wyvM5SVUNTc9mXDq5Bsx5HN2KKJx0pw==
X-Received: by 2002:a17:902:b489:: with SMTP id
 y9mr666527plr.193.1550099249465; 
 Wed, 13 Feb 2019 15:07:29 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 k71sm454104pga.44.2019.02.13.15.07.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 15:07:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1gu3cl-0001KE-SJ; Wed, 13 Feb 2019 16:07:27 -0700
Date: Wed, 13 Feb 2019 16:07:27 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190213230727.GC24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
 <20190212114110.17bc8a14@w520.home>
 <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
 <20190213130330.76ef1987@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213130330.76ef1987@w520.home>
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-mm@kvack.org, peterz@infradead.org, mdf@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, cl@linux.com,
 hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 01:03:30PM -0700, Alex Williamson wrote:
> > PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
> > locked_vm accounting separate, but allowed the two to be added safely to be
> > compared against RLIMIT_MEMLOCK.
> 
> Unless I'm incorrect in the concerns above, I don't see how we can
> convert vfio before this occurs.

RDMA was converted to this pinned_vm scheme a long time ago, arguably
it is a mistake that VFIO did something different... This was to fix
some other bug where reporting of pages was wrong.

You are not wrong that this approach doesn't entirely make sense
though. :)

Jason
