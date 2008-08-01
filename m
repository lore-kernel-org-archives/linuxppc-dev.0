Return-Path: <benh@kernel.crashing.org>
Subject: Re: Board level compatibility matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080801032533.GB6595@secretlab.ca>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 14:25:39 +1000
Message-Id: <1217564739.11188.482.camel@pasglop>
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

About this whole generic board mumbo-jumbo: not happening. It's a pipe
dream, it doesn't work, and it leads to the sort of mess we have in chrp
where we end up having hacks to identify what exact sort of chrp we have
and do things differently etc...

NOT HAPPENING.

Now, there are two approaches here that are possible:

 - Your board is really pretty much exactly the same as board XXX,
except maybe you have a different flash size or such, and the support
for board XXX can cope perfectly with it simply due to the device-tree
the right information.

If that happens to be the case, make your board compatible with board
XXX. Make that entry -second- in your compatible list, because one day
you'll figure out that there -is- indeed a difference and I don't want
to see board XXX code start to grow code to recognise your other board
and work around the difference. So at that stage, copy board XXX.c file
and start over with your own board support that matches on your first
compatible propery entry.

 - Once you figure out that really, those 5 boards here -do- share 99%
of the code... it's just that one need a workaround at the IRQ fixup
level, maybe one needs a tweak on a GPIO at boot and one has an issue on
reboot that needs to be whacked a bit differently ... well, make
-library- code.

I have no objection of having something like for each ppc_md field
called X, having a utility file providing an mpc52xx_generic_X function.
Such a board could then basically have a small .c file whose ppc_md just
use the generic functions for all except the ones that need to be
hooked/wrapped/replaced/whatever.

In fact, if you start from the first approach, and then decide that you
need to split off board XXX, it's legit to move some of board XXX ppc_md
functions to such a library if you believe they can be of use to a few
other boards, try to be a bit creative with the name tho :-)

It's then just a matter of doing the right Kconfig select of
non-user-visible options for your board support to build in the right
libraries it needs.

Ben.
