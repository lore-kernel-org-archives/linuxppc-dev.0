Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AC74DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 17:53:26 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Fix viodasd driver with scatterlist debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080312174418.e7206a9b.sfr@canb.auug.org.au>
References: <20080312062407.492AEDDED5@ozlabs.org>
	<20080312174418.e7206a9b.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 17:52:42 +1100
Message-Id: <1205304762.9431.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-03-12 at 17:44 +1100, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Wed, 12 Mar 2008 17:23:56 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > The iSeries viodasd drivers does some very strange things with
> > scatterlists, one of these causing a BUG_ON to trigger when
> > scatterlist debugging is enabled due to initializing the
> > scatterlist with memset instead of sg_init_table().
> > 
> > This fixes it by using sg_init_table(). The rest of the stuff
> > it does to that poor list is still pretty awful but it will work.
> 
> Presumably this is also needed in 2.6.24.xx

Possibly, though the problem only occurs when enabling scatterlist
debug, which distros don't do. Is it worth putting in a stable release ?

If yes, I'll submit it as soon as it hits upstream.

Cheers,
Ben.
