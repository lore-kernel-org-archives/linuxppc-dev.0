Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id 6E6756822A
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2005 02:39:22 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0601.wanadoo.fr (SMTP Server) with ESMTP id 75E001C00274
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 18:39:15 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-27-135.w82-126.abo.wanadoo.fr
	[82.126.145.135])
	by mwinf0601.wanadoo.fr (SMTP Server) with ESMTP id 53F301C0026B
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 18:39:15 +0200 (CEST)
Date: Wed, 31 Aug 2005 18:33:13 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050831163313.GA25391@localhost.localdomain>
References: <20050830233205.GB24345@xyzzy.farnsworth.org>
	<20050831055934.871E41C00097@mwinf1107.wanadoo.fr>
	<20050831160417.GA3848@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831160417.GA3848@mag.az.mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-dev@ozlabs.org
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2005 at 09:04:17AM -0700, Mark A. Greer wrote:
> On Wed, Aug 31, 2005 at 07:55:49AM +0100, Nicolas DET wrote:
> > > This is a good idea.  I suspect that most of the gain is from
> > > turning off snooping and flushing/invalidating the cache explicitly.
> > > Implementation-wise, I'd rather we not manipulate the MV643XX_ETH_BAR_?
> > > registers directly in the driver.  Today that is done in platform
> > > setup code.  This has promise but needs to be reworked.
> > 
> > Yeah, the point was to have no snooping for this part of the chip.
> > The descriptors in SRAM, and the data in DDR. This give a serious boost.
> > 
> > I noticed MV643xx memory performances are really higher when turning
> > off snoop (not only for ethernet).
> > 
> > Well, I confess manipulating such thing here, is not totaly smart.
> > However I don't really know where to put them.
> > Maybe, somewhere in arch/ppc ?
> > 
> > Because, at some pooint the driver will need to have this modified in order
> > to reall work correctly.
> > 
> > For example, if you use a module with that option (it will disable
> > snooping) and then 'rmmod & modprobe' a new module without it will not work
> > (no snooping as the new module expect!).
> > 
> > Conclusion: yes, touching ETH_BAR isn't really well here, but where could
> > we move it ?
> 
> The enet->mem BARs are configured in
> arch/ppc/syslib/mv64xc60.c:mv64360_config_io2mem_windows().

Which is not used in the pegasos code path, as we are chrp though.

Friendly,

Sven Luther
