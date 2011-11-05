Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2A372B6F99
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 11:08:46 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH 6/7] fsl_pmc: Add API to enable device as wakeup event
 source
Date: Sat, 5 Nov 2011 00:08:24 +0000
Message-ID: <CAOZdJXXB9zJWqC+kPq7ZDdzePtp8XNBnWcf5UmE8Ye50U-G7Dg@mail.gmail.com>
References: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 4, 2011 at 7:39 AM, Zhao Chenhui <chenhui.zhao@freescale.com> w=
rote:

> + =A0 =A0 =A0 if (!pmc_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "PMC is unavailable\n")=
;

Use pr_warn() and the other pr_xxx functions.

> + =A0 =A0 =A0 pmcdr_mask =3D (u32 *)of_get_property(clk_np, "fsl,pmcdr-ma=
sk", NULL);

The typecast is unnecessary here.

> + =A0 =A0 =A0 /* clear to enable clock in low power mode */
> + =A0 =A0 =A0 if (enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrbits32(&pmc_regs->pmcdr, *pmcdr_mask);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&pmc_regs->pmcdr, *pmcdr_mask);

You need to use be32_to_cpup() when dereferencing a pointer to a
device tree property.

--=20
Timur Tabi
Linux kernel developer at Freescale=
