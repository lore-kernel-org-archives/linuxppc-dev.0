Date: Thu, 5 Aug 2004 14:34:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] 44x ethernet MDIO access
Message-ID: <20040805143449.D14159@home.com>
References: <41128413.7030900@rossvideo.com> <41129315.600@rossvideo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41129315.600@rossvideo.com>; from rsiemsen@rossvideo.com on Thu, Aug 05, 2004 at 04:05:41PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 05, 2004 at 04:05:41PM -0400, Ralph Siemsen wrote:
> Ralph Siemsen wrote:
> > In a related issue, both the PHY read and write functions use a fixed
> > time delay (MDIO_DELAY = 50) presently... it seems I need a longer value
> > on my hardware, and having such hardcoded values is trouble anyways... I
> > suggest we change the code to poll for completion, with a short delay
> > and an upper limit on the number of loops.
>
> I've just checked the hardware, it seems that the MDIO clock is driven
> at EPB clock divided by 10.  So on the IBM eval board its 7.6MHz.  Each
> MDIO transfer involves moving 64 bits of data.  So that means just the
> data transfer (never mind any processing in the PHY) takes 8.4us.
>
> The important part to note is that EPB could vary over a considerable
> range, so the time needed for MDIO is potentially longer than the 50us
> currently used in the code.
>
> Attached is a patch that "works for me" - turns the long udelay() into a
> polling loop with short little delays instead.  This allows MDIO_DELAY
> to be increased to a larger value (say 150) without slowing down most
> systems.
>
> Also I can be used to measure just how long the transfers actually take.
>   If MDIO_DEBUG is enabled then you'll see how many "loops" were
> needed... on the Ocotea board i get values around 25.
>
> -Ralph

Applied (with minor mods).

Ralph, can you take a look at http://kerneltrap.org/node/view/3180
and sign off your future patches accordingly?

Thanks,
Matt


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
