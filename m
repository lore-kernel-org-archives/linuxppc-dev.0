Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn8g26qT4zDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 22:47:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id s66so6669847pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 05:47:26 -0700 (PDT)
Date: Tue, 13 Jun 2017 22:47:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/14] powerpc/64s: cpuidle no memory barrier after
 break from idle
Message-ID: <20170613224713.2554e0c9@roar.ozlabs.ibm.com>
In-Reply-To: <20170612174844.GC4340@drishya.in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-13-npiggin@gmail.com>
 <20170612174844.GC4340@drishya.in.ibm.com>
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

On Mon, 12 Jun 2017 23:18:44 +0530
Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> * Nicholas Piggin <npiggin@gmail.com> [2017-06-12 09:58:33]:
> 
> > A memory barrier is not required after the task wakes up,
> > only if we clear the polling flag before waking. The case
> > where we have work to do is the important one, so optimise
> > for it.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> 
> > ---
> >  drivers/cpuidle/cpuidle-powernv.c | 11 +++++++++--
> >  drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++--
> >  2 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > index 9d03326ac05e..37b0698b7193 100644
> > --- a/drivers/cpuidle/cpuidle-powernv.c
> > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > @@ -59,14 +59,21 @@ static int snooze_loop(struct cpuidle_device *dev,
> >  	ppc64_runlatch_off();
> >  	HMT_very_low();
> >  	while (!need_resched()) {
> > -		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
> > +		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
> > +			/*
> > +			 * Task has not woken up but we are exiting the polling
> > +			 * loop anyway. Require a barrier after polling is
> > +			 * cleared to order subsequent test of need_resched().
> > +			 */
> > +			clear_thread_flag(TIF_POLLING_NRFLAG);
> > +			smp_mb();
> >  			break;
> > +		}
> >  	}
> > 
> >  	HMT_medium();
> >  	ppc64_runlatch_on();
> >  	clear_thread_flag(TIF_POLLING_NRFLAG);
> > -	smp_mb();  
> 
> If we reach here without executing if(snooze_timeout) with the
> barrier+break, that means we have seen the need_resched flag and hence
> we can avoid the barrier.  Clearing of the polling flag can be seen
> (take affect) later as we will exit the idle loop and re-enter anyway
> at this point.  The caller also will check for need_resched and exit
> the idle loop.
> 
> Actually do_idle() has a __current_set_polling() and
> __current_clr_polling() in the default idle loop.  Do we really need
> to set/clear the TIF_POLLING_NRFLAG again in cpuidle driver?

We do because cpuidle drivers are entered with POLLING clear, don't
they?

It would be nice to have the entire scheduler idle including cpuidle
entry run with POLLING set. It would then be up to interrupt-based
cpuidle drivers to clear POLLING before sleeping. I think that should
remove... maybe 4 atomic ops from the most performance-critical idle
states (the polling ones).

That's a bigger change though and will touch many archs and core code.

Thanks,
Nick
