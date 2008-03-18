Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15FFADDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 07:48:11 +1100 (EST)
Message-ID: <47E02A8C.2080705@freescale.com>
Date: Tue, 18 Mar 2008 15:48:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
In-Reply-To: <20080318202717.GA1030@localhost.localdomain>
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
> On Tue, Mar 18, 2008 at 02:55:14PM -0500, Scott Wood wrote:
>> Anton Vorontsov wrote:
>>>>> +arch_initcall(qe_init_gtm);
>>>> If this happens before the gtm_init_gtm(),
>>> "If" isn't possible, order is guaranteed.
>> You use arch_initcall for both, so you're relying on link order.  I 
>> think this at least merits a comment.
>>>> then np->data will not be set. 
>>> It's a bug in the device tree or in the Linux code then.
>> Hmm?  It's set by gtm_init_gtm().  If this code runs before 
>> gtm_init_gtm(), what are you expecting to initialize np->data?
> 
> What code exactly?

Sorry, "this code" == qe_init_gtm().  Obviously, if you assume that 
gtm_init_gtm() will always be linked earlier, then it's not an issue.

>> Also, what if some arch_initcall runs between gtm_init_gtm and 
>> qe_init_gtm, that registers itself as a client of the gtm driver, and 
>> uses the wrong clock value?
> 
> Again, what code exactly?   If it is a driver (for what this API is
> created for), it hardly will run earlier than arch/ code.   If this is
> platform code (arch/powerpc/platform/), then it is hardly will run
> earlier than arch/sysdev/. Inside the arch/sysdev/ fsl_gtm.c is
> guaranteed to run earlier than qe_lib/gtm.c. So, where is the problem?

That's a lot of implicit, undocumented dependency on link order... 
Things can be moved around, and driver-ish code can pop up in surprising 
places.  All I meant was that having the gtm driver present itself as 
ready when it isn't, in a way which isn't readily apparent if it 
happens, is worrysome.

> Since I'll implement clock-frequency inside the timer node, this
> isn't relevant anymore...

OK, good.

> Ah. You need specific timer. No problem. I don't like idea of new arguments
> to the gtm_get_timer() function (complicates things), but we can just
> implement another one. gtm_get_timer_<name>, choice the name please.
> _specific, _2, _for, __gtm_get_timer, ...

How about:

struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int timer,
                                          int width);

...with np->data used by the caller to figure out which gtm pointer to 
pass in.

-Scott
