Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4555ADE1B2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 06:19:01 +1000 (EST)
Message-ID: <4A15B72E.2070202@goop.org>
Date: Thu, 21 May 2009 13:18:54 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
In-Reply-To: <E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Ian Campbell <Ian.Campbell@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> I can work with that, but it's going to be a bit inefficient, as I 
> actually need the dma_addr_t, not the phys_addr_t, so I'll have to 
> convert.  In every case, this is a conversion I've already done and 
> that I need in the calling code as well.  Can we pass in both the 
> phys_addr_t and the dma_addr_t?

The Xen implementation would needs to do the phys to bus conversion page 
by page anyway, so it wouldn't help much.  But it also wouldn't hurt.

How expensive is the phys-to-bus conversion on power?  Is it worth 
making the interface more complex for?  Would passing phys+bus mean that 
we wouldn't also need to pass dev?

> We have both in every case but one, which is in swiotlb_map_page where 
> we call address_needs_mapping() without calling range_needs_mapping.  
> It's not actually clear to me that we need that check, though.  Can 
> someone explain what case that was designed to catch?

It called them together a little earlier in the function, and the phys 
address is still available.

I guess the test is checking for a bad implementation of map_single().  
I found a single instance of someone reporting the message (in 2.6.11, 
when swiotlb was ia64-specific: http://lkml.org/lkml/2008/3/3/249).  
panic() is an odd way to handle an error (even an one which is an 
implementation bug), but I guess it's better than scribbling on the 
wrong memory.

    J
