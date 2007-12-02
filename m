Return-Path: <cbou@mail.ru>
Received: from mx33.mail.ru (mx33.mail.ru [194.67.23.194])
	by ozlabs.org (Postfix) with ESMTP id 53512DDE0A
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 23:20:31 +1100 (EST)
Date: Sun, 2 Dec 2007 15:13:12 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate
	PHYlayer functionality
Message-ID: <20071202121312.GA2996@zarina>
References: <20071201213403.GA2350@zarina>
	<051e01c834da$1cce82f0$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <051e01c834da$1cce82f0$5267a8c0@Jocke>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	'Jeff Garzik' <jeff@garzik.org>, linux-kernel@vger.kernel.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 02, 2007 at 12:54:36PM +0100, Joakim Tjernlund wrote:
> [SNIP]
> > ^^ the correct solution is to implement arch_initcall function
> > which will create fixed PHYs, and then leave only
> > snprintf(fpi->bus_id, 16, PHY_ID_FMT, 0, *data); part in the
> > fs_enet's find_phy().
> > 
> > Try add something like this to the fsl_soc.c (compile untested):
> > 
> > - - - -
> > static int __init of_add_fixed_phys(void)
> > {
> > 	struct device_node *np;
> > 	const u32 *prop;
> > 	struct fixed_phy_status status = {};
> > 
> > 	while ((np = of_find_node_by_name(NULL, "ethernet"))) {
> > 		data  = of_get_property(np, "fixed-link", NULL);
> > 		if (!data)
> > 			continue;
> > 
> > 		status.link = 1;
> > 		status.duplex = data[1];
> > 		status.speed  = data[2];
> 
> What about Pause and Asym_Pause?

Will be addressed in the next respin of these patches. Let's
hope on Monday.

> Dunno why so few, if any, eth drivers
> impl. it, but the PHY lib supports it.
> Even if fixed PHYs doesn't support it directly I think the OF interface
> should have it.
> 
>     - fixed-link : <a b c d e> where a is emulated phy id - choose any,
>       but unique to the all specified fixed-links, b is duplex - 0 half,
>       1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no pause,
>       1 pause, d asym_pause - 0 no asym_pause, 1 asym_pause.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
