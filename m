Return-Path: <benh@kernel.crashing.org>
Subject: Re: Board level compatibility matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808010727v53fe3580q2813a12cb66f8f68@mail.gmail.com>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
	<fa686aa40808010727v53fe3580q2813a12cb66f8f68@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 02 Aug 2008 08:54:43 +1000
Message-Id: <1217631283.11188.545.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-01 at 08:27 -0600, Grant Likely wrote:
> 
> I agree with most of your argument, except I really have problems with
> boards claiming compatibility with an older board.  My reason is
> exactly the reason you state; One day you'll figure out that there is
> indeed a difference.  The problem is; when the original board (the one
> others are claiming compatibility with) gains additional code to fixup
> quirks or something, then that code will get changed with no
> visibility that it is borking up other boards that are currently
> depending on it.

Then just use your own .c file. It's not like it was a big deal.

I don't know why it's -so- appealing to not have to do one at all.

> I far prefer the solution I'm currently using in 5200-land where there
> is a simple (boring?) board port which *explicitly* states which
> boards it supports (see arch/powerpc/platforms/52xx/mpc5200_simple.c).
>  When someone goes to modify that file, it is explicit that it
> currently supports multiple boards.  If a board becomes 'non-boring',
> then it is removed from the simple platform; the simple platform is
> *not* extended to accommodate it.

As long as you stick to -never- extend the simple platform to accomodate
for a variant, then I suppose that's ok I suppose, though that does
raise the point of what to put in the compatible property.

> I *fully* agree that it is insane for the code to grow detection logic
> and I've been explicit about not doing anything of the sort in 5200
> land.  What I am suggesting is that if nothing else claims the board,
> then allow the simple platform to bind against it based on the fact
> that it uses the same SoC.

See my comment in my reply to Josh about changing the board probe into a
multi-pass probe so that first, we only match on the first entry of the
compatible property, then we match on the second, etc... to go from more
specific to less specific.

> However, if I can't get concensus on this approach, then I do /not/
> want to go to a boards compatible with other boards scheme.  It will
> cause breakage and pain that is non-obvious to debug for many users.

As far as I'm concerned, this approach is mostly useful for revisions of
a board. Oh and I'm not going to whack you with a stick if in the end,
you do have a little bit of variation in a single board .c file to deal
with a glitch in rev. C of the board that wired something backward for
example ... it's a matter of perspective. But I would prefer a different
board (from a different vendor for example) to use a different .c file
even if it only differs by the same little glitch.

> BTW, I am also not suggesting that the .dts files themselves try to
> claim some kind of 'generic' compatibility.  I'm proposing handling
> any catch-all cases in the Linux code itself, where it is easy to
> change because it is just an implementation detail.  Trying to make
> the dt 'generic' doesn't make any sense because doing so is almost
> always wrong (or will become wrong in the future).

The problem is that I don't see a sane way to do the catch all in the
linux code, other than explicitely doing what you already do which is to
list all supported boards in the simple platform. It's either that or
adding some compatible "socname,linux-simple" or so property in
your .dts. I don't believe matching on SoC is of any use. It will
incorrectly try to match things that don't work and that's bad.

Ben.
