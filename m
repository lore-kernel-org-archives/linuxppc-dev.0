Return-Path: <ben@fluff.org.uk>
Date: Tue, 26 Jan 2010 14:39:25 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors
	from Freescale
Message-ID: <20100126143925.GD12774@fluff.org.uk>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
	<1264408029-5290-3-git-send-email-wg@grandegger.com>
	<20100125115211.GA5257@pengutronix.de>
	<4B5D894C.4090001@grandegger.com>
	<20100125151509.GD5257@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100125151509.GD5257@pengutronix.de>
Cc: Wolfgang Grandegger <wg@denx.de>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 25, 2010 at 04:15:09PM +0100, Wolfram Sang wrote:
> > >>  
> > >> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
> > >> -					    struct mpc_i2c *i2c,
> > >> -					    u32 clock, u32 prescaler)
> > >> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
> > >> +					 struct mpc_i2c *i2c,
> > >> +					 u32 clock, u32 prescaler)
> > >>  {
> > >>  	int ret, fdr;
> > >>  
> > >> +	if (clock == -1) {
> > > 
> > > Could we use 0 for 'no_clock'? This would make the above statement simply
> > 
> > "0" is already used to maintain backward compatibility setting a safe
> > divider.
> 
> Ah, now I see:
> 
> 'clock == -1' means 'preserve clocks' (and is checked here in mpc_i2c_setup_52xx())
> 'clock ==  0' means 'safe divider' (and is checked in mpc_i2c_get_fdr_52xx())

hmm, sounds like a job for a  #define or similar.
 
> This is not a beauty ;)
> 
> What about adding a flags variable to the setup-functions?
> 
> Regards,
> 
>    Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |



-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
