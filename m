Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Date: Thu, 19 Aug 2010 17:48:51 +0200
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008191429.50008.arnd@arndb.de>
	<20100819152301.GB25193@ovro.caltech.edu>
In-Reply-To: <20100819152301.GB25193@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008191748.51819.arnd@arndb.de>
Cc: john stultz <johnstul@us.ibm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Rodolfo Giometti <giometti@linux.it>,
	devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 August 2010, Ira W. Snyder wrote:
> Perhaps you were thinking of the vhost example (taken from
> drivers/vhost/Kconfig):
> 
> config VHOST_NET
>         tristate "Host kernel accelerator for virtio net (EXPERIMENTAL)"
>         depends on NET && EVENTFD && (TUN || !TUN) && (MACVTAP || !MACVTAP) && EXPERIMENTAL
> 
> They have a similar construct with both TUN and MACVTAP there. Perhaps
> the parens are a necessary part of the "X || !X" syntax? Just a random
> guess.

Yes, that's the one I was thinking of.

My mistake was that the effect is slightly different here. VHOST and TUN are
both tristate. What we guarantee here is that if TUN is "m", VHOST cannot be "y",
because its dependency cannot be fulfilled for y.

	Arnd
