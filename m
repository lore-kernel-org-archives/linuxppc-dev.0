Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74671B70CD
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 05:30:26 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8KJFWaG026762
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 15:15:32 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8KJUNfm399554
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 15:30:23 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8KJULei025837
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 13:30:22 -0600
Date: Mon, 20 Sep 2010 15:30:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver to
	be compiled as a module
Message-ID: <20100920193016.GA3845@zod.rchland.ibm.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<1284764008-19469-2-git-send-email-timur@freescale.com>
	<AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
	<AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 20, 2010 at 10:51:37AM -0500, Timur Tabi wrote:
>On Fri, Sep 17, 2010 at 7:37 PM, Josh Boyer <jwboyer@gmail.com> wrote:
>>>  config BOOKE_WDT
>>> -       bool "PowerPC Book-E Watchdog Timer"
>>> +       tristate "PowerPC Book-E Watchdog Timer"
>>>        depends on BOOKE || 4xx
>>>        ---help---
>>> +         Watchdog driver for PowerPC e500 chips, such as the Freescale
>>> +         MPC85xx SOCs.
>>> +
>>
>> Again, used for more than e500.  That || 4xx in the depends statement
>> right above your addition isn't there for fun :).
>
>Does this mean that this comment which is already in the driver is
>wrong?  It alludes that "Book-E" is synonymous with "e500".
>
>/* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
> * Also, the wdt_period sets the watchdog timer period timeout.
> * For E500 cpus the wdt_period sets which bit changing from 0->1 will
> * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
> * first time nothing will happen, the second time a watchdog exception will
> * occur, and the final time the board will reset.
> */

I guess I don't see what you mean.  It talks about e500 but it doesn't
say "Book-E" anywhere in that comment.  (Though I'm pretty sure that
comment does apply to 4xx.)

>
>#ifdef	CONFIG_FSL_BOOKE
>#define WDT_PERIOD_DEFAULT 38	/* Ex. wdt_period=28 bus=333Mhz,reset=~40sec */
>#else
>#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
>#endif				/* for timing information */

And this bit is marked as "FSL_BOOKE" vs. 40x and 44x.

josh
