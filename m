Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9753F67B15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 19:57:29 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
	"Dan Malek" <dan@embeddededge.com>
Date: Mon, 25 Apr 2005 11:57:18 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEECENCDCAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050424165520.GA22786@logos.cnet>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> Hi Dan, Joakim,
> 
> On Sat, Apr 23, 2005 at 08:00:39PM -0400, Dan Malek wrote:
> > 
> > On Apr 23, 2005, at 7:51 PM, Joakim Tjernlund wrote:
> > 
> > >hmm, I have more than 24MB of memory and I can run CONFIG_PIN_TLB just
> > >fine with modules off in kernel 2.4. Havn't tried 2.6 yet.
> > 
> > Doh.  Oh, I see.  We only do the optimization for the instruction 
> > misses.
> > I'll have to take a closer look at Marcelo's 2.6 tests.
> 
> The PIN TLB entry option does not make much difference in my tests, 
> never did.

Don't your TLB Miss counters look different for kernel space? If they don't there must be something
very wrong with the CONFIG_PIN_TLB code.

> 
> Who wrote the code? Are there results which indicate a performance gain
> from TLB pinning on 8xx? If so, where are such results? 

I think Dan wrote this code. In 2.4 I improved the ITLB Miss handler a little for
pinned ITLBs

> 
> One problem that I've noted is that initial_mmu sets {I,D}TLB index
> to be 27 (11100). 
> 
> MI_RSV4I protects TLB's 27...31.
> 
> Given that both {I,D}TLB INDEX's are _decreased_ on each update, it seems
> to me that initial_mmu should set {I,D}TLB INDEX to 31, which will then 
> decrease down to 27 after 4 TLB's are created.  

Makes sense but I can't say for sure. I tried the patch below on my 2.4 tree
and it works fine.

> 
> Another question that comes to mind is why initial_mmu does create 
> additional 8Meg TLB entries for D-cache but not for I-cache:

Because the kernel code will never grow beyond 8MB, but data will due
to kmalloc() etc.

[SNIP]
