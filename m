Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CF3A67A62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 05:38:06 +1100 (EST)
In-Reply-To: <JPEALJAFNGDDLOPNDIEEAEEEDAAA.joakim.tjernlund@lumentis.se>
References: <JPEALJAFNGDDLOPNDIEEAEEEDAAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3AACC857-6A49-11D9-9943-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 19 Jan 2005 13:37:53 -0500
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 19, 2005, at 1:06 PM, Joakim Tjernlund wrote:

> 8MB pages for user space? Isn't that a bit big?

Just for kernel space.  I think eliminating lots of TLB updates for the
kernel will be one of the easiest ways to get a boost of performance
in this area.  This way, system calls or interrupts won't pollute the 
TLB
for the application, which can then just continue to run without having
to reload the TLB after such events.

Part of my graduate work years ago was MMU overhead with various
page sizes and replacement algorithms.  Increase page sizes from
something like 1K to 8M made a difference you could measure, but
the difference between 1K to 32K made little difference.   Of course,
you can always write some application that just trashes the TLB and
proves any improvement incorrect, but that would also trash caches and
other system resources.  I'll always contend that if you can measure
the difference between a 4K and 16K page, something else is grossly
wrong with the system in general and you should be looking for
performance problems elsewhere.


	-- Dan
