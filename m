Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31E55B6F7F
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2011 23:56:12 +1000 (EST)
Subject: Re: [PATCH] powerpc/time: When starting the decrementer don't zero
	the other bits in TCR
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E5F42CE.1060502@freescale.com>
Date: Thu, 1 Sep 2011 08:56:04 -0500
Message-Id: <E9F5F1BB-305E-4AB5-A82F-C5840D24EEEC@kernel.crashing.org>
References: <1314274795-4966-1-git-send-email-Laurentiu.Tudor@freescale.com>
	<9A0167AA-E19D-4492-8D65-6FA4518ABE98@kernel.crashing.org>
	<4E5F42CE.1060502@freescale.com>
To: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2011, at 3:31 AM, Tudor Laurentiu wrote:

> On 9/1/2011 9:27 AM, Kumar Gala wrote:
>>=20
>> On Aug 25, 2011, at 7:19 AM, Laurentiu Tudor wrote:
>>=20
>>> Clearing the other TCR bits might break code that sets them (e.g. to =
setup
>>> the watchdog or fixed interval timer) before start_cpu_decrementer() =
gets
>>> called.
>>=20
>> Can you be more specific about the case you're concerned about.  I'm =
not sure we want to leave the FIT enabled if it was previously.  =
Watchdog I could possibly see leaving alone.
>=20
> My particular case was this: I was experimenting with having the =
watchdog enabled during the boot process, in case something goes wrong =
before the normal watchdog mechanism kicks in. That didn't work without =
making this modification.
> Then, thinking that having a function start_cpu_decrementer() touching =
the other timers and not only the decrementer as its name implies might =
not be good. So I submitted this patch to the public mailing list to let =
the community decide if it's useful.

So I think renaming the function is fine, and I think not touching the =
watchdog bits is also reasonable.  So if you update the patch along =
those lines I think we can push in.  I do want to make sure that the FIT =
is disabled as we dont expect it.

Probably add a comment about how care needs to be taken if the wathchdog =
is enable be firmware or a previous kernel.

>=20
>>> Signed-off-by: Laurentiu Tudor<Laurentiu.Tudor@freescale.com>
>>> ---
>>> arch/powerpc/kernel/time.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>> index 03b29a6..e8b5cdc 100644
>>> --- a/arch/powerpc/kernel/time.c
>>> +++ b/arch/powerpc/kernel/time.c
>>> @@ -721,7 +721,7 @@ void start_cpu_decrementer(void)
>>> 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
>>>=20
>>> 	/* Enable decrementer interrupt */
>>> -	mtspr(SPRN_TCR, TCR_DIE);
>>> +	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_DIE);
>>> #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
>>> }
>>>=20
>>> --
>>> 1.7.1
>>>=20
>>>=20
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>=20
>>=20
>=20
>=20
