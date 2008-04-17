Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 858B9DF7C1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:13:36 +1000 (EST)
Message-ID: <48077748.1040001@freescale.com>
Date: Thu, 17 Apr 2008 11:14:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
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
	<20080417150755.GA29239@polina.dev.rtsoft.ru>
In-Reply-To: <20080417150755.GA29239@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> This isn't a timer with usec precision! This is a timer that silently
> crops precision as it wants to. Ahh, I see you dropped "u" prefix.

It is a timer with usec precision, unless you ask for a timeout of more 
than 65535 usec -- at which point the hardware can't provide usec precision.

And s/as it wants to/as it needs to/.

> Well. I'm not going to use it anyway, so just give it some name you
> prefer and I'll wrap it into the patch. Preferably, drop a line here with
> kerneldoc for it, so I'll not have to document its drawbacks. :-)

/**
  * gtm_reset_timer16 - reset 16 bit timer with arbitrary precision
  * @tmr: pointer to the gtm_timer structure obtained from gtm_get_timer
  * @usec: timer interval in microseconds
  * @reload: if set, the timer will reset upon expiry rather than
  * continue running free.
  *
  * This function (re)sets the GTM timer so that it counts up to the
  * requested interval value, and fires the interrupt when the value is
  * reached.  This function will reduce the precision of the timer as
  * needed in order for the requested timeout to fit in a 16-bit
  * register.
  */
int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec,
                       bool reload)
{
	...
}

>> It could be made faster using cntlzw.
> 
> No need to cntlzw, there is fls() already.

fls() uses cntlzw, does it not?  I was just too lazy to look up what 
Linux calls it. :-)

> Though, here you'll need two because of u64.

We can probably get away with 32 bits.

> Btw, I hope you aware that single GTM timer running at 166MHz will give you
> 6 minutes of sleep, maximum.

Yes, but it's all we have on-chip that can do the job.

> With cascaded timer you'll get much better
> result of 310 days. Is that possible to use cascaded timer as a wakeup
> event on 8313? 

No, unfortunately.  Only timer4 can be a wakeup source, and when 
cascaded, timer4 is the input to timer3, rather than the other way around.

-Scott
