Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3FB11A0E46
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:23:32 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 08:23:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 76B2F17D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 08:23:46 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB88NPgD57278692
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 08:23:25 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB88NOLt009974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 01:23:25 -0700
Date: Mon, 8 Dec 2014 09:23:21 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
Message-ID: <20141208092321.673a0be3@bahia.local>
In-Reply-To: <1417805565.334.15.camel@freescale.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <1417805565.334.15.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Dec 2014 12:52:45 -0600
Scott Wood <scottwood@freescale.com> wrote:

> On Fri, 2014-12-05 at 16:14 +0100, Greg Kurz wrote:
> > The smt-enabled kernel parameter basically leaves unwanted cpus executing
> > in firmware or wherever they happen to be. The very same applies to the
> > ibm,smt-enabled DT property which is no more used by anything known. These
> > are hacks that shoudn't be used in a production environment.
> > 
> > Quoting mpe, "there are better ways for firmware to disable SMT".
> 

Hi Scott,

> Those "better ways" don't apply to Freescale chips, where the OS enables
> (or not) SMT without any interaction with firmware.  I don't care about
> the ibm,smt-enabled property, but can we please keep the smt-enabled
> boot option?
> 

Fair enough for the firmware side, what about CPU hot(un)plug then ?

> > It also has an evil side effect on the split-core feature for powernv. The
> > code needs all the cpus to participate to the split mode update: it relies
> > on smp_send_reschedule() to get offline ones to do so. This doesn't work with
> > cpus that haven't come up... The consequence is a kernel hang on powernv when
> > trying to limit the number of hw threads at boot time (e.g. smt-enabled to
> > anything but 8 on POWER8).
> 
> In that case could you disable the option only on that hardware?
> 

The fact it breaks only powernv doesn't mean it is a powernv only issue.
The smt-enabled feature is a hack because it leaves some cpus in a undefined
state from a kernel POV. Moreover it drags about 80 lines of code and sits
entirely in common ppc64 code. I would reverse the question then ? Why not
moving smt-enabled code to freescale only ?

> > This patch simply removes both the smt-enabled kernel parameter and the
> > ibm,smt-enabled property for all platforms. The new default is to start
> > all hw threads. That leaves /sys the only supported API to change SMT
> > settings.
> 
> How would you use /sys for this?  Are you talking about CPU hotplug?
> 

Yes. This is the safer way to offline cpus.

> -Scott
> 

Cheers.

--
Greg
