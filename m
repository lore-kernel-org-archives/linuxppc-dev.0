Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
Date: Thu, 20 Sep 2007 10:52:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
In-Reply-To: <1190216594.11899.3.camel@imap.mvista.com>
References: <20070919064947.4B5A1399910@thor>
	<1190216594.11899.3.camel@imap.mvista.com>
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

Daniel Walker writes:

> If you switch to the rtc do the shift and mult need to change?

You can't switch; any given CPU chip will have either the RTC or the
timebase but not both.

> > +       /* XXX this assumes clock->shift == 22 */
> > +       /* 4611686018 ~= 2^(20+64-22) / 1e9 */
> > +       t2x = (u64) clock->mult * 4611686018ULL;
> 
> It might make the code more readable if you put that constant into a
> macro that gives it a name.

The comment already gives more information than some arbitrary name
would.

Paul.
