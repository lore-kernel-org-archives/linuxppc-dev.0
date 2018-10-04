Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3ECC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:32:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD8A213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD8A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QjjY6BNMzF3F8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:32:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjKB2f4BzF38J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42QjKB15GVz9sj3; Thu,  4 Oct 2018 16:14:38 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjKB0TGvz9sj8; Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: db6711b7a17f03921e734e11e3a1e9bccb28bf46
In-Reply-To: <20180920094111.4125-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/perf: Add missing break in power7_marked_instr_event()
Message-Id: <42QjKB0TGvz9sj8@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
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
Cc: maddy@linux.ibm.com, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-09-20 at 09:41:11 UTC, Michael Ellerman wrote:
> In power7_marked_instr_event() there is a switch case that is missing
> a break or an explicit fallthrough, it's not immediately clear which
> it should be.
> 
> The function determines based on the PMU event code, whether the event
> is a "marked" event (which then requires us to configure the PMU in a
> certain way). On Power7 there is no specific bit(s) in the event to
> tell us that, we just have to know.
> 
> Rather than having a full list of every event and whether they are
> marked, we pull apart the event code and for events with certain
> values of certain fields we can say that those are all marked events.
> 
> We take the psel (bits 0-7) of the event, and look at bits 4-7. For a
> value of 6 we say that if the entire psel == 0x64 then if the pmc == 3
> the event is marked, else not, and otherwise we continue.
> 
> It is then that we fallthrough to the 8 case, where we return true if
> the unit == 0xd.
> 
> The question is should the 6 case also fallthrough and check for
> unit == 0xd, or should it return.
> 
> Looking at the full list of events we see that there are zero events
> where (psel >> 4) == 0x6 and unit == 0xd.
> 
> So the answer is it doesn't really matter, there are no valid event
> codes that will return a different result whether we fallthrough or
> break.
> 
> But equally, testing the 6 case events against unit == 0xd is slightly
> bogus, as there are no such events. So to make the code clearer, and
> avoid any future confusion, have the 6 case break rather than falling
> through.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/db6711b7a17f03921e734e11e3a1e9

cheers
