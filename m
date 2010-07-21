Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206]) by ozlabs.org (Postfix) with ESMTP id 1F1B6B70B8
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 09:21:28 +1000 (EST)
Received: from mail7-am1 (localhost.localdomain [127.0.0.1])	by
	mail7-am1-R.bigfish.com (Postfix) with ESMTP id E82675500B3	for
	<linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 23:21:23 +0000 (UTC)
Received: from am1ehsmhs005.bigfish.com (unknown [10.3.201.241])	by
	mail7-am1.bigfish.com (Postfix) with ESMTP id 6D0E05C004E	for
	<linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 23:21:23 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6LNLAiv004456	for <linuxppc-dev@ozlabs.org>;
	Wed, 21 Jul 2010 16:21:21 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6LNW6kx010684	for <linuxppc-dev@ozlabs.org>;
	Wed, 21 Jul 2010 18:32:06 -0500 (CDT)
Date: Wed, 21 Jul 2010 18:21:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers
Message-ID: <20100721182108.5a22c822@schlenkerla.am.freescale.net>
In-Reply-To: <20100721153933.64d02086.akpm@linux-foundation.org>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Peter Tyser <ptyser@xes-inc.com>, Anton Vorontsov <avorontsov@mvista.com>,
	linux-kernel@vger.kernel.org, Dave Jiang <djiang@mvista.com>,
	linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Jul 2010 15:39:33 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jul 2010 15:12:24 -0500
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > > 
> > >  drivers/edac/mpc85xx_edac.c |    8 ++++++++
> > >  1 files changed, 8 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> > > index 52ca09b..3820879 100644
> > > --- a/drivers/edac/mpc85xx_edac.c
> > > +++ b/drivers/edac/mpc85xx_edac.c
> > > @@ -646,8 +646,12 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
> > >  	{ .compatible = "fsl,mpc8555-l2-cache-controller", },
> > >  	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
> > >  	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
> > > +	{ .compatible = "fsl,mpc8569-l2-cache-controller", },
> > >  	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
> > > +	{ .compatible = "fsl,p1020-l2-cache-controller", },
> > > +	{ .compatible = "fsl,p1021-l2-cache-controller", },
> > >  	{ .compatible = "fsl,p2020-l2-cache-controller", },
> > > +	{ .compatible = "fsl,p4080-l2-cache-controller", },
> > 
> > L2 on the p4080 is quite different from those other chips.  It's part
> > of the core, controlled by SPRs.
> 
> erm, was that an ack or a nack?

NACK, p4080 doesn't belong in this table, at least not its L2.

L3 on p4080 is similar to L2 on these other chips, though, and it
wouldn't take much to get this driver working on it -- but the match
table entry should wait until the differences are accommodated.

-Scott
