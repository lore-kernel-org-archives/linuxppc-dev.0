Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCD68B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jun 2011 12:12:29 +1000 (EST)
In-Reply-To: <BANLkTinisHPrEN8Xc_KoqFwxknMooE=H4w@mail.gmail.com>
References: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
	<14e6cd940efae1704f5908757f81f627@kernel.crashing.org>
	<BANLkTikKNqEoQxGA642h14eOUjZ3hGZaQw@mail.gmail.com>
	<BANLkTinisHPrEN8Xc_KoqFwxknMooE=H4w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f3bf96d99dfc13e2ebc07d6ce2282f2e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc,
	460gt: Add 460gt as compatible in the check for 460ex-compatible
	crypto
Date: Fri, 24 Jun 2011 04:14:07 +0200
To: Mike Williams <mikebwilliams@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> - =A0 =A0 =A0 if (of_find_compatible_node(NULL, NULL,=20
>>> "amcc,ppc460ex-crypto")) {
>>> + =A0 =A0 =A0 if (of_find_compatible_node(NULL, NULL,=20
>>> "amcc,ppc460ex-crypto") ||
>>> + =A0 =A0 =A0 =A0 =A0 of_find_compatible_node(NULL, NULL,=20
>>> "amcc,ppc460gt-crypto")) {
>>
>> If the device is actually compatible, the device tree node should=20
>> claim
>> it is, and you do not need this code change.
>
> That was actually my first instinct, however I tried to follow the
> current convention in the glacier and canyonlands DTS files, which is
> to set every device compatible to 460gt or 460ex, depending on the
> processor. Many of the devices are identical between the two, since
> they are variations of the same SoC, so which is the preferred method?
> Follow the device tree convention and add the compatibility check in
> the driver,

That is not the convention.

> or alter the device trees? I'll send another patch if it's
> the latter.

You say

   compatible =3D "amcc,ppc460gt-crypto", "amcc,ppc460ex-crypto";

So, a unique name for the actual device first, followed by the name of
what it is compatible to.  The driver for 460ex-crypto will then work
without any changes, but it can also do some 460gt-specific workarounds
or enhancements; or you could even have a totally separate driver for
the 460gt-crypto (you'll have to arrange for it to be used preferably
then).

You should document this 460gt-crypto binding, btw (a single line in
the 460ex-crypto binding doc will do).


Segher
