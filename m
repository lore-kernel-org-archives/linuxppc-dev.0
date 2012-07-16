Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1952D2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 00:43:43 +1000 (EST)
Message-ID: <50042891.20406@freescale.com>
Date: Mon, 16 Jul 2012 09:43:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <lu.jiang@windriver.com>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
 <50037762.4000800@windriver.com>
In-Reply-To: <50037762.4000800@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2012 09:07 PM, Lu.Jiang wrote:
> =E4=BA=8E 2012=E5=B9=B407=E6=9C=8813=E6=97=A5 19:50, Kumar Gala =E5=86=99=
=E9=81=93:
>> On Jul 12, 2012, at 9:44 PM, Jiang Lu wrote:
>>
>>> On PPC44x core, the WRC(Watchdog-timer Reset Control) field of TCR
>>> of timer can not reset by software after set to a non-zero value.
>>> Which means software can not reset the timeout behaviour of watchdog
>>> timer.
>>>
>>> This patch selects WATCHDOG_NOWAYOUT option for 44x platforms to
>>> indicate the watchdog timer can not be disabled once fired.
>>>
>>> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
>>> ---
>>> drivers/watchdog/Kconfig |    1 +
>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>> I believe this is not 44x specific, but how Book-E watchdog is
>> architected.
>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 3709624..41f3dff 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1084,6 +1084,7 @@ config PIKA_WDT
>>> config BOOKE_WDT
>>>     tristate "PowerPC Book-E Watchdog Timer"
>>>     depends on BOOKE || 4xx
>>> +    select WATCHDOG_NOWAYOUT if 44x
>> This should probably be 'select WATCHDOG_NOWAYOUT if BOOKE'
>=20
> On ppc44x's processor, if we disabled 'WATCHDOG_NOWAYOUT ' option. The
> driver's release routine will try to disable the watchdog , by clearing
> the WIE & WTDP field in TCR.
> Since the ppc44x's watch dog can not reset by software, such operation
> only set the timeout value(WDTP) to minimum, and cause the system reboo=
t
> immediately.
>=20
> I checked ppc 476, 405 & 450's manual, these document said the
> WRC(Watchdog-timer Reset Control) field of TCR of timer
> can not reset by software after set to a non-zero value. I think all
> ppc44x core should got same limitation.

This is (supposed to be) true on FSL e500 as well.

> While on FSL's platform, we did not met such issue.

You tested this and were able to clear WRC on an e500-based chip?  Which
one?

-Scott
