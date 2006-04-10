Return-Path: <vatsa@in.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60919679F3
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 21:51:43 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ABpddi032654
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 07:51:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ABpdIm206304
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 07:51:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3ABpd89009070
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 07:51:39 -0400
Date: Mon, 10 Apr 2006 17:19:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] tickless idle cpu - Allow any CPU to update jiffies
Message-ID: <20060410114944.GA5564@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 08, 2006 at 09:04:15AM +1000, Paul Mackerras wrote:
> Srivatsa Vaddagiri writes:
> 
> > Currently, only boot CPU calls do_timer to update jiffies. This prevents
> > idle boot CPU from skipping ticks. Patch below, against 2.6.17-rc1-mm1,
> > allows jiffies to be updated from any CPU.
> 
> We have to be very careful here.  The code that keeps xtime and
> gettimeofday in sync relies on xtime being incremented as close as
> possible in time to when the timebase passes specific values.  Since
> we currently stagger the timer interrupts for the cpus throughout a
> jiffy, having cpus other than the boot cpus calling do_timer will
> break this and introduce inaccuracies.  There are also implications
> for the stolen time accounting on shared-processor LPAR systems.
> 
> I think we need to remove the staggering, thus having all cpus take
> their timer interrupt at the same time.  That way, any of them can
> call do_timer.  However we then have to be much more careful about
> possible contention, e.g. on xtime_lock.  Your patch has every cpu
> taking xtime_lock for writing rather than just the boot cpu.  I'd like
> to see if there is some way to avoid that (while still having just one
> cpu call do_timer, of course).

Paul,
	Thanks for the feedback on the patches.

Avoiding contention on xtime_lock doesnt seem to be trivial. Any
solution to it is fraught with races. Anyway, I have attempted one
solution (in the followon Patch 2/2) which keeps the overhead in timer 
interrupt handler low. 

Let me know if you have other suggestions to avoid xtime_lock
contention!

Following patches are sent in separate mails:

Patch 1/2	-	Core patch to skip ticks - v2
Patch 2/2	- 	Allow boot CPU to skip ticks - v2

The sysctl control patch and decrementer statistics patch are as before
and hence I am not resending them this time.


-- 
Regards,
vatsa
