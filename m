Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 00AAADDDE0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 11:15:07 +1100 (EST)
Date: Thu, 27 Nov 2008 18:14:33 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH] powerpc/pseries: Fix cpu hotplug
Message-ID: <20081128001433.GI6830@localdomain>
References: <20081127115952.1f7db89d@bull.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081127115952.1f7db89d@bull.net>
Cc: Dion <jean-pierre.dion@bull.net>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Paul Mackerras <paulus@samba.org>, Jean
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, I have some questions about this patch.

Sebastien Dugue wrote:
> 
>   Currently, pseries_cpu_die() calls msleep() while polling RTAS for
> the status of the dying cpu.
> 
>   However if the cpu that is going down also happens to be the one doing
> the tick then we're hosed as the tick_do_timer_cpu 'baton' is only passed
> later on in tick_shutdown() when _cpu_down() does the CPU_DEAD notification.
> Therefore jiffies won't be updated anymore.

I confess unfamiliarity with the tick/timer code, but this sounds like
something that should be addressed earlier in the process of taking
down a CPU.


>   This patch replaces that msleep() with a cpu_relax() to make sure we're
> not going to schedule at that point.

This is a significant change in behavior.  With the msleep(), we poll
for at least five seconds before giving up; with the cpu_relax(), the
period will almost certainly be much shorter and we're likely to give
up too soon in some circumstances.  Could be addressed by using
mdelay(), but...

It's just not clear to me how busy-waiting in the __cpu_die() path is
a legitimate fix.  Is sleeping in this path forbidden now?  (I notice
at least native_cpu_die() in x86 does msleep(), btw.)

As it can take several milliseconds for RTAS to report a CPU
offline, and the maximum latency of the operation is unspecified, it
seems inappropriate to tie up the waiting CPU this way.


>   With this patch my test box survives a 100k iterations hotplug stress
> test on _all_ cpus, whereas without it, it quickly dies after ~50 iterations.

What is the failure (e.g. stack trace, kernel messages)?
