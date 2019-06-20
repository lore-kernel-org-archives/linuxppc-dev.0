Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D9C43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 07:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A358208CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 07:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A358208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TtVN2387zDqBP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 17:19:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Trqy6D6MzDr0N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 16:04:29 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id E2B3368BFE; Thu, 20 Jun 2019 08:03:55 +0200 (CEST)
Date: Thu, 20 Jun 2019 08:03:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 3/4] powerpc/powernv: remove dead NPU DMA code
Message-ID: <20190620060354.GA20279@lst.de>
References: <20190523074924.19659-1-hch@lst.de>
 <20190523074924.19659-4-hch@lst.de>
 <db502ec4-2e8f-fbc3-9db2-3fe98464a62c@ozlabs.ru>
 <20190619072837.GA6858@lst.de>
 <b0ce7d72-5de7-63d3-cb4e-ea78342cb3fa@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0ce7d72-5de7-63d3-cb4e-ea78342cb3fa@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Linus,

this goes back to the discussion at last years kernel summit, where
we had the discussion on removing code never used by any in-kernel
user an no prospects of one.  The IBM folks are unfortunately still
dragging their feet on the powerpc side.  Can we revise this discussion?

The use case here is a IBM specific bus for which they only have an
out of tree driver that their partner doesn't want to submit for mainline,
but keep insisting on keeping the code around (which is also built
uncondіtionally for the platform).

I hope we had settled that argument back then, but it seems like Big
Blue insists they are special.

On Thu, Jun 20, 2019 at 11:45:42AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 19/06/2019 17:28, Christoph Hellwig wrote:
> > On Wed, Jun 19, 2019 at 10:34:54AM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 23/05/2019 17:49, Christoph Hellwig wrote:
> >>> None of these routines were ever used since they were added to the
> >>> kernel.
> >>
> >>
> >> It is still being used exactly in the way as it was explained before in
> >> previous respins. Thanks.
> > 
> > Please point to the in-kernel user, because that is the only relevant
> > one.  This is not just my opinion but we had a clear discussion on that
> > at least years kernel summit.
> 
> 
> There is no in-kernel user which still does not mean that the code is
> dead. If it is irrelevant - put this to the commit log instead of saying
> it is dead; also if there was a clear outcome from that discussion, then
> please point me to that, I do not get to attend these discussions. Thanks,
> 
> 
> -- 
> Alexey
---end quoted text---
