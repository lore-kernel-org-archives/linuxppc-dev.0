Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F896101673
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 05:21:18 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 2/2 v5] powerpc/85xx: Abstract common define of signal
 multiplex control for qe
Date: Fri, 17 Feb 2012 18:21:06 +0000
Message-ID: <CAOZdJXUi9_MNuJytYuaHmi2HUCmRV8ePbWdo2Jp4N4D2L8=ewQ@mail.gmail.com>
References: <1329289091-26231-1-git-send-email-B32736@freescale.com>
 <1329289091-26231-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1329289091-26231-2-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2012 at 12:58 AM, Zhicheng Fan <B32736@freescale.com> wrote=
:

> @@ -114,6 +114,24 @@ struct ccsr_guts_86xx {
> =A0 =A0 =A0 =A0__be32 =A0srds2cr1; =A0 =A0 =A0 /* 0x.0f44 - SerDes2 Contr=
ol Register 0 */
> =A0} __attribute__ ((packed));
>
> +#ifdef CONFIG_PPC_85xx
> +

Remove this #ifdef.  It doesn't really help, and it makes things more
complicated.

> +/* Alternate function signal multiplex control */
> +#define MPC85xx_PMUXCR_QE0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00008000
> +#define MPC85xx_PMUXCR_QE2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00002000
> +#define MPC85xx_PMUXCR_QE3 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00001000
> +#define MPC85xx_PMUXCR_QE4 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000800
> +#define MPC85xx_PMUXCR_QE5 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000400
> +#define MPC85xx_PMUXCR_QE6 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000200
> +#define MPC85xx_PMUXCR_QE7 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000100
> +#define MPC85xx_PMUXCR_QE8 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000080
> +#define MPC85xx_PMUXCR_QE9 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000040
> +#define MPC85xx_PMUXCR_QE10 =A0 =A0 =A0 =A0 =A0 =A0 0x00000020
> +#define MPC85xx_PMUXCR_QE11 =A0 =A0 =A0 =A0 =A0 =A0 0x00000010
> +#define MPC85xx_PMUXCR_QE12 =A0 =A0 =A0 =A0 =A0 =A0 0x00000008

#define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("mpc=
85xx-rdb: could not map global utilties register!\n");

No exclamation marks (!) in kernel messages.

You misspelled "utilities".

--=20
Timur Tabi
Linux kernel developer at Freescale=
