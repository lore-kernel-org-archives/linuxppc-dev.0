Return-Path: <MAILER-DAEMON>
Received: from WA2EHSNDR005.bigfish.com (smtp-cpk.frontbridge.com
 [204.231.192.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A938B1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 22:24:18 +1100 (EST)
Date: Mon, 7 Nov 2011 19:24:11 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 6/7] fsl_pmc: Add API to enable device as wakeup event
 source
Message-ID: <20111107112411.GC16470@localhost.localdomain>
References: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXXB9zJWqC+kPq7ZDdzePtp8XNBnWcf5UmE8Ye50U-G7Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <CAOZdJXXB9zJWqC+kPq7ZDdzePtp8XNBnWcf5UmE8Ye50U-G7Dg@mail.gmail.com>
Sender: <zch@localhost.localdomain>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
Reply-To: zch@localhost.localdomain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 04, 2011 at 07:08:24PM -0500, Tabi Timur-B04825 wrote:
> On Fri, Nov 4, 2011 at 7:39 AM, Zhao Chenhui <chenhui.zhao@freescale.co=
m> wrote:
>=20
> > + =A0 =A0 =A0 if (!pmc_regs) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "PMC is unavailable=
\n");
>=20
> Use pr_warn() and the other pr_xxx functions.
>=20
> > + =A0 =A0 =A0 pmcdr_mask =3D (u32 *)of_get_property(clk_np, "fsl,pmcd=
r-mask", NULL);
>=20
> The typecast is unnecessary here.
>=20
> > + =A0 =A0 =A0 /* clear to enable clock in low power mode */
> > + =A0 =A0 =A0 if (enable)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrbits32(&pmc_regs->pmcdr, *pmcdr_mask=
);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&pmc_regs->pmcdr, *pmcdr_mask=
);
>=20
> You need to use be32_to_cpup() when dereferencing a pointer to a
> device tree property.
>=20
> --=20
> Timur Tabi
> Linux kernel developer at Freescale

Thanks. I will fix them all.

-chenhui
