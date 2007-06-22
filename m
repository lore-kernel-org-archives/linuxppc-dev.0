Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 521B8DDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 16:28:43 +1000 (EST)
Date: Fri, 22 Jun 2007 16:28:42 +1000
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] clocksouce implementation for powerpc
Message-ID: <20070622062842.GY9768@bakeyournoodle.com>
References: <20070616101126.296384219@inhelltoy.tec.linutronix.de>
	<20070616101637.107940593@inhelltoy.tec.linutronix.de>
	<1182009083.11539.369.camel@imap.mvista.com>
	<20070620065710.GR9768@bakeyournoodle.com>
	<1182373561.6559.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1182373561.6559.39.camel@localhost.localdomain>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 02:06:01PM -0700, john stultz wrote:

Hi John.

> Hey Tony,
> 	Thanks for sending this out! I really appreciate this work, as its been
> on my todo forever, and I've just not been able to focus on it.
> Currently it seems a bit minimal of a conversion (ideally there should
> be very little time code left), but It looks like a great start!

Thanks.

> I might be missing a subtlety in the ppc code, but I'm still not sure if
> I see the need for the clocksource settimeofday hook.
> 
> update_vsyscall() is intended to provide a hook that allows the generic
> time code to provide all the needed timekeeping state to the arch
> specific vsyscall implementation. It is called any time the base
> timekeeping variables are changed.

Well as I just said the Daniel, I was under the impression I needed a
hook that was only called from settimeofday().  The comments I've
recieved from everyone has given me good cause to re-evaluate.

I think I can make it work without the hook, that started this
discussion.  Thomas, I think it's probably best to axe it now.  If I
/really/ need it then I'll start the discussion again :)  Thanks.
 
> I think it would be enlightening to flatten this out a bit. Putting both
> the timer_recalc_offset and clocksource_settime code in the same
> function. It might illustrate where some optimizations could be done and
> where it might make more sense to split things up.
> 
> Also I'd leave timer_check_rtc() in the timer_interrupt for now (later
> moving it to tglx's generic rtc update).

Yes you're rigth I don't need to move the timer_check_rtc() call.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
