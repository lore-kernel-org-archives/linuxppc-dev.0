Date: Thu, 5 Aug 2004 14:23:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] 44x ethernet MDIO access
Message-ID: <20040805142305.C14159@home.com>
References: <41128413.7030900@rossvideo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41128413.7030900@rossvideo.com>; from rsiemsen@rossvideo.com on Thu, Aug 05, 2004 at 03:01:39PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 05, 2004 at 03:01:39PM -0400, Ralph Siemsen wrote:
> There is a small bug in the emac_phy_write() routine defined in
> drivers/net/ibm_emac/ibm_emac_core.c (present in latest 2.6.8-rc3).  At
> the end of the function, check is done for phy error; however as written
> this will always be false, because "stacr" contains the value _written_
> to the hardware, rather than the value read back from hardware.
>
> Simple on-line fix attached.
>
> In a related issue, both the PHY read and write functions use a fixed
> time delay (MDIO_DELAY = 50) presently... it seems I need a longer value
> on my hardware, and having such hardcoded values is trouble anyways... I
> suggest we change the code to poll for completion, with a short delay
> and an upper limit on the number of loops.
>
> =Ralph

Applied, thanks.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
