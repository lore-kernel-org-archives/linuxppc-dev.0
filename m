Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 1DB69B7B60
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 07:11:37 +1100 (EST)
Received: by yxe8 with SMTP id 8so1439658yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 12:11:36 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1980629.1257928058732.JavaMail.ngmail@webmail19.ha2.local>
References: <1980629.1257928058732.JavaMail.ngmail@webmail19.ha2.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 13:11:15 -0700
Message-ID: <fa686aa40911111211m41197cddl451165bebed6edd8@mail.gmail.com>
Subject: Re: [PATCH 2/3] mpc52xx/wdt: merge WDT code into the GPT
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 1:27 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Hi Grant:
>
> Thanks a lot for your comments!
>
>> On Tue, Nov 10, 2009 at 12:41 PM, Albrecht Dre=DF <albrecht.dress@arcor.=
de>
>> > +#if defined(HAVE_MPC5200_WDT)
>> > + =A0 =A0 =A0 /* check if this device could be a watchdog */
>> > + =A0 =A0 =A0 if (of_get_property(ofdev->node, "fsl,has-wdt", NULL) ||
>> > + =A0 =A0 =A0 =A0 =A0 of_get_property(ofdev->node, "has-wdt", NULL)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *on_boot_wdt;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpt->wdt_mode =3D MPC52xx_GPT_CAN_WDT;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if the device shall be used as =
on-boot watchdog
>> */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 on_boot_wdt =3D of_get_property(ofdev->n=
ode, "wdt,on-boot",
>> NULL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (on_boot_wdt) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpt->wdt_mode |=3D MPC52=
xx_GPT_IS_WDT;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*on_boot_wdt > 0 &&
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_gpt_wdt_=
start(gpt, *on_boot_wdt) =3D=3D
>> 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info=
(gpt->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0"running as wdt, timeout %us\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*on_boot_wdt);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info=
(gpt->dev, "reserved as wdt\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(gpt->dev, "can =
function as wdt\n");
>> > + =A0 =A0 =A0 }
>> > +#endif
>>
>> Ditto on the #if/endif
>
> I don't think it can be removed here. =A0Think about the following:
> - user has a dtb with fsl,has-wdt and fsl,wdt-on-boot properties and
> - disables 5200 WDT in the kernel config.
>
> Now the system refuses to use GPT0 as GPT, although the WDT functionality=
 has been disabled. =A0Of course, the dts doesn't fit the kernel config now=
, but I think we should catch this case.

I think the behaviour should be consistent regardless of what support
is compiled into the kernel.  If the wdt-on-boot property is set, the
it does make sense for the kernel to never use it as a GPT.  Otherwise
the kernel behaviour becomes subtly different in ways non-obvious to
the user.

> Actually I tried to implement your requirements from <http://lists.ozlabs=
.org/pipermail/linuxppc-dev/2009-August/074595.html>:
> - fsl,has-wdt indicates that the GPT can serve as WDT;
> - any access through the wdt api to a wdt-capable gpt actually reserves i=
t as wdt;
> - the new of property forces reserving the wdt before any gpt api functio=
n has chance to grab it as gpt.
>
> Or did I get something wrong here?

No, you got it right...  Well, I can't even remember what I said
yesterday, but this list of requirements looks sane.  :-)

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
