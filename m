Return-Path: <nickpiggin@yahoo.com.au>
Received: from n25.bullet.mail.mud.yahoo.com (n25.bullet.mail.mud.yahoo.com
	[68.142.200.132]) by ozlabs.org (Postfix) with SMTP id 8AAC9DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 17:38:45 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Date: Tue, 19 Feb 2008 17:20:48 +1100
References: <47B70A61.9030306@tiscali.nl>
	<200802191333.53607.nickpiggin@yahoo.com.au>
	<20080219055806.GA8404@1wt.eu>
In-Reply-To: <20080219055806.GA8404@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802191720.49210.nickpiggin@yahoo.com.au>
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Andi Kleen <andi@firstfloor.org>,
	cbe-oss-dev@ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 February 2008 16:58, Willy Tarreau wrote:
> On Tue, Feb 19, 2008 at 01:33:53PM +1100, Nick Piggin wrote:
> > > Note in particular the last predictors; assuming branch ending
> > > with goto, including call, causing early function return or
> > > returning negative constant are not taken. Just these alone
> > > are likely 95+% of the unlikelies in the kernel.
> >
> > Yes, gcc should be able to do pretty good heuristics, considering
> > the quite good numbers that cold CPU predictors can attain. However
> > for really performance critical code (or really "never" executed
> > code), then I think it is OK to have the hints and not have to rely
> > on gcc heuristics.
>
> in my experience, the real problem is that gcc does what *it* wants and not
> what *you* want. I've been annoyed a lot by the way it coded some loops
> that could really be blazingly fast, but which resulted in a ton of
> branches due to its predictors. And using unlikely() there was a real mess,
> because instead of just hinting the compiler with probabilities to write
> some linear code for the *most* common case, it ended up with awful
> branches everywhere with code sent far away and even duplicated for some
> branches.
>
> Sometimes, for performance critical paths, I would like gcc to be dumb and
> follow *my* code and not its hard-coded probabilities. For instance, in a
> tree traversal, you really know how you want to build your loop. And these
> days, it seems like the single method of getting it your way is doing asm,
> which obviously is not portable :-(

Probably all true.


> Maybe one thing we would need would be the ability to assign probabilities
> to each branch based on what we expect, so that gcc could build a better
> tree keeping most frequently used code tight.

I don't know if that would *directly* lead to gcc being smarter. I
think perhaps they probably don't benchmark on code bases that have
much explicit annotation (I'm sure they wouldn't seriously benchmark
any parts of Linux as part of daily development). I think the key is
to continue to use annotations _properly_, and eventually gcc should
go in the right direction if enough code uses it.

And if you have really good examples like it sounds like above, then
I guess that should be reported to gcc?
