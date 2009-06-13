Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A9377B71E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 03:09:47 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1244911551.3423.0@antares>
References: <fa686aa40906110927w60a5a74alaa3420b9bf3f3e44@mail.gmail.com>
	<1244911551.3423.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Jun 2009 11:09:24 -0600
Message-ID: <fa686aa40906131009t639112adn46e502631873f3a0@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit Local
	Plus Bus
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 13, 2009 at 10:45 AM, Albrecht Dre=DF<albrecht.dress@arcor.de> =
wrote:
> Am 11.06.09 18:27 schrieb(en) Grant Likely:
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u16 *)buf =3D *((volatile u16 *)(vdest =
- 1));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[1] =3D *((u8 *)src);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((volatile u16 *)(vdest - 1)) =3D *(u16 =
*)buf;
>>
>> what is the purpose of volatile here? =A0If you need io barriers, then u=
se
>> the in_/out_be16 macros.
>
> Yes, you're right - should be completely superfluous here. =A0A result of=
 copy
> & paste without thinking... :-(
>
>> Blech. =A0ugly #ifdef and not really multiplatform safe (yeah, I know it
>> shouldn't break non-5200 platforms, but it does have an undesirable impa=
ct).
>> =A0There's got to be a better way.
>
> Ouch, yes - I completely forgot the possibility of multi-platform builds.
>
> Am 11.06.09 19:28 schrieb(en) Grant Likely:
>>
>> So; the solution to me seems to be on an MPC5200 platform replace the
>> offending hooks with MPC5200 specific variants at runtime.
>
> Will re-work the patch that way! =A0BTW, a dumb question: what is the pro=
per
> way to determine which cpu the system is running on? =A0Check the CPU nod=
e of
> the of tree?

In this case I'd walk up the parent nodes in the tree looking for an
"fsl,mpc5200-lpb" compatible value.  That way you only apply the
workaround if the device is on the locaplus bus, and not for example
below the PCI bus.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
