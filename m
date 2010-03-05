Return-Path: <tmo@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by ozlabs.org (Postfix) with ESMTP id 0EFCFB7C7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Mar 2010 17:11:50 +1100 (EST)
Message-ID: <20100305070016.174933jueklpo8hs@www.sysgo.com>
Date: Fri, 05 Mar 2010 07:00:16 +0100
From: tmo@sysgo.com
To: "Micha Nelissen" <micha@neli.hopto.org>
Subject: Re: [PATCH 7/7] powerpc/85xx: Fix the RapidIO maintenance access
	functions
References: <20100224153751.GG13661@kaneng01.tundra.com>
	<4B858A1F.7020505@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552A54EA6@CORPEXCH1.na.ads.idt.com>
	<4B86CD7C.6070201@neli.hopto.org>
In-Reply-To: <4B86CD7C.6070201@neli.hopto.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Cc: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	Alexandre Bounine <alexb@tundra.com>,
	linuxppc-dev@lists.ozlabs.org, thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting "Micha Nelissen" <micha@neli.hopto.org>:

> Bounine, Alexandre wrote:
>> Hi Micha,
>>
>> I tested it on my setup - it works.
>> Maybe Thomas may give more details on this change.
>
> Did you (for fun) try once to decrease the maintenance window to =20
> say, 4 kB? Then you really need these "high" bits to work properly.

We have never changed the configuration of the window size in Linux, =20
but we have an test application that uses these 4kb window setting.
With the current window configuration in Linux, I expect problems when =20
someone tries to read a register that is located at offset > 512KB. I =20
have currently no equipment to verify this behaviour.

>
> Or did you try with some register at offset > 4MB? The Tundra's have =20
> registers going up to 0x14000 or so? So don't need 16MB addressing =20
> for that.
We have devices that requires access to registers that are located at =20
offset > 15MB.

>
> Thanks, Micha
>
>
>>> -----Original Message-----
>>> From: Micha Nelissen [mailto:micha@neli.hopto.org]
>>> Sent: Wednesday, February 24, 2010 3:21 PM
>>> To: Alexandre Bounine
>>> Subject: Re: [PATCH 7/7] powerpc/85xx: Fix the RapidIO maintenance
>> access functions
>>> Alexandre Bounine wrote:
>>>> =09out_be32(&priv->maint_atmu_regs->rowtar,
>>>> -=09=09 (destid << 22) | (hopcount << 12) | ((offset & ~0x3) >>
>> 9));
>>>> +=09=09 (destid << 22) | (hopcount << 12) | (offset >> 12));
>>>> +=09out_be32(&priv->maint_atmu_regs->rowtear,  (destid >> 10));
>>> Did this actually work for you? The (offset >> 12) is due to the 4MB
>>> window size right?
>>>
>>> Micha
>>
>
>
