Date: Tue, 19 Mar 2002 14:34:00 -0800
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linux-galileo@source.mvista.com, wd@denx.de,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] EV-64260-BP & GT64260 bi_recs
Message-ID: <20020319223400.GA1490@zumanetworks.com>
References: <3C9797DE.295D56C7@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C9797DE.295D56C7@mvista.com>
From: Nye Liu <nyet@zumanetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 19, 2002 at 02:56:14PM -0500, Mark A. Greer wrote:
> Okay, the bi_rec discussions seems to have settled but without a real
> concensus.
>
> It would be nice to have bi_rec's settled as much as possible for the
> EV-64260-BP board.  So, to put a stake in the ground, here is my current
> thinking.  This is only for 2.4; 2.5 will have the more flexible version
> that paulus is working on.
>
> I've punted on the more complex bi_recs, and on passing in different
> memory fragments, and other "memories" like flash and sram.  Obviously,
> this is limited but it should at least attain the goal of having one
> ev-64260 kernel that works with all the different firmwares and flexible
> enough to pass in the things that are most likely to change (I think).
>
> I like what Michael has done but want to add more and change the
> BI_GT64260_ETH_CFG to a more generic BI_ETH_CFG.

Agreed. Simple is better right now, especially if things might get
totally redesigned in 2.5

> Here's the list:
>
> Already there (and generic):
> ---------------------------------
>   BI_CMD_LINE -- cmd line if any
>   BI_BOOTLOAD_ID -- bootloader ID
>   BI_INITRD -- initrd addr
>   BI_SYSMAP -- sysmap addr
>   BI_MACHTYPE -- machine type
>   BI_MEMSIZE -- mem size
>
> New (and [pretty much] generic):
> --------------------------------
>   BI_MEMSTART -- mem start
>   BI_INTFREQ -- internal CPU frequency??
>   BI_BUSFREQ -- CPU bus freqency?
>   BI_ETH_CFG -> struct with following:
>    -- mac addr
>    -- hdx/fdx; 10/100/1000/...; OR autonegotiate
>    -- phy addr
>    -- some bytes for driver specific info (e.g., on gt64260, is_rmii)
>   BI_BAUDRATE -- Console baudrate
>   BI_BRGFREQ -- Baud Rate generater freqency
>
>   BI_IMMRBASE -- Base Address of CPU internal memory (82xx/8xx only)
>   BI_SCCFREQ  -- SCC frequency in Hz (82xx, 8xx only)
>
> GT64260 Specific:
> ----------------------
>   BI_GT64260_BASE -- GT's reg physical base addr
>   BI_GT64260_TCLK -- frequency of TCLK input
>
>
> Some of the ones mentioned in previous emails have been omitted because
> they didn't seem useful enough.  I could be wrong.  Also, I may have
> missed some so please review the list and improve it.

Looks good.

The only thing that stands out (for the GT) is a second console baud
rate. probably unneccesary; most bootroms only initilize one serial
port anyway.

--
Nye Liu
nyet@zumanetworks.com

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
