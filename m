Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D42FB1A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 09:39:59 +1100 (AEDT)
Message-ID: <1418078384.5581.11.camel@freescale.com>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
From: Scott Wood <scottwood@freescale.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Mon, 8 Dec 2014 16:39:44 -0600
In-Reply-To: <20141208092321.673a0be3@bahia.local>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <1417805565.334.15.camel@freescale.com>
 <20141208092321.673a0be3@bahia.local>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-08 at 09:23 +0100, Greg Kurz wrote:
> On Fri, 5 Dec 2014 12:52:45 -0600
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > On Fri, 2014-12-05 at 16:14 +0100, Greg Kurz wrote:
> > > The smt-enabled kernel parameter basically leaves unwanted cpus executing
> > > in firmware or wherever they happen to be. The very same applies to the
> > > ibm,smt-enabled DT property which is no more used by anything known. These
> > > are hacks that shoudn't be used in a production environment.
> > > 
> > > Quoting mpe, "there are better ways for firmware to disable SMT".
> > 
> 
> Hi Scott,
> 
> > Those "better ways" don't apply to Freescale chips, where the OS enables
> > (or not) SMT without any interaction with firmware.  I don't care about
> > the ibm,smt-enabled property, but can we please keep the smt-enabled
> > boot option?
> > 
> 
> Fair enough for the firmware side, what about CPU hot(un)plug then ?

Not yet supported in mainline for e6500 (or maybe it works with
generic_mach_cpu_die which would not be helpful).

Plus, it's more complicated (both to use and how it works internally)
and doesn't avoid having the secondary thread ever run.  Sometimes it's
useful to ensure that the second thread has never run when debugging a
problem.

> > > It also has an evil side effect on the split-core feature for powernv. The
> > > code needs all the cpus to participate to the split mode update: it relies
> > > on smp_send_reschedule() to get offline ones to do so. This doesn't work with
> > > cpus that haven't come up... The consequence is a kernel hang on powernv when
> > > trying to limit the number of hw threads at boot time (e.g. smt-enabled to
> > > anything but 8 on POWER8).
> > 
> > In that case could you disable the option only on that hardware?
> > 
> 
> The fact it breaks only powernv doesn't mean it is a powernv only issue.
> The smt-enabled feature is a hack because it leaves some cpus in a undefined
> state from a kernel POV.

I'm aware of an issue where per-cpu threads get created for these CPUs,
which seems like a bug if they were never marked online (it's on my todo
list to investigate further).  Are there other issues?  It seems like
there ought to be some way to do this right.

>  Moreover it drags about 80 lines of code and sits entirely in common
> ppc64 code. I would reverse the question then ? Why not moving
> smt-enabled code to freescale only ?

I'm fine with making it Freescale-only.

-Scott
