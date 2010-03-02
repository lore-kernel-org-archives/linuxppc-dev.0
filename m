Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f175.google.com (mail-yx0-f175.google.com
	[209.85.210.175]) by ozlabs.org (Postfix) with ESMTP id 0E0C3B7D50
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 07:12:45 +1100 (EST)
Received: by yxe5 with SMTP id 5so380402yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Mar 2010 12:12:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <22132814.1267520208614.JavaMail.ngmail@webmail14.arcor-online.net>
References: <14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
	<20100302082858.GA4087@pengutronix.de>
	<22132814.1267520208614.JavaMail.ngmail@webmail14.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 2 Mar 2010 13:12:24 -0700
Message-ID: <fa686aa41003021212y7ccc9fcalc1578811e8a7c8f8@mail.gmail.com>
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high baud
	rates, better accuracy)
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 2, 2010 at 1:56 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Hi Wolfram:
>
> [snip]
>> > Yes, but I do all /calculations/ with the /4 prescaler for higher
>> accuracy.
>> > If the divisor exceeds the available 16 bits of the counter reg, I rou=
nd
>> > (divisor / 8) to use the /32 prescaler. =A0Think of a 19-bit counter v=
alue,
>> > where I can choose to use either the lower or the higher 16 bits for t=
he
>> > counter reg.
>>
>> Okay, now I got it. (Maybe this is an indication for another comment abo=
ve
>> the
>> set divisor function?)
>
> O.k., I will add that comment...
>

Yes, please document your calculation approach thoroughly.

>> > > This should be handled using a new compatible-entry
>> > > "fsl,mpc5200b-psc-uart".
>> >
>>
>> > I agree that this would be a lot cleaner, but it's also a lot more
>> intrusive.
>> > CC'ing the device tree discussion list here... comments, please!!
>>
>> Why intrusive? Maybe I miss something?
>
> Not for the source file, but for all the dts files, if they want to benef=
it from the detection of the '5200B. =A0Basically, *all* files have to be c=
hecked and touched if necessary. =A0Again, I agree that this would be the c=
lean approach, but I wanted to avoid that effort. =A0Grant???

Already there on mainlined .dts files, and it won't break boards that
don't have it.

> [snip]
>> Leave those two function pointers empty and fill them during probe (prob=
e
>> has
>> access to the compatible-property it was matched against, see its
>> arguments).
>> So it should be a matter of:
>>
>> if (matched_property =3D=3D 5200b)
>> =A0 =A0 =A0 ops->func =3D this_one;
>> else
>> =A0 =A0 =A0 ops->func =3D that_one;
>
> Umm, yes, that's true of course. =A0Will pick it up.

When it comes to code clarity, I'd prefer you had separate mpc5200 and
mpc5200b ops structures.  I'm not worried about an extra 64 bytes
added to the kernel size for this (minus the # of bytes needed to test
and set the new op).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
