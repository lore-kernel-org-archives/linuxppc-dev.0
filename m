Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id A66F4DE1C8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 05:12:08 +1000 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: Ian Campbell <Ian.Campbell@eu.citrix.com>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 21 May 2009 20:01:37 +0100
Message-ID: <1242932497.25553.230.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-21 at 14:27 -0400, Becky Bruce wrote:
> We have both in every case but one,  
> which is in swiotlb_map_page where we call address_needs_mapping()  
> without calling range_needs_mapping.

The reason it calls address_needs_mapping without range_needs_mapping is
that in the swiotlb_force=1 case it would trigger every time. If
address_needs_mapping and range_needs_mapping are merged as proposed and
they do not subsume the swiotlb_force check (and I don't think they
would) then I think this will work fine.

> It's not actually clear to me that we need that check, though.  Can 
> someone explain what case that was designed to catch?

If map_single fails and returns NULL then we try to use
io_tlb_overflow_buffer, if that is somehow not DMA-able (for the
particular device) then the check will trigger. I would have thought we
could arrange that the overflow buffer is always OK and really if
map_page is failing we must be close the edge already.

Ian.
