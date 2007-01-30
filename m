Return-Path: <linas@austin.ibm.com>
Date: Tue, 30 Jan 2007 16:30:50 -0600
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: spidernet: add improved phy support in sungem_phy.c
Message-ID: <20070130223050.GE5616@austin.ibm.com>
References: <200701261407.48237.jens@de.ibm.com>
	<1169842847.24996.106.camel@localhost.localdomain>
	<200701262331.58491.jens@de.ibm.com>
	<20070126233809.GA16660@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070126233809.GA16660@electric-eye.fr.zoreil.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: James K Lewis <jim@jklewis.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, jgarzik@pobox.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 27, 2007 at 12:38:09AM +0100, Francois Romieu wrote:
> Jens Osterkamp <jens@de.ibm.com> :
> > 
> Index: linux-2.6.20-rc5/drivers/net/sungem_phy.c
> ===================================================================
> --- linux-2.6.20-rc5.orig/drivers/net/sungem_phy.c
> +++ linux-2.6.20-rc5/drivers/net/sungem_phy.c
> @@ -311,6 +311,107 @@ static int bcm5411_init(struct mii_phy* 
> [...]
> +	if ( (phy_reg & 0x0020) >> 5 ) {

Shifting to the right by 5 bits has no effect on the result
of this conditional. Either the bit is set, or its not.
There is no need to shift.

> +	if ( (phy_reg & 0x0020) >> 7 ) {

The result here will always be zero, since the bit,
if set, will be shifted off the end. Bits on the lef
are padded with zero.  Ergo, this is a bug.

--linas
