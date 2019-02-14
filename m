Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752F0C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 20:14:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723C02229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 20:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hA9VncW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723C02229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440nfM4JP5zDqZS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:14:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="hA9VncW7"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440ncj1nq5zDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 07:12:35 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id h1so3637728pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 12:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ccxzyt/RMKZ2OOmgM+tFIm3eRFm02Zizg0pcCDEvEpA=;
 b=hA9VncW7abr9v+2utX/VkY1ZMwjjXa+hwVTodjREfjCiB0K7/Kc1hdBbZP6VIclrft
 XOlV/kBSodmvMnJmU6S+VCif2RbCUEwe4jiK021/ptlayI1p9QvtTplnf6hXcgW17wb+
 QnehE0OatJE+W6+9FVvKXjsQS9WlMlC81CJMTIZkDJ4RfuKrLjfzhp/2YUPNRFY/w0Lc
 aUTkEhbENTvNIWFJCqAuRCY2ROYZ4dZzB+xqdPWBbhLmA24jTl0pTqeeCY5bZatXCoQw
 abmHXi9B7hQUHXsFEubY8QrdE6yffwStU9kEa6Ykk1vfsXxhwe1xCEIBVbJx8CT9RHfQ
 tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ccxzyt/RMKZ2OOmgM+tFIm3eRFm02Zizg0pcCDEvEpA=;
 b=oGAqZE9qEOvPr8IVrYmji+J2DKEui/eqVXYNNiZO3NZ9PuvpPyLoQqFbXy6VBOOFr4
 +6VgbAX6nejnQ1B8xq/l5rRSSARiCO8dV8/UWuPB/pgaJw9etClcoeoNjCjRuEn6Bb+v
 ++EEHcpgN0uWHUKYpEyTU3dZS/BmiEDOBayedhk+S7zQkx70zw3ces6XLdzeE8XrRuay
 8rwmHmd3byeJLzCkafj0qBBkeOO7/layxPTEsD6yvfTWAA8IsLZ6IPJK6KtcXx0MmPvj
 e8RQ/v7PkHR3Kq64fRmdV9tee77/99wObbS/159fz+2RsKELn2L6z9xjmg+P0LFk3a0n
 QudQ==
X-Gm-Message-State: AHQUAuaz/ic1Xc72WlmvDihmIuWs/m6pmQ8Huiohq7R+Ij5qlOabMu3c
 qjiN7NVCq1eJrbC0CGC3cFVsHw==
X-Google-Smtp-Source: AHgI3IZWZ0MGPLsLn4wrH2r78+5Tb6L2fudxI7tZh+KJRQfM13M8w4S/vvhozZ+3+r9nH+nNGegkWw==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr5944270pfi.31.1550175153085;
 Thu, 14 Feb 2019 12:12:33 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 q21sm8921770pfq.138.2019.02.14.12.12.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 12:12:32 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1guNN1-0007Ay-MB; Thu, 14 Feb 2019 13:12:31 -0700
Date: Thu, 14 Feb 2019 13:12:31 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214201231.GC1739@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
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

On Thu, Feb 14, 2019 at 11:33:53AM -0800, Ira Weiny wrote:

> > I think it had to do with double accounting pinned and mlocked pages
> > and thus delivering a lower than expected limit to userspace.
> > 
> > vfio has this bug, RDMA does not. RDMA has a bug where it can
> > overallocate locked memory, vfio doesn't.
> 
> Wouldn't vfio also be able to overallocate if the user had RDMA pinned pages?

Yes
 
> I think the problem is that if the user calls mlock on a large range then both
> vfio and RDMA could potentially overallocate even with this fix.  This was your
> initial email to Daniel, I think...  And Alex's concern.

Here are the possibilities
- mlock and pin on the same pages - RDMA respects the limit, VFIO halfs it.
- mlock and pin on different pages - RDMA doubles the limit, VFIO
  respects it
- VFIO and RDMA in the same process, the limit is halfed or doubled, depending.

IHMO we should make VFIO & RDMA the same, and then decide what to do
about case #2.

> > Really unclear how to fix this. The pinned/locked split with two
> > buckets may be the right way.
> 
> Are you suggesting that we have 2 user limits?

This is what RDMA has done since CL's patch.

It is very hard to fix as you need to track how many pages are mlocked
*AND* pinned.

Jason
