Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 72A09B70CE
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 01:52:09 +1000 (EST)
Received: by vws18 with SMTP id 18so3827090vws.15
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 08:52:07 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<1284764008-19469-2-git-send-email-timur@freescale.com>
	<AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Mon, 20 Sep 2010 10:51:37 -0500
Message-ID: <AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver to
	be compiled as a module
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2010 at 7:37 PM, Josh Boyer <jwboyer@gmail.com> wrote:
>> =A0config BOOKE_WDT
>> - =A0 =A0 =A0 bool "PowerPC Book-E Watchdog Timer"
>> + =A0 =A0 =A0 tristate "PowerPC Book-E Watchdog Timer"
>> =A0 =A0 =A0 =A0depends on BOOKE || 4xx
>> =A0 =A0 =A0 =A0---help---
>> + =A0 =A0 =A0 =A0 Watchdog driver for PowerPC e500 chips, such as the Fr=
eescale
>> + =A0 =A0 =A0 =A0 MPC85xx SOCs.
>> +
>
> Again, used for more than e500. =A0That || 4xx in the depends statement
> right above your addition isn't there for fun :).

Does this mean that this comment which is already in the driver is
wrong?  It alludes that "Book-E" is synonymous with "e500".

/* If the kernel parameter wdt=3D1, the watchdog will be enabled at boot.
 * Also, the wdt_period sets the watchdog timer period timeout.
 * For E500 cpus the wdt_period sets which bit changing from 0->1 will
 * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
 * first time nothing will happen, the second time a watchdog exception wil=
l
 * occur, and the final time the board will reset.
 */

#ifdef	CONFIG_FSL_BOOKE
#define WDT_PERIOD_DEFAULT 38	/* Ex. wdt_period=3D28 bus=3D333Mhz,reset=3D~=
40sec */
#else
#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
#endif				/* for timing information */

--=20
Timur Tabi
Linux kernel developer at Freescale
