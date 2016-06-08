Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPmPR26crzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:27:23 +1000 (AEST)
Message-ID: <1465385242.13854.9.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Add POWER8NVL support to
 ibm,client-architecture-support call
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 08 Jun 2016 21:27:22 +1000
In-Reply-To: <5757FEAC.2050002@redhat.com>
References: <1464673877-30659-1-git-send-email-thuth@redhat.com>
 <1464689047.23025.1.camel@ellerman.id.au> <574D6549.3050903@redhat.com>
 <1464690745.23025.2.camel@ellerman.id.au>
 <70305fb4-d345-bd89-e395-04c39b266fe4@gmail.com>
 <1465382664.13854.1.camel@ellerman.id.au> <5757FEAC.2050002@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 13:17 +0200, Thomas Huth wrote:
> On 08.06.2016 12:44, Michael Ellerman wrote:
> > On Wed, 2016-06-08 at 11:14 +1000, Balbir Singh wrote:
> > > Don't we need to update IBM_ARCH_VEC_NRCORES_OFFSET as well?
> > 
> > Yep, patch sent this morning.
> 
> Ok, looks like BenH already posted a patch ...

And me before him :)

To be clear I'm not blaming you in any way for this, the existing code is
terrible and incredibly fragile.

> anyway, what do you think about aborting the boot process here in case cores
> != NR_CPUS, rather than just printing out a small warning which can easily get
> lost in the kernel log?

Yeah I agree it's easy to miss. And it's not part of dmesg (because it's from
prom_init()), so you *only* see it if you're actually staring at the console as
it boots (which is why my boot tests missed it).

I actually have plans to rewrite the whole thing to make it robust, so that
should avoid it ever being a problem again.

cheers
