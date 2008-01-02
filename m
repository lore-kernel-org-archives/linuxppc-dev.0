Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id A0205DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 10:37:01 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1078376anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 15:37:00 -0800 (PST)
Message-ID: <fa686aa40801021537h58ed2deehfd85c75871973758@mail.gmail.com>
Date: Wed, 2 Jan 2008 16:37:00 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v4 02/13] [POWERPC] Add 'fsl,
	lpb' bus type for MPC5200 LocalPlus Bus
In-Reply-To: <20071109171149.16289.88635.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
	<20071109171149.16289.88635.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/9/07, Marian Balakowicz <m8@semihalf.com> wrote:
> Define MPC52xx specific device id list, add new
> 'fsl,lpb' compatible id for LocalPlus Bus.

I'll pick this up, but I'm going to drop the .compatible="soc" line.
(I'd like to drop the device_type="soc" line also, but that requires a
bit more thought first).

Cheers,
g.

>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> index 9850685..2df97c5 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -124,11 +124,18 @@ mpc5200_setup_xlb_arbiter(void)
>         iounmap(xlb);
>  }
>
> +static struct of_device_id mpc52xx_ids[] = {
> +       { .type = "soc", },
> +       { .compatible = "soc", },
> +       { .compatible = "fsl,lpb", },
> +       {},
> +};
> +
>  void __init
>  mpc52xx_declare_of_platform_devices(void)
>  {
>         /* Find every child of the SOC node and add it to of_platform */
> -       if (of_platform_bus_probe(NULL, NULL, NULL))
> +       if (of_platform_bus_probe(NULL, mpc52xx_ids, NULL))
>                 printk(KERN_ERR __FILE__ ": "
>                         "Error while probing of_platform bus\n");
>  }
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
