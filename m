Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D429967AC7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 06:27:05 +1000 (EST)
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060531200419.GA17052@mag.az.mvista.com>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
	<20060530204151.GA31567@mag.az.mvista.com>
	<1149023558.6507.15.camel@brick>
	<20060531200419.GA17052@mag.az.mvista.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 16:26:43 -0400
Message-Id: <1149107204.6507.97.camel@brick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-31 at 13:04 -0700, Mark A. Greer wrote:
> On Tue, May 30, 2006 at 05:12:37PM -0400, Michal Ostrowski wrote:
> > On Tue, 2006-05-30 at 13:41 -0700, Mark A. Greer wrote:
> > > On Mon, May 29, 2006 at 10:01:03PM -0400, mostrows@watson.ibm.com wrote:


> > I'm curious how the tacked-on dt is expected to interact with the real
> > FW dt,
> 
> That's a good question.  I was thinking that a tacked on dt would be a
> complete replacement for whatever dt came from the fw (but extracting
> some info like /memory props).  That probably works okay for non-OF
> systems but may not work for OF systems b/c there is so much more info
> in the OF dt.  Someone who knows about OF will have to speak up here.
> 

I've had some experience with trying to edit existing OF trees (i.e.
take a G5 OF tree and alter it to reflect the fact that the OS has a
hypervisor between it and the HW).  It's not a pleasant experience.

Thus for OF based systems I'd be very wary of trying to edit the OF tree
in arbitrary ways prior to Linux seeing it.

> > and in particular how you would expect the interrogation
> > of /chosen/bootargs in prom_init.c (using prom_getprop()) to pick up the
> > command line value I specify in the tacked-on dt.
> 
> If a flattened dt is used instead of an OF dt the prom_init code isn't used.

If we always skip prom_init.c code then we may skip stuff like TCE
allocation which is only ever done on the first boot (and never on
kexec).  


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
