Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3B31DE06A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:19:08 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3HEJ4fY020693
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:19:04 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3HEJ3km010788
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 09:19:03 -0500 (CDT)
Date: Thu, 17 Apr 2008 09:19:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080417141903.GB21793@ld0162-tx32.am.freescale.net>
References: <20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<20080416184442.GA12179@ld0162-tx32.am.freescale.net>
	<20080416210042.GA3579@zarina>
	<20080416215821.GA15566@ld0162-tx32.am.freescale.net>
	<20080417125235.GA32480@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080417125235.GA32480@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 04:52:35PM +0400, Anton Vorontsov wrote:
> Heh. Scott, think about it. You have single 16bit timer with variable
> frequency. To use it, you'd better know what exactly precision you need.

Why?  I know the timeout I need.

> Then you limited to u16 for the interval for this chosen precision.
> 
> Yes, you can implement this:
> 
> #define MAX_PRESCALER (256 * 256 * 16)
> 
> int gtm_reset_weird_behaving_utimer16(struct gtm_timer *tmr,
> 				      unsigned long long usec,
> 				      bool free_run)
> {
> 	int freq = 1000000;
> 	int min_hz2 = (tmr->gtm->freq / MAX_PRESCALER) << 1;
> 
> 	while (!(freq & 1) && !(usec & 1) && freq >= min_hz2) {
> 		freq >>= 1;
> 		usec >>= 1;
> 	}
> 
> 	if (usec > 0xffff)
> 		return -EINVAL;
> 
> 	return gtm_reset_ref_timer16(tmr, freq, (u16)usec, free_run);
> }

Try something like this:

int gtm_reset_sane_behaving_timer(struct gtm_timer *tmr,
                                  u64 usec, bool free_run)
{
	int freq = 1000000;
	int min_hz2 = (tmr->gtm->freq / MAX_PRESCALER) << 1;

	while (usec > 0xffff && freq >= min_hz2) {
		freq >>= 1;
		usec >>= 1;
	}

	if (usec > 0xffff)
		return -EINVAL;

	return gtm_reset_ref_timer16(tmr, freq, usec, free_run);
}

It could be made faster using cntlzw.

-Scott
