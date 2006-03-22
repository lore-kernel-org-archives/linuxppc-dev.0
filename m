Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D908679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Mar 2006 05:14:31 +1100 (EST)
In-Reply-To: <dvs108$8d8$1@sea.gmane.org>
References: <dvs108$8d8$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5C3A5367-69A2-4681-B781-74414C9FCDBA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: reset mpc83xx plaform.
Date: Wed, 22 Mar 2006 12:15:19 -0600
To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 22, 2006, at 11:20 AM, David Updegraff wrote:

> Hi.
>
> I think there's some typo-errs. in arch/powerpc/platforms/83xx/misc.c.
> In my case, these result in board lockup at 'reboot' instead of reset.
>
> By my reading of the PDF, it needs to be patched thusly.

Yeah, this fix should be in what Paul just sent to linus for 2.6.17.   
I guess I could push to get it into 2.6.16.x if desired.

- kumar

> diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/ 
> platforms/83xx/misc.c
> index 0eb3d99..d918d45 100644
> --- a/arch/powerpc/platforms/83xx/misc.c
> +++ b/arch/powerpc/platforms/83xx/misc.c
> @@ -24,6 +24,7 @@ void mpc83xx_restart(char *cmd)
>  #define RST_OFFSET	0x00000900
>  #define RST_PROT_REG	0x00000018
>  #define RST_CTRL_REG	0x0000001c
> +#define RST_ENBL_REG	0x00000020
>  	__be32 __iomem *reg;
>
>  	/* map reset register space */
> @@ -34,8 +35,12 @@ void mpc83xx_restart(char *cmd)
>  	/* enable software reset "RSTE" */
>  	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
>
> +	/* wait for reset to get enabled */
> +	while ((in_be32 (reg + (RST_ENBL_REG >> 2)) & 1) == 0 )
> +		;
> +
>  	/* set software hard reset */
> -	out_be32(reg + (RST_CTRL_REG >> 2), 0x52535445);
> +	out_be32(reg + (RST_CTRL_REG >> 2), 3);
>  	for (;;) ;
>  }
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
