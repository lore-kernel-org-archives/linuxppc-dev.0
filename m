Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Fri, 1 Aug 2008 11:11:41 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Board level compatibility matching
Message-ID: <20080801111141.3543e23b@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40808010727v53fe3580q2813a12cb66f8f68@mail.gmail.com>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
	<fa686aa40808010727v53fe3580q2813a12cb66f8f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 Aug 2008 08:27:41 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> > NOT HAPPENING.
> >
> > Now, there are two approaches here that are possible:
> >
> >  - Your board is really pretty much exactly the same as board XXX,
> > except maybe you have a different flash size or such, and the support
> > for board XXX can cope perfectly with it simply due to the device-tree
> > the right information.
> >
> > If that happens to be the case, make your board compatible with board
> > XXX. Make that entry -second- in your compatible list, because one day
> > you'll figure out that there -is- indeed a difference and I don't want
> > to see board XXX code start to grow code to recognise your other board
> > and work around the difference. So at that stage, copy board XXX.c file
> > and start over with your own board support that matches on your first
> > compatible propery entry.
> 
> I agree with most of your argument, except I really have problems with
> boards claiming compatibility with an older board.  My reason is
> exactly the reason you state; One day you'll figure out that there is
> indeed a difference.  The problem is; when the original board (the one
> others are claiming compatibility with) gains additional code to fixup
> quirks or something, then that code will get changed with no
> visibility that it is borking up other boards that are currently
> depending on it.

There is that possibility yes.  And it is even non-theoretical to a
degree, as the situation may occur with the existing Bamboo/Yosemite
scenario when we get around to fixing up the horror that is the EBC on
Bamboo.  Admittedly, a single person did both those ports so the
inherent knowledge is already there, but that won't always be the case.

> I far prefer the solution I'm currently using in 5200-land where there
> is a simple (boring?) board port which *explicitly* states which
> boards it supports (see arch/powerpc/platforms/52xx/mpc5200_simple.c).
>  When someone goes to modify that file, it is explicit that it
> currently supports multiple boards.  If a board becomes 'non-boring',
> then it is removed from the simple platform; the simple platform is
> *not* extended to accommodate it.

To me, the solution you are using there seems like the best compromise
between the various options.  It allows a common "board".c (or
platform) file in the kernel, while still adhering to a form of purity
in the device tree itself.  The only slightly annoying issue is the
need to change the explicit list, but I don't consider that a burden
really.

If you haven't noticed, my primary reason for wanting to do _something_
is to prevent the proliferation of code duplication that we've seen.
Cleanup time is in order, and this is the most expedient and seemingly
correct way of doing things.

> I *fully* agree that it is insane for the code to grow detection logic
> and I've been explicit about not doing anything of the sort in 5200
> land.  What I am suggesting is that if nothing else claims the board,
> then allow the simple platform to bind against it based on the fact
> that it uses the same SoC.
> 
> However, if I can't get concensus on this approach, then I do /not/
> want to go to a boards compatible with other boards scheme.  It will
> cause breakage and pain that is non-obvious to debug for many users.

I think there is too much momentum behind the old method, and not a
clear enough definition on how one would bind to a generic SoC without
dealing with things like link order, etc.  Also, not every platform has
SoC nodes (as you already pointed out), and adding them to the DTS
files (or adding a new property or binding to the CPU node, etc) for
this purpose seems to be both overkill and contrary to not wanting to
break existing products out there that use the old DTS files and method.
They should be few in number, but they do exist (see PIKA Warp).

I'm growing very much of the opinion that the way you are _currently_
handling 52xx is more or less the way we should go.

josh
