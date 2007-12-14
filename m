Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EB3FFDDFA6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:17:46 +1100 (EST)
Date: Fri, 14 Dec 2007 02:23:13 -0600
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Message-ID: <20071214082313.GA28118@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
	<20071204184826.GA5758@lixom.net>
	<20071204194921.GB1253@localhost.localdomain>
	<20071204200121.GA6782@lixom.net>
	<20071205004841.GA25905@linux-sh.org>
	<20071205183912.GA4516@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071205183912.GA4516@loki.buserror.net>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 05, 2007 at 12:39:12PM -0600, Scott Wood wrote:
> On Wed, Dec 05, 2007 at 09:48:41AM +0900, Paul Mundt wrote:
> > On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> > > On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> > > >  	tristate "Generic platform device PATA support"
> > > > -	depends on EMBEDDED || ARCH_RPC
> > > > +	depends on EMBEDDED || ARCH_PPC
> > > 
> > > It needs to be || PPC, not || ARCH_PPC.
> > > 
> > Wrong. It needs to be EMBEDDED || ARCH_RPC || PPC.
> 
> Why is it dependent on anything other than platform bus support and ATA?

There's no way to specify dependency on platform bus as a config option,
that's likely what EMBEDDED was meant to do. Some platforms have platform
bus in spite of being !EMBEDDED, arch/arm/configs/rpc_defconfig seems
to be among those. PPC too.


-Olof
