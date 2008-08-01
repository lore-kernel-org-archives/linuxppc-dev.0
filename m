Return-Path: <benh@kernel.crashing.org>
Subject: Re: Board level compatibility matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080801080632.35edcb04@zod.rchland.ibm.com>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
	<1217564739.11188.482.camel@pasglop>
	<20080801080632.35edcb04@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 02 Aug 2008 08:48:23 +1000
Message-Id: <1217630903.11188.537.camel@pasglop>
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


> This is sort of the part that sucks.  Look at 44x.  There are 10
> board.c files there.  There really only needs to be 3 or 4 (sam440ep,
> warp, virtex, and "generic") because the board files are identical in
> everything except name. By doing the library code approach, one still
> has to create a board.c file for a new board and plug in the library
> functions to ppc_md.

And ? How is that a big deal ? Real products (ie not eval boards, and
even those ...) will probably end up needing that due to subtle
differences anyway.

> Alternatively, you could do the:
> 
> compatible = "specific-board", "similar-board"
> 
> approach that has been done for e.g. Bamboo and Yosemite.  Again, the
> issue is that is that OK?  Is it OK for a board to claim compatibility
> with another board when it might not have all the devices of that
> board, or might have additional devices, etc.  I was of the opinion
> it is, and the device tree handles this just fine, as does the platform
> code. But it can be confusing, hence the discussion here.

Well, as I said. If it stops being ok, just create your own board
and it will take over provided you put it before the other one in
the link order.

If we generalize that approach, we might want to change the board
probing code a bit to first do a full pass based on the first
entry in compatible, then another full pass based on the second, etc...

Ben.
