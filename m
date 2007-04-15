Return-Path: <dgibson@ozlabs.org>
Date: Sun, 15 Apr 2007 12:22:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.uboot@gmail.com>
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
Message-ID: <20070415022244.GA12016@localhost.localdomain>
References: <20070405020433.GA13891@dellserver.lan>
	<20070405161113.GA28063@ld0162-tx32.am.freescale.net>
	<46152D90.5070209@smiths-aerospace.com>
	<20070412065152.GA26210@localhost.localdomain>
	<4620D009.1000800@gmail.com>
	<20070415004229.GD9104@localhost.localdomain>
	<46218A5D.80805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46218A5D.80805@gmail.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 14, 2007 at 10:13:49PM -0400, Jerry Van Baren wrote:
> David Gibson wrote:
> > On Sat, Apr 14, 2007 at 08:58:49AM -0400, Jerry Van Baren wrote:
> 
> [snip]
> 
> >> On an unrelated related note, I don't believe my -R additions are 
> >> actually putting out additional reserve map slots (easiest to see using 
> >> the asm format output).  I'm still trying to understand why not, it 
> >> seemed pretty straight-forward.  When I implemented it, I was looking at 
> >> hexdumps of the dtb binary format and looking at the header and thought 
> >> I had it working... using it with my u-boot mods shows no extra reserved 
> >> slots.  I'm looking into where I went wrong.
> > 
> > Be careful to check the actual offsets.  Bear in mind that objdump may
> > elide zero words.  Also bear in mind that the only way a reader of the
> > device tree has of counting the number of reserve entries is stepping
> > through until it hits the terminating (0,0), so the extra entries will
> > just look like an early termination of the list.  In this sense -R
> > doesn't add "extra slots", but just ensures that there is space after
> > the reserve map to add more entries.
> 
> Hi David,
> 
> It actually is OK, went back and verified it.  I needed to modify the 
> asm output to implement the -R extra slots which was confusing me (patch 
> that you didn't like the calloc in ;-).
> 
> The calloc change was actually window dressing, I was just being 
> paranoid about a binary blob that is bigger than its contents (has extra 
> space).  The unused space is unused, so it doen't really matter if it is 
> non-zero.  I'll roll a new version.

Oh, I think zeroing it is correct, I'd just prefer it was done at the
callsite, rather than within xmalloc().  Strictly speaking you're
right, what's in the extra area shouldn't matter, but I don't like the
idea of potentially leaking random memory contents to file, which I
think could happen without a memset().  Because dtc is unpriveleged it
shouldn't actually matter, but it's ugly and a bad habit to establish.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
