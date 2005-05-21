Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A6A8679F1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 May 2005 07:21:51 +1000 (EST)
In-Reply-To: <20050520175152.GB26221@logos.cnet>
References: <20050520141244.GD24923@logos.cnet>
	<e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
	<20050520175152.GB26221@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5d184282e7d324fb009b8dcf6e6f967d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 21 May 2005 17:21:47 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] allow coherent DMA API to work before main page
	allocator is set up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 20, 2005, at 1:51 PM, Marcelo Tosatti wrote:

> I must be missing something very obvious here, can you explain how
> did you arrange things in v2.4 such that the console's ->setup
> method is called _after_ mem_init() ?

The driver used to use the serial port configuration as left by the
boot rom until very late into the initialization.  As I have said many
times in the past, the serial driver went through three different
levels of configuration.  There was an early configuration that was
used for kgdb, a later one used by the serial kernel printk, and
finally a full configuration by the serial driver.

It's sad that "moving forward" is done at a cost of throwing away
features that were important.  The hack to allocate from boot memory
is a quick fix, but this further ensures features like pinned TLB
entries won't work.

Thanks.


	-- Dan
