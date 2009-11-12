Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id A4EFBB7B97
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 06:06:24 +1100 (EST)
Received: by ywh37 with SMTP id 37so2503253ywh.17
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 11:06:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258051427.2280.1@antares>
References: <1258051427.2280.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 12:06:03 -0700
Message-ID: <fa686aa40911121106j1d609868vb16d6867955aa607@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] mpc52xx/wdt: OF property to enable the WDT on boot
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2009 at 11:43 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Add the "fsl,wdt-on-boot" OF property as to reserve a GPT as WDT which ma=
y
> be a requirement in safety-related (e.g. ISO/EN 61508) applications.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
> ---
>
> Change against v1: rename the new property.
>
> =A0Documentation/powerpc/dts-bindings/fsl/mpc5200.txt | =A0 17 ++++++++++=
++++++-
> =A01 files changed, 16 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt b/Documen=
tation/powerpc/dts-bindings/fsl/mpc5200.txt
> index 8447fd7..ddd5ee3 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> @@ -103,7 +103,22 @@ fsl,mpc5200-gpt nodes
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
> + =A0 =A0 =A0 fsl,wdt-on-boot =3D <n>;
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
> +
> +The watchdog will respect the CONFIG_WATCHDOG_NOWAYOUT option.

I think it would be better to use a device tree property to enable up
NOWAYOUT.  The static config isn't multiplatform-friendly.  Thoughts?

Otherwise, this looks good to me.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
