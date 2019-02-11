Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA34C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:00:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7FA2075D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nj2aEaoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7FA2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1VG6pSczDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 10:00:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="nj2aEaoW"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z1ML3JxwzDqcX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 09:54:51 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id u6so253413pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Nnjv+ROc7ciGZ5xFxjkSbI/QboRe6hPG4YjtEvpy/NE=;
 b=nj2aEaoW6CV4dj7N/6ZjXb/iKW8uostTzcE2RJ7/dU28IxKQM0gsJiKq5yyLrtJccq
 tFHOlbx+DBFlEIqVzzEoZ3BpR0DS4D6JClryC8gcvfeXkmnAzc6trASgatfSpRtzBPKx
 XHVwh/d+DXn6bWJekIyggMOq43FhS2oa6VyKjcsi5dvSUU6VEdJ5ASrlnT8Tmikftc5b
 uQX4mGpcXUmDnN1OqLRNLFvtepie6LyvV5ACs+iePwcnbMdDi68KDl3mHdpGNMh4VNUj
 NoVYrB4vF+v9jVKRtPTgAFLZxm55YNqmGmKwpvTZsmD/99r5AYCgAPzRpYq23mlwAQXa
 UZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nnjv+ROc7ciGZ5xFxjkSbI/QboRe6hPG4YjtEvpy/NE=;
 b=QH+Kq/6O65NgzCJIKJE2ZCKTVZqUlTTNu+oI/FdD/JAwcZpOOHOMZOzR4LsVYomJ9o
 dFrVG1N9cbifFs7WfTAAn484eP/kqZjwfYgh487tTyq6nWwanKGgj/UQBoNIEcOcrg0C
 O49FD2dczl+EOEyucz2qH1f3RmWkwiiD7p5cM9r70h2isg8CJWvNuEC1u39JbYDikBIB
 LYiWKDdgRmYN/e9JxAZWxBjM9ux7a2j4eOVjhiApOd0bMMkj6VyogLRClb83o8ndh/Re
 LtSCKD5f1kcEhL+oy/5t1B3tVJKbbyai9KQA4paJDRXFih29Q8UqLxVLDh2uOxdh/cGh
 jq/g==
X-Gm-Message-State: AHQUAuYb0SeZQ8jv7fWkJKS4tY0LDjmgnO44mm8YPVn5gTxJEdX68Lye
 KfZ0rp5INQBuXNpne951Y/C+CQ==
X-Google-Smtp-Source: AHgI3Iay4O9bB9n/pGpyk1kN1tV8bWoIAGTYBHJeUZ6apBJpCJJ/V04jDSGkM/rSMYCK63GYv00hlg==
X-Received: by 2002:a63:4658:: with SMTP id v24mr635737pgk.114.1549925689039; 
 Mon, 11 Feb 2019 14:54:49 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 t3sm2392772pga.31.2019.02.11.14.54.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 14:54:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1gtKTP-0003RY-Pa; Mon, 11 Feb 2019 15:54:47 -0700
Date: Mon, 11 Feb 2019 15:54:47 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190211225447.GN24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
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
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, alex.williamson@redhat.com,
 mdf@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> Hi,
> 
> This series converts users that account pinned pages with locked_vm to
> account with pinned_vm instead, pinned_vm being the correct counter to
> use.  It's based on a similar patch I posted recently[0].
> 
> The patches are based on rdma/for-next to build on Davidlohr Bueso's
> recent conversion of pinned_vm to an atomic64_t[1].  Seems to make some
> sense for these to be routed the same way, despite lack of rdma content?

Oy.. I'd be willing to accumulate a branch with acks to send to Linus
*separately* from RDMA to Linus, but this is very abnormal.

Better to wait a few weeks for -rc1 and send patches through the
subsystem trees.

> All five of these places, and probably some of Davidlohr's conversions,
> probably want to be collapsed into a common helper in the core mm for
> accounting pinned pages.  I tried, and there are several details that
> likely need discussion, so this can be done as a follow-on.

I've wondered the same..

Jason
