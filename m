Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BB824B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 05:06:21 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 0C27BDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 05:06:19 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id d40so774847and.39
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 12:06:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090702175719.15773.58956.stgit@localhost.localdomain>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
Date: Thu, 2 Jul 2009 15:06:17 -0400
Message-ID: <9e4733910907021206m1b5679eai31fd14afe64ace5b@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: Fix mpc5200-psc-ac97 to ensure the data ready
	bit is cleared
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 2, 2009 at 1:57 PM, Grant Likely<grant.likely@secretlab.ca> wro=
te:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> When doing register reads, it is possible for there to be a stale
> data ready bit set which will cause subsequent reads to return
> prematurely with incorrect data. =A0This patch fixes the issues by
> ensuring stale data is cleared before starting another transaction.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jon Smirl <jonsmirl@gmail.com>

> ---
>
> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
>
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc=
_ac97.c
> index 794a247..9b8503f 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -41,6 +41,10 @@ static unsigned short psc_ac97_read(struct snd_ac97 *a=
c97, unsigned short reg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("timeout on ac97 bus (rdy)\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Force clear the data valid bit */
> + =A0 =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
> +
> =A0 =A0 =A0 =A0/* Send the read */
> =A0 =A0 =A0 =A0out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0=
x7f) << 24));
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
