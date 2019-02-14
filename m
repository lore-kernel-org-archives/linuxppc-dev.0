Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FCFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 22:18:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC2020823
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 22:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EmWX0F+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC2020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440rPc6gVszDqXN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:18:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="EmWX0F+U"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440rMk3zq7zDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 09:16:34 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id c123so3804986pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=t1hVwJWaLn2x3podPvX+xTLteVECyauDZZjQoDe0D+0=;
 b=EmWX0F+U8QlHwgyOQyU7/GpC3WglrqT05XbL6OtUXhmICyYGqD//fSe0HIl+i8ygVj
 KLImM7wLgwqYgwHC38M8+IdJpGvQF7STuPF4slPbpqRbJi4onN9XO0pxqn7viPOReHoA
 yD50Kc68GMkGWx3uRxx22P3bY9gTYJmFuwYuPUXwzZF+V0RVlVT+vctp2K+b0qkFvJIn
 S42lTYn684RC3NIapzX5v7GhbOGbCpPUAGz94OauM4EFokmqxeIVwCBS8XRmddSLSnkA
 XfaqPTxJ+62cn994jdfrHXkNizC58LofY5+68+iTjn1jXJqa3vqLrTUAPaCHMxON+wdK
 8Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=t1hVwJWaLn2x3podPvX+xTLteVECyauDZZjQoDe0D+0=;
 b=Pr0NLDdvLhr70Zwt3CKQoYxQcAOVaSuvCYQ2TwZ46wBG4zhHuxuy8LdhiWEplHq3/f
 m2ehw8JuW6o0hZT7ffufVY9AJUCvEHbJUKK4Zj/hutCA8qcjDdKDHnVu6I8jcGHoEJhG
 m7dzAZ4UKdgFhb2NCvyGaXWIPyhMsc0RPp7kH4NmzrHyDDsWFGnwgxdqrcRp+r70brjz
 EiBBggjj91ZUpoGQA4PRT939M48ELxmcU2g9/RDJqgzNCOpp5TttdVcVCtwdbIf6hUV0
 GbBl6HHH3RarXxcyfpkaNHjv3XjwVRi3jXQBtzanwXOQRZ/qAU5IeKyssTi+nxN9ki1c
 d66Q==
X-Gm-Message-State: AHQUAuZD9fzy9NPE8WdPrL/9ut9A16cKS4/Lvi3KhbgNQR9c1FC6hMuQ
 alaXeN5tz8emTIoANd8Op+Zu+w==
X-Google-Smtp-Source: AHgI3IYc8C5MWgcYOAWGTiHgiPL4HnY4upCes3+oFK6jZQx1q2Z66Zc0aNY3zCVaegBZFxjxNhBD3g==
X-Received: by 2002:a65:6249:: with SMTP id q9mr2077195pgv.229.1550182591612; 
 Thu, 14 Feb 2019 14:16:31 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 l73sm7556152pfb.113.2019.02.14.14.16.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 14:16:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1guPIz-0005gz-UH; Thu, 14 Feb 2019 15:16:29 -0700
Date: Thu, 14 Feb 2019 15:16:29 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214221629.GD1739@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
 <20190214201231.GC1739@ziepe.ca>
 <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
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
 linux-mm@kvack.org, alex.williamson@redhat.com, mdf@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, cl@linux.com,
 hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 01:46:51PM -0800, Ira Weiny wrote:

> > > > Really unclear how to fix this. The pinned/locked split with two
> > > > buckets may be the right way.
> > > 
> > > Are you suggesting that we have 2 user limits?
> > 
> > This is what RDMA has done since CL's patch.
> 
> I don't understand?  What is the other _user_ limit (other than
> RLIMIT_MEMLOCK)?

With todays implementation RLIMIT_MEMLOCK covers two user limits,
total number of pinned pages and total number of mlocked pages. The
two are different buckets and not summed.

Jason
