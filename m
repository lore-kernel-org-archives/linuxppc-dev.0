Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 4560DDECFE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:50:48 +1000 (EST)
Date: Thu, 17 Apr 2008 11:50:45 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: Warp patches for 2.6.26
Message-ID: <20080417115045.7e4e6b1e@lappy.seanm.ca>
In-Reply-To: <E1Jksea-0001ba-DL@xyzzy.farnsworth.org>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080413104430.c98244d2.sfr@canb.auug.org.au>
	<20080412215544.38fa2d0b@lappy.seanm.ca>
	<fa686aa40804121909s4ee04731ua63afa76fe088828@mail.gmail.com>
	<E1Jksea-0001ba-DL@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 12 Apr 2008 20:13:16 -0700
"Dale Farnsworth" <dale@farnsworth.org> wrote:

> Each patch needs to be standalone.  you need to add a header
> describing what the patch is intended to accomplish.  Being more
> descriptive is better than less.  Also, as Stephen said, make sure
> that the subject of each email containing a patch is descriptive and
> reasonably unique within the entire kernel.

Splitting up the patches would be very error prone. I would have to
basically do all the editing by hand.

I also think I am not being clear enough. Basically what is currently
in the mainline is platform code for a Rev A board with minimal FPGA
functionality, since that is what we had at the time.

These patches, I should probably merge them into one patch, bring the
platform code up to a Rev B board with a more complete FPGA load. (I
say more complete because FPGA loads are never complete ;)

These patches only affect the Warp. Ignoring the LED and WDT patches,
you have to have all the changes to get a working Rev B. You can't just
put in the DTM changes or just put in the NAND changes.

I listed 8 changes, but three are for NAND, and four are for DTM. I
could compress them down:

Updated platform code to support Rev B boards.
  * Switched from 64M NOR/64M NAND to 4M NOR/256M NAND.
  * Fully functional DTM.
  * Added POST information.
  * Removed LED function, moved to new LED driver.

Now, the POST function and the removed LED function could be separate
patches I guess, but it hardly seems worth it. The LED function was
never used except in temporary debug code.

> For example, instead of "WDT driver", as a minimum something like:
> "[POWERPC] warp: Add WDT driver".

Ok, that I can do.

Cheers,
   Sean
