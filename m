Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96307DDEFB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 06:56:18 +1100 (EST)
Message-ID: <47E01E22.9000807@freescale.com>
Date: Tue, 18 Mar 2008 14:55:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
In-Reply-To: <20080318192152.GA26493@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>>> +arch_initcall(qe_init_gtm);
>> If this happens before the gtm_init_gtm(),
> 
> "If" isn't possible, order is guaranteed.

You use arch_initcall for both, so you're relying on link order.  I 
think this at least merits a comment.

>> then np->data will not be set. 
> 
> It's a bug in the device tree or in the Linux code then.

Hmm?  It's set by gtm_init_gtm().  If this code runs before 
gtm_init_gtm(), what are you expecting to initialize np->data?

>> If this happens after gtm_init_gtm(), then gtm_init_gtm() will fail in
>> gtm_get_clock(), if there's no clock-frequency -- and if there is, then why
>> do we need qe_init_gtm() at all?
> 
> Because for the QE clock-frequency != brg-frequency.

Sorry, I missed that you were getting clock-frequency from the parent, 
rather than the gtm node.  If you do the latter, then you can just stick 
the relevant frequency in the gtm node and not worry about where it 
comes from.  This would be analogous to how UART clocks are specified.

Also, what if some arch_initcall runs between gtm_init_gtm and 
qe_init_gtm, that registers itself as a client of the gtm driver, and 
uses the wrong clock value?

>>> +extern struct gtm_timer *gtm_get_timer(int width);
>> To support using the GTM as a wakeup from deep sleep on 831x (which I've had
>> a patch pending for quite a while now), we'll need some way of reserving a
>> specific timer (only GTM1, timer 4 is supported).
> 
> You can add reserve function either in the PM driver (if any), or

What I meant was that there needs to be some way of telling this driver 
not to hand the reserved timer out to some other client.

> you can do something in the device tree (wakeup-timer = <..>). I don't
> see any problems if you want to implement it.

How about simply having optional arguments to gtm_get_timer() to specify 
the GTM device and timer number, which will fail if it's already in use? 
  Then, the PM driver simply needs to run early enough to grab the timer 
it needs.

-Scott
