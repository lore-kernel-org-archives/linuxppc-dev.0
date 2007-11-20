Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: balbir@linux.vnet.ibm.com
Subject: Re: [PATCH] fix scaled time accounting possible divide by zero 
In-reply-to: <47425F8F.3060208@linux.vnet.ibm.com> 
References: <9965.1195529141@neuling.org> <47425F8F.3060208@linux.vnet.ibm.com>
Date: Tue, 20 Nov 2007 15:36:49 +1100
Message-ID: <19947.1195533409@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <47425F8F.3060208@linux.vnet.ibm.com> you wrote:
> Michael Neuling wrote:
> > This fixes a problem noticed by Balbir Singh
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > Paulus: can we send this up for 2.6.24?
> > 
> >  arch/powerpc/kernel/time.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6-ozlabs/arch/powerpc/kernel/time.c
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/time.c
> > +++ linux-2.6-ozlabs/arch/powerpc/kernel/time.c
> > @@ -244,8 +244,9 @@ void account_system_vtime(struct task_st
> >  		/* deltascaled includes both user and system time.
> >  		 * Hence scale it based on the purr ratio to estimate
> >  		 * the system time */
> > -		deltascaled = deltascaled * get_paca()->system_time /
> > -		(get_paca()->system_time + get_paca()->user_time);
> > +		if (get_paca()->user_time)
> > +			deltascaled = deltascaled * get_paca()->system_time /
> > +			(get_paca()->system_time + get_paca()->user_time);
> 
> Hi, Michael,
> 
> I'd be doubly careful with scaled multiplication approach, we tried this
> for CFS (please see task_utime() and task_stime() and the fixes that
> went around it). We ran into problems were due to multiplication
> rounding errors, we would see stime and utime go back after a period
> of time.
> 
> Please see http://kerneltrap.org/mailarchive/linux-kernel/2007/10/16/344377
> 
> Our problems were made severe by the fact that sum_exec_runtime and
> stime/utime accounting occured differently. stime/utime were sampled
> at jiffy boundaries and hence could we incorrect. I think we need
> to use rounding to ensure that ac_scaled*time never goes back
> due to rounding errors.

I've not changed the math here much, just the case of user_time being
zero.

Is this related to this patch specifically, or something that's been
wrong with these patches for a while?

Mikey
