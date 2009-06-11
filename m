Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 30B37B719B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 09:33:39 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2148EDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 09:33:39 +1000 (EST)
Date: Fri, 12 Jun 2009 09:29:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH v2 -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Message-ID: <20090611232902.GA6767@yookeroo.seuss>
References: <1244673039-1089-1-git-send-email-ncase@xes-inc.com>
	<20090611013201.GA31850@yookeroo.seuss>
	<1244736299.29684.1641.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244736299.29684.1641.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 11:04:59AM -0500, Nate Case wrote:
> Hi David,
> 
> Thanks for the comments.
> 
> On Thu, 2009-06-11 at 11:32 +1000, David Gibson wrote:
> > These last two aren't standard properties, so should probably be
> > "xes,form-factor" and "xes,boot-bank".
> 
> I'll just delete them for now since they're not critical.
> 
> > > +	pmcslots {
> > 
> > What does this structure model?  Without any reg properties it's kind
> > of hard to see what you could do with it.
> 
> This would be a bit more obvious to those familiar with CompactPCI and
> PMC modules.  It aims to describe how many PMC slots are in the system,
> and gives information on whether or not a module is installed and if
> it's monarch of the bus or not.  So it's really just a description of
> the hardware.  The properties themselves are useful because you may have
> to read from GPIO lines to get this information (which may be accessible
> only via I2C, which can't be done too early in the kernel).  A reg
> property could be used just for indexing the slots, but there are no
> real memory-mapped resources involved for the slot itself (that
> information would go in the PCI nodes).

Ok.  I guess it would be a bit more normal to associate this sort of
passive information more closely with the bus information it relates
to.  But I don't know whether that makes sense in this particular
instance.

> It'd be nice if we could get a device tree standard for this type of
> information in the future, but for now I can just delete it since we
> don't yet rely on it in the kernel.

Ok, that's probably reasonable for now.  I think it would be wise to
write up a draft binding for it.

> > > +
> > > +				tbi2: tbi-phy@11 {
> > > +					reg = <0x11>;
> > > +					device_type = "tbi-phy";
> > 
> > And this one, too.  Although this node should probably have a
> > compatible property instead.
> 
> I don't think I can drop that device_type yet.  All the other device
> trees for Freescale boards use it, and the Freescale MDIO driver appears
> to rely on it.  A future patch I suppose?

Ick, ok.  Fair enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
