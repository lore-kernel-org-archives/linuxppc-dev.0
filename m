Return-Path: <jwboyer@gmail.com>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 852E62C0204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 22:25:26 +1000 (EST)
Received: by qaea16 with SMTP id a16so300639qae.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 05:25:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
Date: Fri, 13 Jul 2012 08:25:21 -0400
Message-ID: <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
From: Josh Boyer <jwboyer@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Jiang Lu <lu.jiang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2012 at 7:50 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jul 12, 2012, at 9:44 PM, Jiang Lu wrote:
>
>> On PPC44x core, the WRC(Watchdog-timer Reset Control) field of TCR
>> of timer can not reset by software after set to a non-zero value.
>> Which means software can not reset the timeout behaviour of watchdog timer.
>>
>> This patch selects WATCHDOG_NOWAYOUT option for 44x platforms to
>> indicate the watchdog timer can not be disabled once fired.
>>
>> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
>> ---
>> drivers/watchdog/Kconfig |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> I believe this is not 44x specific, but how Book-E watchdog is architected.

That is my understanding as well.

>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 3709624..41f3dff 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1084,6 +1084,7 @@ config PIKA_WDT
>> config BOOKE_WDT
>>       tristate "PowerPC Book-E Watchdog Timer"
>>       depends on BOOKE || 4xx
>> +     select WATCHDOG_NOWAYOUT if 44x
>
> This should probably be 'select WATCHDOG_NOWAYOUT if BOOKE'

I kind of disagree with this change.  It's a user selectable option for
a reason.

Right now, if the option is not set we call booke_wdt_disable which
indeed does not actually _disable_ the WDT, but it does set the timer
period to the maxium value.  We could go one step further and implement
a simple timer that pops and calls booke_wdt_ping if WATCHDOG_NOWAYOUT
is not set, then rearms itself.  That would leave the user with the
ability to perform recovery of the userspace process that exited or
died and was responsible for pinging the watchdog.

josh
