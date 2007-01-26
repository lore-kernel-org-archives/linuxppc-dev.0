Return-Path: <linas@austin.ibm.com>
Date: Fri, 26 Jan 2007 11:58:37 -0600
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: spidernet: dynamic phy setup code
Message-ID: <20070126175837.GB8489@austin.ibm.com>
References: <200701261409.29537.jens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701261409.29537.jens@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2007 at 02:09:29PM +0100, Jens Osterkamp wrote:
> This patch modifies the patch submitted by Kou Ishizaki to make it work on the
> blade (http://marc.theaimsgroup.com/?l=linux-netdev&m=116593424505539&w=2).
> 
> Index: linux-2.6/drivers/net/spider_net.c
> + if (card->aneg_count > SPIDER_NET_ANEG_TIMEOUT) {
> +
> +  pr_info("%s: link is down, trying to bring it up\n", card->netdev->name);
> +
> +  switch(phy->medium) {
> +  case GMII_COPPER:
> +   /* enable fiber with autonegotiation first */
> +   if (phy->def->ops->enable_fiber)
> +    phy->def->ops->enable_fiber(phy, 1);
> +   phy->medium = GMII_FIBER;
> +   break;

Can you fix this to use tabs for indentation, instead of spaces?

Please note, if you do not like tabs of 8 spaces, you can always
change this in your editor, e.g "set ts=3" for making a tab 
be 3 spaces in vi. You would put this in your .exrc or .vimrc file.

Patches submitted to the kernel should use tabs, uniformly.

--linas
