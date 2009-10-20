Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA8D9B7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Oct 2009 02:56:05 +1100 (EST)
Date: Tue, 20 Oct 2009 10:56:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Richard Cochran <richard.cochran@omicron.at>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <20091020155625.GC9867@loki.buserror.net>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
	<20091014152722.GA17867@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
	<20091015162728.GB3730@loki.buserror.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE800@alice.at.omicron.at>
	<20091016160125.GC11838@loki.buserror.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AECFD@alice.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E30E2AECFD@alice.at.omicron.at>
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 20, 2009 at 12:01:19PM +0200, Richard Cochran wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:scottwood@freescale.com]
> >
> > What problems have you been having with upstream kernels on mpc8313erdb,
> > other than this IRQ issue?  It should work, though the BSP may have extra
> > features that haven't been pushed upstream.
> 
> I have been working from kernel 2.6.30 (although the very latest
> kernel is just the same WRT these problems, AFAICT). I had to patch in
> order to sovle the following three problems:
> 
> 1. The flash layout in the DTS does not match the default partitioning
>    from Freescale. In the current dts, the NAND partitioning is wrong,
>    and there is no partitioning for the NOR flash given.

OK, I wasn't aware of that -- that kind of thing is an artifact of the BSP
development process being fairly separate from upstream development.  The
"open source team" works on upstream Linux and upstream U-Boot.  We don't
run the BSP u-boot (since we're developing the newer u-boot), and it's easy
to miss when things like this diverge.

In this case, I'd be surprised if the NAND partitioning that is upstream
came from anywhere but an early BSP's Linux tree.  There's not much we (the
upstream-focused developers) can do if different BSPs have different layouts
(other than not specify a layout at all)...  What is the layout you see in
your BSP?

> 2. The eTSEC interrupt issue that started this thread.

Well, yes. :-)

> 3. The PTP IO signals are not configured in a vanilla linux. For this,
>    you need parts of a Freescale patch. [1] Their PTP implementation
>    gianfar driver is horrible, but still, the IO configuration in
>    these two files in the patch is necessary to get any external
>    signals from the PTP clock:
> 
>    arch/powerpc/platforms/83xx/mpc8313_rdb.c
>    arch/powerpc/platforms/83xx/mpc83xx.h

Yes, this is one of those features that is currently BSP-only (partly due to
it needing work, as you note above).  That's different than the board simply
not being supported upstream, but if you need it, you need it.  I'll raise
the issue in my team, but I suggest also letting Freescale support (or other
official feedback channels) know what you'd like to see in terms of
improvements in that code and getting it upstream.

-Scott
