Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Date: Sat, 8 Apr 2006 09:04:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/4] tickless idle cpu - Allow any CPU to update jiffies
In-Reply-To: <20060407063044.GA22416@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
Cc: sri_vatsa_v@yahoo.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srivatsa Vaddagiri writes:

> Currently, only boot CPU calls do_timer to update jiffies. This prevents
> idle boot CPU from skipping ticks. Patch below, against 2.6.17-rc1-mm1,
> allows jiffies to be updated from any CPU.

We have to be very careful here.  The code that keeps xtime and
gettimeofday in sync relies on xtime being incremented as close as
possible in time to when the timebase passes specific values.  Since
we currently stagger the timer interrupts for the cpus throughout a
jiffy, having cpus other than the boot cpus calling do_timer will
break this and introduce inaccuracies.  There are also implications
for the stolen time accounting on shared-processor LPAR systems.

I think we need to remove the staggering, thus having all cpus take
their timer interrupt at the same time.  That way, any of them can
call do_timer.  However we then have to be much more careful about
possible contention, e.g. on xtime_lock.  Your patch has every cpu
taking xtime_lock for writing rather than just the boot cpu.  I'd like
to see if there is some way to avoid that (while still having just one
cpu call do_timer, of course).

Regards,
Paul.
