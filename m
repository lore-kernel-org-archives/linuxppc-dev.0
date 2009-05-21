Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id AF064DE151
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 08:08:20 +1000 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: Ian Campbell <Ian.Campbell@eu.citrix.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4A15B72E.2070202@goop.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<4A15B72E.2070202@goop.org>
Content-Type: text/plain
Date: Thu, 21 May 2009 23:08:16 +0100
Message-ID: <1242943696.25553.658.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-21 at 16:18 -0400, Jeremy Fitzhardinge wrote:
> I guess the test is checking for a bad implementation of map_single().

More importantly the io_tlb_overflow_buffer is basically a second chance
if you exhaust the swiotlb pool. The check seems to be there to ensure
that the second chance memory is suitable for the device (it's hard to
imagine, but possible I suppose, that it wouldn't be), a bad
implementation of map_single() is a secondary concern I suspect.

If all the callers of map_page did proper error handling this would all
be unnecessary. I guess someone was worried, at least at one point, that
they didn't. The failure case could possibly be scribbling into a random
memory location or more worryingly sprinkling random memory locations
onto your disk or whatever. That said I'd imagine that map_page
returning NULL would cause an oops long before anything tried to DMA
anything and the second chance probably doesn't buy us much in practice.

Ian.
