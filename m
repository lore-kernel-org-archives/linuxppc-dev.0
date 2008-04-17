Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 3BB07DE33E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:52:38 +1000 (EST)
Date: Thu, 17 Apr 2008 16:52:35 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080417125235.GA32480@polina.dev.rtsoft.ru>
References: <20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<20080416184442.GA12179@ld0162-tx32.am.freescale.net>
	<20080416210042.GA3579@zarina>
	<20080416215821.GA15566@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080416215821.GA15566@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 04:58:21PM -0500, Scott Wood wrote:
> On Thu, Apr 17, 2008 at 01:00:42AM +0400, Anton Vorontsov wrote:
> > On Wed, Apr 16, 2008 at 01:44:42PM -0500, Scott Wood wrote:
> > > A maximal timeout of ~65 ms is a little low...  For use as a wakeup from
> > > sleep mode, I'd like to be able to request timeouts as large as the
> > > hardware allows.
> > 
> > That is about precision. You just need to implement gtm_reset_stimer()
> > is you want precision with a seconds, this will run a timer at 1 Hz.
> 
> Enh.  I'm not crazy about having to call separately named functions,
> rather than have the timer code set the reference clock to the highest
> precision that has the needed range.

Heh. Scott, think about it. You have single 16bit timer with variable
frequency. To use it, you'd better know what exactly precision you need.
Then you limited to u16 for the interval for this chosen precision.

Yes, you can implement this:

#define MAX_PRESCALER (256 * 256 * 16)

int gtm_reset_weird_behaving_utimer16(struct gtm_timer *tmr,
				      unsigned long long usec,
				      bool free_run)
{
	int freq = 1000000;
	int min_hz2 = (tmr->gtm->freq / MAX_PRESCALER) << 1;

	while (!(freq & 1) && !(usec & 1) && freq >= min_hz2) {
		freq >>= 1;
		usec >>= 1;
	}

	if (usec > 0xffff)
		return -EINVAL;

	return gtm_reset_ref_timer16(tmr, freq, (u16)usec, free_run);
}

This function (depending on clock-frequency) will work for 1001 usecs,
but will return -EINVAL for 1000001 usecs, thought it will work for
1000000 usecs, and for 333000000 it will work too, but will again
return -EINVAL for 333000010 usecs. I hope this pattern is obvious.
This is really weird behaving, isn't it?

Oh, and later you can drop the 16 suffix and implement the dynamically
chosen cascading, depending if usec argument fits into single/double/quad
timer.

Though, I don't need all this stuff in the FHCI irq handlers, I do know
the precision I want. Like the most of kernel code does.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
