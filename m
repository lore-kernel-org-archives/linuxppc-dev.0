Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 120D7DDF42
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 12:36:16 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m772ZVHK018810
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 12:35:31 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m772aCSb026220
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 12:36:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m772aBQ7005096
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 12:36:11 +1000
Date: Thu, 7 Aug 2008 12:36:03 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: dtc update for in-kernel version
Message-ID: <20080807023603.GD24443@yookeroo.seuss>
References: <1218026580.2328.69.camel@localhost.localdomain>
	<6606960D-022E-4B6E-AAB8-036839469820@kernel.crashing.org>
	<20080806093522.5e076fd6@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080806093522.5e076fd6@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 09:35:22AM -0400, Josh Boyer wrote:
> On Wed, 6 Aug 2008 08:29:30 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> > 
> > On Aug 6, 2008, at 7:43 AM, Josh Boyer wrote:
> > 
> > > So we asked about this a while ago and I haven't seen anything yet,  
> > > but
> > > is there going to be an update to the version of DTC that is in the
> > > kernel tree?  1.2 is out now, would be a good idea to update soon.
> > 
> > is there any reason to update to 1.2 for 2.6.27?
> 
> Probably not at this point in the lifecycle.  We brought this up
> before the merge window opened though, so I'm just wondering what the
> general plan is.  Seems lots of fixes and such are getting put out, but
> not pulled into the kernel.

There isn't really a general plan, someone just needed to get around
to assembling the patch.  I just sent out a patch which updates the
in-kernel dtc and libfdt to 1.2.

Longer term, once microblaze support goes into mainline, we probably
should move the in-kernel copy to scripts/ and/or lib/ so that powerpc
and microblaze can share it.

It would be nice to have some better automagical way of pulling the
dtc git tree into a kernel git tree, but I haven't gotten my heard
around the gittery involved.  There's a bit more to it than simply
importing the dtc tree verbatim into the kernel tree - the pulls from
upstream would need to be co-ordinated in some cases with updates to
the in-kernel makefiles, libfdt_env.h and users of dtc and libfdt.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
