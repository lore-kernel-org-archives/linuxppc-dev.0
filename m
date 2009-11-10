Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id BAE2BB7BF4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:07:54 +1100 (EST)
Received: by ywh37 with SMTP id 37so483572ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 14:07:52 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257882057.14374.1@antares>
References: <1257882057.14374.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Nov 2009 14:02:58 -0700
Message-ID: <fa686aa40911101302j7c54e1e2re62d1d8f9b83ffd@mail.gmail.com>
Subject: Re: [PATCH 1/3] mpc52xx/wdt: OF property to enable the WDT on boot
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 10, 2009 at 12:40 PM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Add the "wdt,on-boot" OF property as to reserve a GPT as WDT which may be=
 a
> requirement in safety-related (e.g. ISO 61508) applications.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> ---
>
> =A0Documentation/powerpc/dts-bindings/fsl/mpc5200.txt | =A0 15 ++++++++++=
++++-
> =A01 files changed, 14 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt b/Documen=
tation/powerpc/dts-bindings/fsl/mpc5200.txt
> index 8447fd7..1eecb06 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> @@ -103,7 +103,20 @@ fsl,mpc5200-gpt nodes
> =A0---------------------
> =A0On the mpc5200 and 5200b, GPT0 has a watchdog timer function. =A0If th=
e board
> =A0design supports the internal wdt, then the device node for GPT0 should
> -include the empty property 'fsl,has-wdt'.
> +include the empty property 'fsl,has-wdt'. =A0Note that this does not act=
ivate
> +the watchdog. =A0The timer will function as a GPT if the timer api is us=
ed, and
> +it will function as watchdog if the watchdog device is used. =A0The watc=
hdog
> +mode has priority over the gpt mode, i.e. if the watchdog is activated, =
any
> +gpt api call to this timer will fail with -EBUSY.
> +
> +If you add the property
> + =A0 =A0 =A0 wdt,on-boot =3D <n>;
> +GPT0 will be marked as in-use watchdog, i.e. blocking every gpt access t=
o it.
> +If n>0, the watchdog is started with a timeout of n seconds. =A0If n=3D0=
, the
> +configuration of the watchdog is not touched. =A0This is useful in two c=
ases:
> +- just mark GPT0 as watchdog, blocking gpt accesses, and configure it la=
ter;
> +- do not touch a configuration assigned by the boot loader which supervi=
ses
> + =A0the boot process itself.

I'm not *totally* convinced on the usage model, but I just need some
time to think about it.  Give me a day or so and ping me again if you
haven't heard from me.  However, until a common WDT binding is
defined, this property needs to be named something like
"fsl,wdt-on-boot".

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
