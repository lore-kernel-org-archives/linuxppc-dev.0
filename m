Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 71AB0DDDAF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 04:30:49 +1100 (EST)
Date: Fri, 13 Feb 2009 20:30:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 11/13] sdhci: Add quirk for controllers that need IRQ
	re-init after reset
Message-ID: <20090213173047.GA10728@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144738.GK23889@oksana.dev.rtsoft.ru>
	<200902131647.17728.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200902131647.17728.laurentp@cse-semaphore.com>
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 13, 2009 at 04:47:13PM +0100, Laurent Pinchart wrote:
> Hi Anton,
> 
> On Friday 13 February 2009 15:47:38 Anton Vorontsov wrote:
[...]
> > sdhci_host *host) static void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  {
> >  	unsigned long timeout;
> > +	u32 ier = 0; /* shut up gcc */
> 
> You should use
> 
> 	u32 uninitialized_var(ier);
> 
> instead to avoid generating extra code.

Thanks Laurent, will fix.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
