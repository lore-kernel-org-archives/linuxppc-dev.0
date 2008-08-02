Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Fri, 1 Aug 2008 20:07:07 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Board level compatibility matching
Message-ID: <20080801200707.7235d1ea@zod.rchland.ibm.com>
In-Reply-To: <1217630903.11188.537.camel@pasglop>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
	<20080801080632.35edcb04@zod.rchland.ibm.com>
	<1217630903.11188.537.camel@pasglop>
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

On Sat, 02 Aug 2008 08:48:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > This is sort of the part that sucks.  Look at 44x.  There are 10
> > board.c files there.  There really only needs to be 3 or 4 (sam440ep,
> > warp, virtex, and "generic") because the board files are identical in
> > everything except name. By doing the library code approach, one still
> > has to create a board.c file for a new board and plug in the library
> > functions to ppc_md.
> 
> And ? How is that a big deal ? Real products (ie not eval boards, and
> even those ...) will probably end up needing that due to subtle
> differences anyway.

I didn't say it was a big deal.  But I also think it's pretty pointless
to carry around a bunch of C files that have to get the same set of
fixes across the board when updated because they really only differ by
the function names. Particularly when you could just have one C file
with a list of supported boards.

As I said, to me this is about cleanup and maintenance.  I totally
agree that truly custom boards (e.g. actual products) will likely
require different board.c files and that's just fine with me.  I'm just
looking for the best approach to cleanup the ones that don't need to
be, and the explicit list seems to be that way.

> > Alternatively, you could do the:
> > 
> > compatible = "specific-board", "similar-board"
> > 
> > approach that has been done for e.g. Bamboo and Yosemite.  Again, the
> > issue is that is that OK?  Is it OK for a board to claim compatibility
> > with another board when it might not have all the devices of that
> > board, or might have additional devices, etc.  I was of the opinion
> > it is, and the device tree handles this just fine, as does the platform
> > code. But it can be confusing, hence the discussion here.
> 
> Well, as I said. If it stops being ok, just create your own board
> and it will take over provided you put it before the other one in
> the link order.
> 
> If we generalize that approach, we might want to change the board
> probing code a bit to first do a full pass based on the first
> entry in compatible, then another full pass based on the second, etc...

I don't care much either way.  I guess I'd rather avoid relying on
strict link order to do the probing right, if only because a simple
mistake can break things.

There might not be a "one true way", but Grant and I thought it
pertinent to bring up a discussion in case there was a "very wrong
way", that's all.

josh
