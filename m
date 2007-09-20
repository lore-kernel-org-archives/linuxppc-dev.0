Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id EE8ABDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 11:39:01 +1000 (EST)
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
From: Daniel Walker <dwalker@mvista.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
References: <20070919064947.4B5A1399910@thor>
	<1190216594.11899.3.camel@imap.mvista.com>
	<18161.50240.599267.768383@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 18:35:51 -0700
Message-Id: <1190252151.11899.66.camel@imap.mvista.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	johnstul@us.ibm.com, Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-09-20 at 10:52 +1000, Paul Mackerras wrote:
> Daniel Walker writes:
> 
> > If you switch to the rtc do the shift and mult need to change?
> 
> You can't switch; any given CPU chip will have either the RTC or the
> timebase but not both.

The code is switching between to clock read functions .. If they are
running at different frequencies then the time isn't going to be
converted to nanosecond properly.

So is the rtc running at the same frequency as the timebase? I'd guess
no..

> > > +       /* XXX this assumes clock->shift == 22 */
> > > +       /* 4611686018 ~= 2^(20+64-22) / 1e9 */
> > > +       t2x = (u64) clock->mult * 4611686018ULL;
> > 
> > It might make the code more readable if you put that constant into a
> > macro that gives it a name.
> 
> The comment already gives more information than some arbitrary name
> would.

I'm not a powerpc expect, but I have no idea what that constant is..

Daniel
