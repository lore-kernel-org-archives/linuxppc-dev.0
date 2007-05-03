Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB344DDFF0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 07:37:08 +1000 (EST)
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1178208838.17201.52.camel@ld0161-tx32>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<1178187440.20944.12.camel@localhost.localdomain>
	<1178208838.17201.52.camel@ld0161-tx32>
Content-Type: text/plain
Date: Fri, 04 May 2007 07:36:48 +1000
Message-Id: <1178228208.6353.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 11:13 -0500, Jon Loeliger wrote:
> On Thu, 2007-05-03 at 05:17, Adrian Cox wrote:
> > On Wed, 2007-05-02 at 16:34 -0500, Jon Loeliger wrote: 
> > > From: James.Yang <James.Yang@freescale.com>
> > > 
> > > Remove CPU_FTR_NEED_COHERENT for MPC7448 (and single-core MPC86xx).
> > > This prevents needlessly setting M=1 when not SMP.
> > 
> > There may be side effects to removing this. Most of the 74xx processors
> > had this flag added because of the L2 prefetch bug (erratum #16 on the
> > 7447A). I see that bug is missing from the 7448 errata.
> > 
> > The problem is that many 32-bit PowerPC machines needed
> > CPU_FTR_NEED_COHERENT set for a second reason: compatibility with the
> > cache in the MPC107. This was handled by CPU_FTR_COMMON in cputable.h
> > before the L2 prefetch bug was known.  There may be other host bridges
> > that cache, but nobody will have noticed because all the CPUs had
> > CPU_FTR_NEED_COHERENT set already.
> 
> Adrian,
> 
> Yes, you are correct and your concern is valid.  However,
> this case is still being handled by CONFIG_MPC10X_BRIDGE
> to deal with the MPC106/MPC107/etc north bridges.

I still maintain it should be a runtime thing tho :-)

Ben.
