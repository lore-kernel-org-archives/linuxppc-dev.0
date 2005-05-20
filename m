Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 949E3679FB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 06:16:32 +1000 (EST)
Date: Fri, 20 May 2005 13:16:20 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050520131620.B881@cox.net>
References: <c3d0340b050518175411c484e3@mail.gmail.com>
	<20050519012404.GA11587@gate.ebshome.net>
	<c3d0340b05051818524c647e61@mail.gmail.com>
	<20050519020953.GB11587@gate.ebshome.net>
	<c3d0340b050520111228a6f4cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050520111228a6f4cd@mail.gmail.com>;
	from shawnxjin@gmail.com on Fri, May 20, 2005 at 11:12:54AM -0700
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: DMA consistent allocation is limited to 2MB on 2.6.11 for
	ppc440?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 20, 2005 at 11:12:54AM -0700, Shawn Jin wrote:
> > My recommendation - don't do this. Why do you need to allocate this
> > big chunk of consistent memory in the first place? You can do DMA
> > _without_ allocating "consistent" memory. In fact, this is how
> > virtually all devices work in Linux. For more info about DMA API -
> > look at Documentation/DMA-API.txt.
> 
> The driver stack we've been developing (already 4.0) uses consistent
> memory a lot for DMA. The stack is for many kinds of high performance
> storage IO e.g. iSCSI, FC. It works fine on 2.4.x because there is no
> such 2MB consistent pool limitation.

Why are you using consistent memory for your DMA buffers?
 
> > Technically, you can make consistent pool bigger, if you really insist
> > on using this approach.
> 
> I want to understand the motivation and the rationale of choosing
> 'consistent_pte' on 2.6.x, what impact there would be to increase the
> consistent pool, and so on. Some pointers to articles, posts are more
> helpful.
 
The rationale on moving to the new implementation in 2.6 was to fix a
critical bug.  The bug could not be fixed with a band-aid solution, but
required an allocation system with different semantics. After considering
a few possibilities the basic framework from ARM was selected.

The bug that was fixed was the inability to allocate consistent memory
from an interrupt context. This is allowed by the PCI DMA API and the
more general DMA API and is used by many drivers.  In 2.4, these drivers
would simply BUG() on PPC4xx/8xx.

The difference with this implementation is that it doesn't allow for
arbitrarily huge consistent allocations by default.  However, I carefully
placed a comment at the top to point people to the advanced setup
menu where they can tune the consistent pool to be larger than the
2MB default.  You simply have to understand the memory map of your
board port when setting this option.  You can break things as with
other advanced setup menu options.

-Matt
