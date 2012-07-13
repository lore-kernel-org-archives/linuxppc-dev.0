Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7EA412C0373
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 22:52:33 +1000 (EST)
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
Date: Fri, 13 Jul 2012 07:52:32 -0500
Message-Id: <0A1104B7-C621-4AE7-A340-EB2921A18CB4@kernel.crashing.org>
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
 <CA+5PVA6RG1m8c2OUL2g0gBK7dRCrmeu47rZfoqAjxODm1zcNRg@mail.gmail.com>
To: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jiang Lu <lu.jiang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 13, 2012, at 7:25 AM, Josh Boyer wrote:

> On Fri, Jul 13, 2012 at 7:50 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> On Jul 12, 2012, at 9:44 PM, Jiang Lu wrote:
>>=20
>>> On PPC44x core, the WRC(Watchdog-timer Reset Control) field of TCR
>>> of timer can not reset by software after set to a non-zero value.
>>> Which means software can not reset the timeout behaviour of watchdog =
timer.
>>>=20
>>> This patch selects WATCHDOG_NOWAYOUT option for 44x platforms to
>>> indicate the watchdog timer can not be disabled once fired.
>>>=20
>>> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
>>> ---
>>> drivers/watchdog/Kconfig |    1 +
>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>=20
>> I believe this is not 44x specific, but how Book-E watchdog is =
architected.
>=20
> That is my understanding as well.
>=20
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 3709624..41f3dff 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1084,6 +1084,7 @@ config PIKA_WDT
>>> config BOOKE_WDT
>>>      tristate "PowerPC Book-E Watchdog Timer"
>>>      depends on BOOKE || 4xx
>>> +     select WATCHDOG_NOWAYOUT if 44x
>>=20
>> This should probably be 'select WATCHDOG_NOWAYOUT if BOOKE'
>=20
> I kind of disagree with this change.  It's a user selectable option =
for
> a reason.
>=20
> Right now, if the option is not set we call booke_wdt_disable which
> indeed does not actually _disable_ the WDT, but it does set the timer
> period to the maxium value.  We could go one step further and =
implement
> a simple timer that pops and calls booke_wdt_ping if WATCHDOG_NOWAYOUT
> is not set, then rearms itself.  That would leave the user with the
> ability to perform recovery of the userspace process that exited or
> died and was responsible for pinging the watchdog.
>=20
> josh

My only care was about it being Book-E and not 44x.  Otherwise I'm happy =
to defer to your take on this.

- k
