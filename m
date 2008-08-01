Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f28.google.com (mail-gx0-f28.google.com
	[209.85.217.28]) by ozlabs.org (Postfix) with ESMTP id 8023FDE821
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:43:41 +1000 (EST)
Received: by gxk9 with SMTP id 9so1297644gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Aug 2008 07:43:39 -0700 (PDT)
Message-ID: <fa686aa40808010727v53fe3580q2813a12cb66f8f68@mail.gmail.com>
Date: Fri, 1 Aug 2008 08:27:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: Board level compatibility matching
In-Reply-To: <1217564739.11188.482.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 10:25 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> About this whole generic board mumbo-jumbo: not happening. It's a pipe
> dream, it doesn't work, and it leads to the sort of mess we have in chrp
> where we end up having hacks to identify what exact sort of chrp we have
> and do things differently etc...

I am fully aware of the hell and hacks that went along with chrp.  I
am *not* suggesting a do everything platform that must figure out all
the quirks of a board in a single machine definition.  I know too well
that is the way of pain.

>
> NOT HAPPENING.
>
> Now, there are two approaches here that are possible:
>
>  - Your board is really pretty much exactly the same as board XXX,
> except maybe you have a different flash size or such, and the support
> for board XXX can cope perfectly with it simply due to the device-tree
> the right information.
>
> If that happens to be the case, make your board compatible with board
> XXX. Make that entry -second- in your compatible list, because one day
> you'll figure out that there -is- indeed a difference and I don't want
> to see board XXX code start to grow code to recognise your other board
> and work around the difference. So at that stage, copy board XXX.c file
> and start over with your own board support that matches on your first
> compatible propery entry.

I agree with most of your argument, except I really have problems with
boards claiming compatibility with an older board.  My reason is
exactly the reason you state; One day you'll figure out that there is
indeed a difference.  The problem is; when the original board (the one
others are claiming compatibility with) gains additional code to fixup
quirks or something, then that code will get changed with no
visibility that it is borking up other boards that are currently
depending on it.

I far prefer the solution I'm currently using in 5200-land where there
is a simple (boring?) board port which *explicitly* states which
boards it supports (see arch/powerpc/platforms/52xx/mpc5200_simple.c).
 When someone goes to modify that file, it is explicit that it
currently supports multiple boards.  If a board becomes 'non-boring',
then it is removed from the simple platform; the simple platform is
*not* extended to accommodate it.

I *fully* agree that it is insane for the code to grow detection logic
and I've been explicit about not doing anything of the sort in 5200
land.  What I am suggesting is that if nothing else claims the board,
then allow the simple platform to bind against it based on the fact
that it uses the same SoC.

However, if I can't get concensus on this approach, then I do /not/
want to go to a boards compatible with other boards scheme.  It will
cause breakage and pain that is non-obvious to debug for many users.

BTW, I am also not suggesting that the .dts files themselves try to
claim some kind of 'generic' compatibility.  I'm proposing handling
any catch-all cases in the Linux code itself, where it is easy to
change because it is just an implementation detail.  Trying to make
the dt 'generic' doesn't make any sense because doing so is almost
always wrong (or will become wrong in the future).

>  - Once you figure out that really, those 5 boards here -do- share 99%
> of the code... it's just that one need a workaround at the IRQ fixup
> level, maybe one needs a tweak on a GPIO at boot and one has an issue on
> reboot that needs to be whacked a bit differently ... well, make
> -library- code.
>
> I have no objection of having something like for each ppc_md field
> called X, having a utility file providing an mpc52xx_generic_X function.
> Such a board could then basically have a small .c file whose ppc_md just
> use the generic functions for all except the ones that need to be
> hooked/wrapped/replaced/whatever.

I agree.  5200 code already does this.

g.
