Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 8F85968110
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 09:53:10 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 30 Aug 2005 16:32:05 -0700
To: Nicolas DET <det.nicolas@free.fr>
Message-ID: <20050830233205.GB24345@xyzzy.farnsworth.org>
References: <20050830181958.D856F1C0008A@mwinf0706.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050830181958.D856F1C0008A@mwinf0706.wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2005 at 08:16:12PM +0100, Nicolas DET wrote:
> You can find enclosed a patch for the Marvell MV643xx ethernet driver.
> 
> It's also there:
> http://arrakin.homedns.org/~nicolas/mv643xx_eth.tar.gz (tarball)
> http://arrakin.homedns.org/~nicolas/mv643xx_eth.diff.bz2 
> 
> The diff is against the kernel 2.6.13 (kernel.org).

Thank you for working on this driver, Nicolas.

> The main changes (AFAIR):
> * Workaround for the TCP/UDP hw checksum

I implemented something similar a while back, but found it too ugly to
keep around.  Fortunately, there is already a much simpler workaround for
the hw checksum bug in linux-2.6.git.  See
	http://oss.sgi.com/archives/netdev/2005-08/msg00124.html

> * Use hardware for statistics

This is good.  We need to remove the code it replaces rather than
have it partially ifdeffed out.  Can you do that and split this part
out as a separate patch and submit to netdev@vger.kernel.org ?

> * Define and use SRAM (for pegasos II archp/ppc/chrp_pegasos_eth.c)

Good.  This is pegasos-specific and it would be good to split this
patch out from the mv643xx driver bits.  Descriptors in SRAM is a big win.  

> * Able to use max burst size from/to DDR (serious transfer boost)

This is a good idea.  I suspect that most of the gain is from
turning off snooping and flushing/invalidating the cache explicitly.
Implementation-wise, I'd rather we not manipulate the MV643XX_ETH_BAR_?
registers directly in the driver.  Today that is done in platform
setup code.  This has promise but needs to be reworked.

> * Option can be selected through the menu (drivers/net/Kconfig)

Do these really need to be user configurable?

The following shouldn't be user options, IMHO:
MV643XX_CHECKSUM_OFFLOAD_TX -- on
MV643XX_CHECKSUM_OFFLOAD_TX_WORKAROUND -- on
MV64XXX_HWSTATS -- on
MV643XX_COAL -- on
MV64XXX_USESRAM -- on/off depending on platform
MV64XXX_MAXBURST -- on/off depending on platform

I'm not as sure about MV643XX_NAPI, but I think it should always be on
for GigE drivers.  Is it worth being able to turn off NAPI?

Some general comments:
Several Kconfig hunks seem unrelated to MV643XX
Several lines in the patch have trailing whitespace.
C++ style comments (//) aren't acceptable.
Why the addition of EXTRA_BYTES to the definition of RX_SKB_SIZE?  Did
you see problems without it?

-Dale Farnsworth
