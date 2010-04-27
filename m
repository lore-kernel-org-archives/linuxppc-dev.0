Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f185.google.com (mail-pz0-f185.google.com
	[209.85.222.185]) by ozlabs.org (Postfix) with ESMTP id 9B741B7DFB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 05:21:51 +1000 (EST)
Received: by pzk15 with SMTP id 15so8651823pzk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 12:21:51 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272314980-23679-1-git-send-email-timur@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 13:21:30 -0600
Message-ID: <j2qfa686aa41004271221g18f04fbcla8b74861f87b8c84@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for ALSA SoC
	drivers
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 26, 2010 at 2:49 PM, Timur Tabi <timur@freescale.com> wrote:
> An upcoming change in the architecture of ALSA SoC (ASoC) will require th=
e
> MPC8610 HPCD's ASoC fabric driver to register as a standard platform driv=
er.
> Therefore, we need to call platform_device_register_simple() from the boa=
rd's
> platform code.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Kumar, the ASoC mainters are willing to pick up this patch, but they want=
 an
> ACK from you first. =A0Or, you could pick it up, since by itself it's har=
mless.
>
> =A0arch/powerpc/platforms/86xx/mpc8610_hpcd.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/pl=
atforms/86xx/mpc8610_hpcd.c
> index 5abe137..66afff3 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -98,6 +98,9 @@ static int __init mpc8610_declare_of_platform_devices(v=
oid)
> =A0 =A0 =A0 =A0/* Without this call, the SSI device driver won't get prob=
ed. */
> =A0 =A0 =A0 =A0of_platform_bus_probe(NULL, mpc8610_ids, NULL);
>
> + =A0 =A0 =A0 /* Register the platform device for the ASoC fabric driver =
*/
> + =A0 =A0 =A0 platform_device_register_simple("snd-soc-mpc8610-hpcd", 0, =
NULL, 0);
> +

Since this is a temporary measure, this device registration is
probably best put into the .probe() hook of the i2s driver.  That will
keep everything contained in the same place until we can hammer out a
reasonable binding.

g.
