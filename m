Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C6C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:53:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF5720823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mcakECUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ShhC07mSzDqHY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 04:53:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="mcakECUM"; 
 dkim-atps=neutral
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ShfQ6KChzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 04:51:55 +1100 (AEDT)
Received: by mail-qk1-x72e.google.com with SMTP id c1so5895248qkk.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=00Ms6NJY8XZVY3PTifw/DWKACkhTufevyM9oDDMnZ98=;
 b=mcakECUMzfnWJTjHKTgjHkQ3p5HiWz1AVOeK/ghfgih69htVJO9HDrS54A121ygzVY
 gWLEZMejpsvVFhPFvHwICPJEGrqNyF2/qZcA0NNQdr9DSe7lhxSeAsy3AlI8/ilXz0Wy
 iMjTD05URcYKbnMgowRxCxL/DBUygVp3Sma1XI81k+r9M7o2AAzJzmYJzZpoi21aczm0
 eJeHxiLWuI7hbyS8S+/ZQ0NvTbpWGm3bLAR63L4Lfuo8GetXjU127prX/mYb1aNddl8p
 PasZzEsnYa7YcrBr5PZX7TvDDfzStRfR4EBtHmAXdccRPyo5CD2MDBXpy7Y6pvzdL9FQ
 Mskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=00Ms6NJY8XZVY3PTifw/DWKACkhTufevyM9oDDMnZ98=;
 b=EaAnHciUCcafrRDzpTPN41R7rVj7fmo+NjHLEyDrHDi/2csWdCMiH/2ZxcLDH3vtm7
 uGjtIBr/4S4rrFKY/O9ZpQ8QfCYxEgXgdUM+HFm5amFdA93lCUBJIsUKEUyPErWBuqrJ
 2eWPTQdc+tDDR/nC0s31JQm8APHPzvuiy7q25/YiSn7sZPbsb9b70fFJIu0qpEIL0dLx
 Ol/JaJxx5OeU0UHaub2+2pY3/GKsk68D815vJ7oeta8toeYz7V1AZ6YItFgzIq54DDwL
 Eg4ywHTbl5bFj/Js4NpFNLPw3pGA2Fu2Opt0WSN/MJy9pXq+0gLhrbLGiesijVw2MPr6
 d1eg==
X-Gm-Message-State: APjAAAXDekPwMXgP2hOr6D9gKgs3PRiAXVzoQ9THDmsIX/O9UNQxLr2o
 sb8hYif2h66lCbgIxato7kNwgA==
X-Google-Smtp-Source: APXvYqyPXE4H1Qt/wLb7MTNtAAHDbeoOG7ue4zLWhXEM5KYve0v2wSXPQ09LZ4L0EFTQCEmHdQgrlA==
X-Received: by 2002:a37:7d86:: with SMTP id y128mr20700103qkc.36.1553536312325; 
 Mon, 25 Mar 2019 10:51:52 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.49.251])
 by smtp.gmail.com with ESMTPSA id 56sm5277027qto.57.2019.03.25.10.51.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Mar 2019 10:51:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1h8TlG-0005vR-FG; Mon, 25 Mar 2019 14:51:50 -0300
Date: Mon, 25 Mar 2019 14:51:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Message-ID: <20190325175150.GA21008@ziepe.ca>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
 <20190325164713.GC9949@ziepe.ca>
 <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 02:23:15AM -0700, Ira Weiny wrote:
> > > Unfortunately holding the lock is required to support FOLL_LONGTERM (to check
> > > the VMAs) but we don't want to hold the lock to be optimal (specifically allow
> > > FAULT_FOLL_ALLOW_RETRY).  So I'm maintaining the optimization for *_fast users
> > > who do not specify FOLL_LONGTERM.
> > > 
> > > Another way to do this would have been to define __gup_longterm_unlocked with
> > > the above logic, but that seemed overkill at this point.
> > 
> > get_user_pages_unlocked() is an exported symbol, shouldn't it work
> > with the FOLL_LONGTERM flag?
> > 
> > I think it should even though we have no user..
> > 
> > Otherwise the GUP API just gets more confusing.
> 
> I agree WRT to the API.  But I think callers of get_user_pages_unlocked() are
> not going to get the behavior they want if they specify FOLL_LONGTERM.

Oh? Isn't the only thing FOLL_LONGTERM does is block the call on DAX?
Why does the locking mode matter to this test?

> What I could do is BUG_ON (or just WARN_ON) if unlocked is called with
> FOLL_LONGTERM similar to the code in get_user_pages_locked() which does not
> allow locked and vmas to be passed together:

The GUP call should fail if you are doing something like this. But I'd
rather not see confusing specialc cases in code without a clear
comment explaining why it has to be there.

Jason
