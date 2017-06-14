Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnlpH3ZHmzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 22:10:47 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id d5so14249784pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 05:10:47 -0700 (PDT)
Date: Wed, 14 Jun 2017 21:50:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/13] powerpc/64s: cpuidle set polling before enabling
 irqs
Message-ID: <20170614215042.45dced67@roar.ozlabs.ibm.com>
In-Reply-To: <87efum3igr.fsf@concordia.ellerman.id.au>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-10-npiggin@gmail.com>
 <87efum3igr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Jun 2017 21:40:52 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > local_irq_enable can cause interrupts to be taken which could
> > take significant amount of processing time. The idle process
> > should set its polling flag before this, so another process that
> > wakes it during this time will not have to send an IPI.
> >
> > Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
> >
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  drivers/cpuidle/cpuidle-powernv.c | 4 +++-
> >  drivers/cpuidle/cpuidle-pseries.c | 3 ++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)  
> 
> I don't think the cpuidle folks are really interested in these changes,
> but we should Cc them to be polite.
> 
> Can you resend patches 9, 10, 11 with a subject like:
> 
>   "cpuidle: powernv: Set polling ..."
> 
> And Cc the cpuidle folks:
> 
> $ ./scripts/get_maintainer.pl -f drivers/cpuidle
> rjw@rjwysocki.net
> daniel.lezcano@linaro.org
> linux-pm@vger.kernel.org
> linux-kernel@vger.kernel.org

Yeah I can do that. I'll send them as thier own series. They don't
depend on any of the patches in this series, so I should have done
that in the first place.

Thanks,
Nick
