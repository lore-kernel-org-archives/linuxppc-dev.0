Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnl7n3sdNzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 21:40:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/13] powerpc/64s: cpuidle set polling before enabling
 irqs
In-Reply-To: <20170613130557.26315-10-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-10-npiggin@gmail.com>
Date: Wed, 14 Jun 2017 21:40:52 +1000
Message-ID: <87efum3igr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> local_irq_enable can cause interrupts to be taken which could
> take significant amount of processing time. The idle process
> should set its polling flag before this, so another process that
> wakes it during this time will not have to send an IPI.
>
> Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 4 +++-
>  drivers/cpuidle/cpuidle-pseries.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

I don't think the cpuidle folks are really interested in these changes,
but we should Cc them to be polite.

Can you resend patches 9, 10, 11 with a subject like:

  "cpuidle: powernv: Set polling ..."

And Cc the cpuidle folks:

$ ./scripts/get_maintainer.pl -f drivers/cpuidle
rjw@rjwysocki.net
daniel.lezcano@linaro.org
linux-pm@vger.kernel.org
linux-kernel@vger.kernel.org

cheers
