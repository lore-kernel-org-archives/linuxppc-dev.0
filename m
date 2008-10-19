Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 347DCDDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 08:32:26 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1375325rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 14:32:24 -0700 (PDT)
Message-ID: <9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
Date: Sun, 19 Oct 2008 17:32:24 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <Pine.LNX.4.64.0810192147030.21665@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
Cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 19, 2008 at 4:59 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> (modified the cc-list somewhat)
>
> On Sat, 18 Oct 2008, Rog=E9rio Brito wrote:
>
>> systems. Here is something that I get with a vanilla linkstation_defconf=
ig:
>>
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>>
>> This gets me (with bootlogd enabled):
>>
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> Wed Dec 31 21:00:15 1969: Cannot access the Hardware Clock via any known=
 method.
>> Wed Dec 31 21:00:15 1969: Use the --debug option to see the details of o=
ur search for an access method.
>> Wed Dec 31 21:00:15 1969: Unable to set System Clock to: Thu Jan 1 00:00=
:15 UTC 1970 ^[[33m(warning).^[[39;49m
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>
> Yes, there seems to be a problem here now. The i2c adapter does not get
> probed, i.e., of-matching doesn't work. A quick look through other
> device-trees, using the same i2c driver, through git-logs of the i2c
> driver and the dts didn't bring me to a solution. Can anyone spot what's
> wrong with kuroboxHG.dts? lsprop output looks reasonable. Last working
> kernel was 2.6.25-rc6-ish.
>
>> I just saw that in the default config:
>>
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> # CONFIG_PPC_CLOCK is not set
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>
> No, kurobox uses generic RTC class.

I don't see anything obviously wrong.

Is rtc-rs5c372 built into your kernel?

You may need to add some debug statements in drivers/of/of_i2c.c to
figure out what is wrong.
It could be something like a _ not matching a -.


>
> Thanks for the report
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
>



--=20
Jon Smirl
jonsmirl@gmail.com
