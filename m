Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BB92ADF26B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:07:58 +1000 (EST)
Date: Thu, 17 Apr 2008 19:07:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080417150755.GA29239@polina.dev.rtsoft.ru>
References: <20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<20080416184442.GA12179@ld0162-tx32.am.freescale.net>
	<20080416210042.GA3579@zarina>
	<20080416215821.GA15566@ld0162-tx32.am.freescale.net>
	<20080417125235.GA32480@polina.dev.rtsoft.ru>
	<20080417141903.GB21793@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080417141903.GB21793@ld0162-tx32.am.freescale.net>
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

On Thu, Apr 17, 2008 at 09:19:03AM -0500, Scott Wood wrote:
> On Thu, Apr 17, 2008 at 04:52:35PM +0400, Anton Vorontsov wrote:
> > Heh. Scott, think about it. You have single 16bit timer with variable
> > frequency. To use it, you'd better know what exactly precision you need.
> 
> Why?  I know the timeout I need.
> 
> > Then you limited to u16 for the interval for this chosen precision.
> > 
> > Yes, you can implement this:
> > 
> > #define MAX_PRESCALER (256 * 256 * 16)
> > 
> > int gtm_reset_weird_behaving_utimer16(struct gtm_timer *tmr,
> > 				      unsigned long long usec,
> > 				      bool free_run)
> > {
> > 	int freq = 1000000;
> > 	int min_hz2 = (tmr->gtm->freq / MAX_PRESCALER) << 1;
> > 
> > 	while (!(freq & 1) && !(usec & 1) && freq >= min_hz2) {
> > 		freq >>= 1;
> > 		usec >>= 1;
> > 	}
> > 
> > 	if (usec > 0xffff)
> > 		return -EINVAL;
> > 
> > 	return gtm_reset_ref_timer16(tmr, freq, (u16)usec, free_run);
> > }
> 
> Try something like this:
> 
> int gtm_reset_sane_behaving_timer(struct gtm_timer *tmr,
>                                   u64 usec, bool free_run)
> {
> 	int freq = 1000000;
> 	int min_hz2 = (tmr->gtm->freq / MAX_PRESCALER) << 1;
> 
> 	while (usec > 0xffff && freq >= min_hz2) {

This isn't a timer with usec precision! This is a timer that silently
crops precision as it wants to. Ahh, I see you dropped "u" prefix.

Well. I'm not going to use it anyway, so just give it some name you
prefer and I'll wrap it into the patch. Preferably, drop a line here with
kerneldoc for it, so I'll not have to document its drawbacks. :-)

> 		freq >>= 1;
> 		usec >>= 1;
> 	}
> 
> 	if (usec > 0xffff)
> 		return -EINVAL;
> 
> 	return gtm_reset_ref_timer16(tmr, freq, usec, free_run);
> }
> 
> It could be made faster using cntlzw.

No need to cntlzw, there is fls() already. Though, here you'll need
two because of u64.

Btw, I hope you aware that single GTM timer running at 166MHz will give you
6 minutes of sleep, maximum. With cascaded timer you'll get much better
result of 310 days. Is that possible to use cascaded timer as a wakeup
event on 8313? If so, I'd suggest you to implement cascading firstly.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
