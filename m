Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 905D0DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 18:10:18 +1000 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Thu, 7 Jun 2007 10:10:04 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706050900.54022.jdubois@mc.com>
	<1181203139.4166.26.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1181203139.4166.26.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706071010.05172.jdubois@mc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007 09:58:59 Michael Ellerman wrote:
> On Tue, 2007-06-05 at 09:00 +0200, Jean-Christophe Dubois wrote:
> > On Monday 04 June 2007 15:00:05 Michael Ellerman wrote:
> > > +       pr_debug("axon_msi: initialising ...\n");
> > > +
> > > +       for_each_compatible_node(node, NULL, "ibm,axon-msic") {
> > > +               if (axon_msi_setup_one(of_node_get(node)) == 0)
> > > +                       found++;
> > > +       }
> > > +       of_node_put(node);
> >
> > 2 comments:
> >
> > 1) There is no "ibm,axon-msic" compatible property in the SLOF tree
> > provided by IBM on the CAB (or other such platforms). Therefore this code
> > will not work on these platforms.
>
> It's not clear to me if MSIs will work on CAB, with Axon in end-point
> mode. But it'd be good to try it at some point.

The CAB (or other derived products) can be set in RC mode (via a jumper). In 
this case the MSI could be supported.

> The compatible property is new, it's only just been added to SLOF
> recently by Heiko, not sure when it will be in released firmware.
>
> > 2) you should somehow check for the Axon version. Axon 1.1 (and prior)
> > are know to be loosing MSI/MBX interrupts (but not the data part
> > associated to them). Therefore this should be enabled only on Axon 2.1
> > (or later).
>
> Yep. It works some of the time on 1.1, but not enough to enable it.
>
> I guess I'd say firmware that runs on 1.1 should just not export the msi
> nodes, or not put the compatible property on them - rather than having
> the kernel explicitly checking for the version.
>
> cheers
