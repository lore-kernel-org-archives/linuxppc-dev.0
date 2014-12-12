Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9693D1A09D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 16:19:53 +1100 (AEDT)
Message-ID: <1418361592.1465.1.camel@ellerman.id.au>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 12 Dec 2014 16:19:52 +1100
In-Reply-To: <1418255437.5581.45.camel@freescale.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <1417805565.334.15.camel@freescale.com> <1418098262.527.1.camel@concordia>
 <1418159084.5581.32.camel@freescale.com>
 <1418169405.30244.1.camel@concordia>
 <1418170485.5581.39.camel@freescale.com>
 <1418177689.30244.4.camel@concordia>
 <1418255437.5581.45.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <gkurz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-10 at 17:50 -0600, Scott Wood wrote:
> On Wed, 2014-12-10 at 13:14 +1100, Michael Ellerman wrote:
> > On Tue, 2014-12-09 at 18:14 -0600, Scott Wood wrote:
> > > What benefit is there to ignoring "scripture" here?  Going from an easy
> > > to use command line option to needing to mess around with the dts file
> > > is not a usability improvement.  If you want to make it Freescale-only,
> > > fine.  If you want to push me to fix the problems with the
> > > implementation, fine.
> > 
> > It's easy to use but it doesn't necessarily work.
> > 
> > You said in your other mail to Greg "Sometimes it's useful to ensure that the
> > second thread has never run when debugging a problem.".
> > 
> > But you don't know that, for all you know your firmware has started the thread
> > and it's busy looping somewhere. Perhaps you guys know that your firmware
> > doesn't do that, but it's still a hack.
> 
> I know that our firmware doesn't do that, and I can verify by reading
> the relevant register.

Lucky you :)

> > We end up with cpus in the present map, but we have no idea where they are or
> > what they are doing.
> 
> Can we check smt-enabled a little earlier and refrain from marking the
> secondary threads as present if smt is disabled?

We could, and that would make the semantics much saner. But it would actually
be exactly the opposite of what the folks who originally hit this bug want to
happen.

They are using it as a shortcut for cpu hotunplug, ie. they want the threads
asleep in Linux ready to be hotplugged back in.

This is why I wanted to remove it, because those are both valid expectations of
what smt-enabled=off should do, but they are mutually exclusive. Not to mention
that the current code doesn't implement either of those properly.

Anyway for now we should just ignore it on powernv. We can look at doing
something saner in general in future.

cheers
