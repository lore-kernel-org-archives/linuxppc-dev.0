Date: Mon, 11 Nov 2002 07:49:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ethtool support to 8260 fcc ethernet driver (and other stuff)
Message-ID: <20021111144957.GB602@opus.bloom.county>
References: <431.1036986935@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <431.1036986935@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 11, 2002 at 02:55:35PM +1100, Murray Jensen wrote:

> This patch does the following:
>
> 1. adds support for a "/proc/bus/mii/fccN" file that displays the contents of
>    all MII PHY registers
>
> 2. adds support for the generic MII interface available in drivers/net/mii.c
>
> 3. adds support for the ioctls used by the ethtool program
>
> 4. changes statistics recording so that FIFO Overrun errors are accumulated in
>    rx_fifo_errors instead of rx_crc_errors and Late Collision errors are
>    accumulated in rx_over_errors instead of rx_frame_errors - this means that
>    all the possible errors from the 8260 fcc have their own counter
>
> 5. fixes comments such as /* CONFIG_FEC_... */ to be /* CONFIG_FCC_... */
>
> 6. fixes a bug in the DM9131 PHY support where the wrong value for link status
>    was being seen because the bit in the status register is marked as "latch low"
>    which means if it goes low (e.g. you pull out the TP cable), it will stay that
>    way until the register is read - I simply always read the register twice now
>    to ensure that the current link status is seen (not the latched status).
>    Other PHY driver writers should beware of this.
>
> 7. fix a printk which had "fec: ..." to output "fccN: ..." instead
>
> 8. the fcc driver version is tagged as containing these changes by appending
>    " (mjj)" after the version number (which is still 0.3). People will probably
>    want to leave this one out, or else bump the version number to 0.4 instead.
>    (I did this so I could tell which of our boards here had the fixes).
>
> 9. set and clear the LPB (local protect bit) bit in the FCC PSMR in tandem with
>    setting and clearing the FDE (full duplex enable) bit - if LPB is not set, the
>    receiver is blocked while transmitting - on my board this resulted in very low
>    throughput on input to the board (e.g. ftp to the board and PUT a file).
>    I found this fix in a message to the list, and it solved by problem, but the
>    official 2_4_devel sources still doesn't have it. Sorry, I don't have the
>    reference at hand - but a search on the list should pick it up pretty quick
>    (so the right person gets credit for the fix).

Could you please split this up into 9 logical patches then?  This makes
it easier for others to track things and to get it reviewed as well (ie
someone who knows /proc and is well aware of common mistakes people make
probably wouldn't mind looking over the patch, if it was just /proc
bits).

> Note that this requires a patch to drivers/net/Makefile so that mii.c is compiled
> if CONFIG_FCC_GENERIC_MII is enabled - obviously this violates the rule that
> non-ppc specific files shouldn't be touched, but it is essential to the patch.

That part should also just be:
obj-$(CONFIG_FCC_GENERIC_MII) += mii.o

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
