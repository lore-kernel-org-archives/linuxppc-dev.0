Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id A8018DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun, 31 May 2009 06:22:11 +1000 (EST)
Received: by bwz19 with SMTP id 19so6939193bwz.9
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 13:22:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090529171835.GB22066@b07421-ec1.am.freescale.net>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl> <20090528123311.GA3112@pengutronix.de>
	<1ba63b520905290356l5d519e64w3bd852d8fc4032be@mail.gmail.com>
	<20090529171835.GB22066@b07421-ec1.am.freescale.net>
Date: Sat, 30 May 2009 22:22:08 +0200
Message-ID: <1ba63b520905301322n72fa165ds7e2eb3af4475f109@mail.gmail.com>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27- "no_irq_chip"
	error
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 29, 2009 at 7:18 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> On Fri, May 29, 2009 at 12:56:13PM +0200, Frank Svendsb=F8e wrote:
>> FYI. The same applies to mpc8xx targets: No default host interrupt contr=
oller.
>> The following patch was needed for our target:
>> ---
>> diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8=
xx_pic.c
>> index 5d2d552..92b2b66 100644
>> --- a/arch/powerpc/sysdev/mpc8xx_pic.c
>> +++ b/arch/powerpc/sysdev/mpc8xx_pic.c
>> @@ -186,6 +186,7 @@ int mpc8xx_pic_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0irq_set_default_host(mpc8xx_pic_host);
>> =A0 =A0 =A0 =A0 return 0;
>
> This patch is whitespace mangled.
>
>>
>> =A0out:
>> ---
>> Maybe setting a default host ought to be mandatory? Or is doing the
>> mapping manually
>> (without device tree descriptions) considered being a hack?
>
> I consider it a hack -- not so much doing it manually (though the device
> tree is better), but relying on a default interrupt controller when doing
> so. =A0IRQ numbers only make sense in the context of a specific
> controller. =A0It's especially misleading on 8xx, which has separate
> regular and CPM PICs.
>
> -Scott
>

I agree, and was the reason I mentioned "hack". The patch wasn't meant
for commit,
just for reference (sorry for whitemangling ;-)

Regarding doing manual mapping: Is there another way to retrieve the
host controller
from a driver module without modifying kernel source? In case not, do you t=
hink
exporting the mpc8xx_pic_host symbol is a better solution?

Anyway, now that I'm beginning to understand dts I guess I might as
well just do it properly.

- Frank
