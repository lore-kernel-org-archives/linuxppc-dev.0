Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7FBC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 06:02:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04F921934
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 06:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AqFGGKQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04F921934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440QlD26yrzDqW7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 17:02:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="AqFGGKQk"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440Qj72yWfzDqTv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 17:00:10 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y1so2458333pgk.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EyhZ0LXI8S6DO+1lKPJ+3xCo7Hi2M9DApl/OXP8GRG0=;
 b=AqFGGKQkWIE4m9oWUPQKPfYDWffEV3DD3kw2gte/hIVc+ZOI2ALww287MyZktoOcDi
 CbpDfqNDDxjQTYKo+HSL1jPCcxgIu0tlHCqsVDa+M5KY9ZBsLFTmv/t2wqc5kisOEAq3
 Ey9IsWcwZPCXnG/nVFmz7GUhhGKdm8IWeTP2Dk0HwbmuU3cqx7K5BZzuoEE5qUenFwFw
 FhXuEgKL+2MrnrRuMG0A1nR+NYB/69dpYPvc7V/phtqqydIA5J2EkPID7AxDk9lsLjAP
 NbaOeXfbMwnJ+uPtI2ATX/eErFA+0vBz71ipAT/cQzRY+HNlZcQmNhta5uk0wuPGbr4p
 3GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EyhZ0LXI8S6DO+1lKPJ+3xCo7Hi2M9DApl/OXP8GRG0=;
 b=rqN9ZUxhcCyXhYnlw/jKdcjMttov6hlfTfsWNUFhMTm19FZeDmmEHiszYKOERHSq08
 +5YjL7zIBwD+gj8h/a2KRAL2j+YJbpDacR26gpJvD0V/zVKL39nCE9Wi581KUXCtV+bX
 mMWUfxWHXigc4Hgpa1goytjH7gzH2Su2+xbQ26Gf59Fk+gjrcyPd6nbfOd1RIAdUJKJB
 xdo5OmODVRvG6dL4A+X6IMcMEQsA7nqDf0o+ijPzXEPgaVG3v/jkvEKcP1oCbWWRinlT
 VJiS+mOhD6JwdVZY1m4tyFCkLvvja5xUfafiZIIU4fNvYBku1beRMQHqc5B2WC/WBow8
 9p4g==
X-Gm-Message-State: AHQUAubyeooaM1fH+SZNOjgfZ0indYsOIOMyMmDyfjz7NQp5AXvErBOR
 +i34AeL9bK2naODLjUlz9TyGeA==
X-Google-Smtp-Source: AHgI3IZsTuAr/2agKNUI6fHNmik1DYYjhaWBR5rn+7baCxky03ZS5RyeSxDZdNqDP/QzwRlb2m6TAA==
X-Received: by 2002:a62:9f1a:: with SMTP id g26mr2297647pfe.123.1550124008008; 
 Wed, 13 Feb 2019 22:00:08 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 z127sm2288820pfb.80.2019.02.13.22.00.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 22:00:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1guA46-00040P-Jk; Wed, 13 Feb 2019 23:00:06 -0700
Date: Wed, 13 Feb 2019 23:00:06 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214060006.GE24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
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

On Wed, Feb 13, 2019 at 05:53:14PM -0800, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> > 
> > > All five of these places, and probably some of Davidlohr's conversions,
> > > probably want to be collapsed into a common helper in the core mm for
> > > accounting pinned pages.  I tried, and there are several details that
> > > likely need discussion, so this can be done as a follow-on.
> > 
> > I've wondered the same..
> 
> I'm really thinking this would be a nice way to ensure it gets cleaned up and
> does not happen again.
> 
> Also, by moving it to the core we could better manage any user visible changes.
> 
> From a high level, pinned is a subset of locked so it seems like we need a 2
> sets of helpers.
> 
> try_increment_locked_vm(...)
> decrement_locked_vm(...)
> 
> try_increment_pinned_vm(...)
> decrement_pinned_vm(...)
> 
> Where try_increment_pinned_vm() also increments locked_vm...  Of course this
> may end up reverting the improvement of Davidlohr  Bueso's atomic work...  :-(
> 
> Furthermore it would seem better (although I don't know if at all possible) if
> this were accounted for in core calls which tracked them based on how the pages
> are being used so that drivers can't call try_increment_locked_vm() and then
> pin the pages...  Thus getting the account wrong vs what actually happened.
> 
> And then in the end we can go back to locked_vm being the value checked against
> RLIMIT_MEMLOCK.

Someone would need to understand the bug that was fixed by splitting
them. 

I think it had to do with double accounting pinned and mlocked pages
and thus delivering a lower than expected limit to userspace.

vfio has this bug, RDMA does not. RDMA has a bug where it can
overallocate locked memory, vfio doesn't.

Really unclear how to fix this. The pinned/locked split with two
buckets may be the right way.

Jason
