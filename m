Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F2A22C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 09:58:43 +1000 (EST)
Date: Mon, 1 Jul 2013 18:58:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V6] powerpc/MPIC: Add get_version API both for internal
 and external use
To: Jia Hongtao <hongtao.jia@freescale.com>
References: <1372656366-769-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1372656366-769-1-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Mon Jul  1 00:26:06 2013)
Message-ID: <1372723115.8183.99@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2013 12:26:06 AM, Jia Hongtao wrote:
> From: Hongtao Jia <hongtao.jia@freescale.com>
>=20
> MPIC version is useful information for both mpic_alloc() and =20
> mpic_init().
> The patch provide an API to get MPIC version for reusing the code.
> Also, some other IP block may need MPIC version for their own use.
> The API for external use is also provided.
>=20
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> V6:
> * Fix compile error on mpc83xx.

I already applied V5 before realizing that it was this patch that you =20
updated, rather than the MSI patch that depends on it.  There is no =20
compile error until the MSI patch that starts using this (which I =20
haven't yet applied, due to the error).  Could you send a followup =20
patch that just adds the stub?

> +/* Get the version of primary MPIC */
> +#ifdef CONFIG_MPIC
> +extern u32 fsl_mpic_primary_get_version(void);
> +#else
> +static inline u32 fsl_mpic_primary_get_version(void)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif
[snip]
> +static u32 fsl_mpic_get_version(struct mpic *mpic)
> +{
> +	u32 brr1;
> +
> +	if (!(mpic->flags & MPIC_FSL))
> +		return 0;

In one case, calling this without having an FSL MPIC returns -ENOTSUPP, =20
and in another case it returns 0...  Shouldn't it be consistent?

Also returning a negative number as a u32 is not very nice.

-Scott=
