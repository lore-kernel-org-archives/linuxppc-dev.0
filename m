Return-Path: <aris@valeta.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA4D267B69
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 21:04:10 +1000 (EST)
Date: Tue, 4 Jul 2006 08:03:54 -0300
From: Aristeu Sergio Rozanski Filho <aris@valeta.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: defer work in backlight key press
Message-ID: <20060704110354.GA30435@cathedrallabs.org>
References: <20060704013923.GG27596@cathedrallabs.org>
	<1152000419.20701.48.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1152000419.20701.48.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +	/* we can receive multiple interrupts here, but the scheduled work
> > +	 * will run only once, with the last value */
> > +	pmac_backlight_key_queued = direction;
> 
> Shouldn't you be doing something like using the whole
> pmac_backlight_key_queued in the workqueue, then setting it to 0 there
> and using += here? That way all keypresses will be adhered to.
today pmac_backlight_key() is called either with 0 (to reduce backlight
level) or 1 (to increase). I found that actually happening two
keystrokes between interrupt being serviced and actually running that
work queue would be so damn small that the extra code wouldn't be worth.
but if you think it's worth for, I can fix it, no problem.

-- 
Aristeu
