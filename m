Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51D7D67A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 06:58:12 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Wed, 19 Jan 2005 20:58:02 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHMECGCKAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <3AACC857-6A49-11D9-9943-003065F9B7DC@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] Handle I-TLB Error and Miss separately on 8xx
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Jan 19, 2005, at 1:06 PM, Joakim Tjernlund wrote:
> 
> > 8MB pages for user space? Isn't that a bit big?
> 
> Just for kernel space.  I think eliminating lots of TLB updates for the
> kernel will be one of the easiest ways to get a boost of performance
> in this area.  This way, system calls or interrupts won't pollute the 
> TLB
> for the application, which can then just continue to run without having
> to reload the TLB after such events.

I see, similar to the pinned TLBs in 8xx but without the "pin"
This would include vmalloc space and ioremapped space as well?

> 
> Part of my graduate work years ago was MMU overhead with various
> page sizes and replacement algorithms.  Increase page sizes from
> something like 1K to 8M made a difference you could measure, but
> the difference between 1K to 32K made little difference.   Of course,
> you can always write some application that just trashes the TLB and
> proves any improvement incorrect, but that would also trash caches and
> other system resources.  I'll always contend that if you can measure
> the difference between a 4K and 16K page, something else is grossly
> wrong with the system in general and you should be looking for
> performance problems elsewhere.

hmm, did you measure this on a 8xx with that have few TLBs?
I havn't done any measurements, it just seemed like a good idea for
systems with few TLBs and lots of RAM.

 Jocke
