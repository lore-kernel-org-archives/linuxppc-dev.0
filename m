Return-Path: <richardcochran@gmail.com>
Date: Wed, 16 Jun 2010 12:05:39 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 12/12] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
Message-ID: <20100616100539.GA3569@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<37f5015b186bdd51f8451ade042f90c8b39a5cc8.1276615626.git.richard.cochran@omicron.at>
	<AANLkTilqd-wxqMWDxssC-XMDJqZ8iIiSrvp2t8xARAQV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilqd-wxqMWDxssC-XMDJqZ8iIiSrvp2t8xARAQV@mail.gmail.com>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 12:49:13PM -0600, Grant Likely wrote:
> Won't this break things for existing DP83640 users?

Nope, the driver was only added five patches ago, and it only offers
the timestamping stuff. The standard PHY functions just call the
generic functions, so the PHY works fine even without this driver.

> > +static struct ptp_clock *dp83640_clock;
> > +DEFINE_SPINLOCK(clock_lock); /* protects the one and only dp83640_clock */
> 
> Why only one?  Is it not possible to have 2 of these PHYs in a system?

Yes, you can have multiple PHYs, but only one PTP clock.

If you do use multiple PHYs, then you must wire their clocks together
and adjust the PTP clock on only one of the PHYs.


Thanks for your other comments,

Richard
