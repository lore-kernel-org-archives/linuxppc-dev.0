Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D662067A42
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 07:04:58 +1000 (EST)
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: Matthew McClintock <msm@freescale.com>
In-Reply-To: <1149107718.8379.48.camel@localhost.localdomain>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
	<20060530204151.GA31567@mag.az.mvista.com>
	<1149023558.6507.15.camel@brick>
	<20060531200419.GA17052@mag.az.mvista.com>
	<1149107204.6507.97.camel@brick>
	<1149107718.8379.48.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 May 2006 17:04:36 -0400
Message-Id: <1149109476.6507.115.camel@brick>
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

On Wed, 2006-05-31 at 15:35 -0500, Matthew McClintock wrote:
> On Wed, 2006-05-31 at 16:26 -0400, Michal Ostrowski wrote:
> > I've had some experience with trying to edit existing OF trees (i.e.
> > take a G5 OF tree and alter it to reflect the fact that the OS has a
> > hypervisor between it and the HW).  It's not a pleasant experience.
> > 
> > Thus for OF based systems I'd be very wary of trying to edit the OF
> > tree
> > in arbitrary ways prior to Linux seeing it. 
> 
> Out of curiosity what was hard about it? 

Well, suppose that you want to remove a particular device from an OF
tree.  At what point are you certain that you've completely removed all
references to it?

I've always been concerned that there are some properties remaining in
the tree that may refer to the node I am removing (resulting in an
inconsistent tree).  If you're working with one particular FW provider
then you may come up with code that does it right, but such code may not
necessarily catch all the extensions provided by another FW provider.  

I've found Apple and IBM FW like to do things in different ways.  In
particular IBM FW likes to add "ibm,*" properties and you'd have to know
the meaning of all such properties to ensure you've caught all
references to the device you're pruning.

Like with most things, getting a solution to solve your immediate
problem is easy; a perfect, general solution is much, much more
difficult.


(Granted, some things, such as adding a new "memory" node are pretty
easy to do.)

> Also it is worth mentioning
> some systems don't have to privilege of having a OF tree ready to go by
> the time Linux starts.

For such systems I think the right approach is to provide a
DTC-generated OF tree (provided that one ensures that we don't skip
important parts of prom_init.c).



-- 
Michal Ostrowski <mostrows@watson.ibm.com>
