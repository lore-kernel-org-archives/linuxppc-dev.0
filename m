Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Fri, 1 Aug 2008 08:06:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Board level compatibility matching
Message-ID: <20080801080632.35edcb04@zod.rchland.ibm.com>
In-Reply-To: <1217564739.11188.482.camel@pasglop>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 01 Aug 2008 14:25:39 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> About this whole generic board mumbo-jumbo: not happening. It's a pipe
> dream, it doesn't work, and it leads to the sort of mess we have in chrp
> where we end up having hacks to identify what exact sort of chrp we have
> and do things differently etc...
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

44x does this today for a small number of boards.  The "issue", if
there really is one, is that there's no clear definition on what is
acceptable to be called "compatible".  If _Linux_ platform support for
board FOO
> 
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

This is sort of the part that sucks.  Look at 44x.  There are 10
board.c files there.  There really only needs to be 3 or 4 (sam440ep,
warp, virtex, and "generic") because the board files are identical in
everything except name. By doing the library code approach, one still
has to create a board.c file for a new board and plug in the library
functions to ppc_md.

Alternatively, you could do the:

compatible = "specific-board", "similar-board"

approach that has been done for e.g. Bamboo and Yosemite.  Again, the
issue is that is that OK?  Is it OK for a board to claim compatibility
with another board when it might not have all the devices of that
board, or might have additional devices, etc.  I was of the opinion
it is, and the device tree handles this just fine, as does the platform
code. But it can be confusing, hence the discussion here.

josh
