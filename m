Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18511.24317.31038.926337@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jun 2008 15:13:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806111500.30789.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop>
	<200806101656.51211.nickpiggin@yahoo.com.au>
	<18511.21025.978328.596571@cargo.ozlabs.ibm.com>
	<200806111500.30789.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin writes:

> > I just wish we had even one actual example of things going wrong with
> > the current rules we have on powerpc to motivate changing to this
> > model.
> 
> ~/usr/src/linux-2.6> git grep test_and_set_bit drivers/ | wc -l
> 506
> How sure are you that none of those forms part of a cobbled-together
> locking scheme that hopes to constrain some IO access?

My comment was precisely about the fact that this sort of argument is
actually FUD.  I want one example that is demonstrably wrong, not just
a "how sure are you".

> But surely you have to audit the drivers anyway to ensure they are OK
> with the current powerpc scheme. In which case, once you have audited
> them and know they are safe, you can easily convert them to the even
> _faster_ __readl/__writel, and just add the appropriate barriers.

The trouble is that as code gets maintained, using __writel + explicit
barriers is more fragile because some people will change the code, or
add new code, without understanding the barriers.  So whenever a
driver gets converted to using __writel + barriers, we will end up
having to watch every change that goes into it forever.  Whereas with
the current scheme there's a much smaller set of gotchas to watch out
for, and the gotchas are things that already raise red flags, such as
open-coded locking and any sort of "clever" lockless scheme.

Paul.
