Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E995EB6FD6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:08:40 +1000 (EST)
Received: by iwc10 with SMTP id 10so899896iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:08:38 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <e619719d90d94f19b6e2b47c3f36e7873da5bef9.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<e619719d90d94f19b6e2b47c3f36e7873da5bef9.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:08:18 +0200
Message-ID: <BANLkTiksrxw3zBtqSmSrjZeb9U1cCty2HQ@mail.gmail.com>
Subject: Re: [PATCH 30/37] powerpc: mpc62xx_pic: fix get_irq handling of NO_IRQ
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2011 at 7:30 AM, Milton Miller <miltonm@bga.com> wrote:
> If none of irq category bits were set mpc52xx_get_irq() would pass
> NO_IRQ_IGNORE (-1) to irq_linear_revmap, which does an unsigned compare
> and declares the interrupt above the linear map range. =A0It then punts
> to irq_find_mapping, which performs a linear search of all irqs,
> which will likely miss and only then return NO_IRQ.
>
> If no status bit is set, then we should return NO_IRQ directly.
> The interrupt should not be suppressed from spurious counting, in fact
> that is the definition of supurious.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_pic.c | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_pic.c
> index bb61181..1a9a495 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -486,7 +486,7 @@ void __init mpc52xx_init_irq(void)
> =A0unsigned int mpc52xx_get_irq(void)
> =A0{
> =A0 =A0 =A0 =A0u32 status;
> - =A0 =A0 =A0 int irq =3D NO_IRQ_IGNORE;
> + =A0 =A0 =A0 int irq;
>
> =A0 =A0 =A0 =A0status =3D in_be32(&intr->enc_status);
> =A0 =A0 =A0 =A0if (status & 0x00000400) { =A0 =A0 =A0/* critical */
> @@ -509,6 +509,8 @@ unsigned int mpc52xx_get_irq(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq |=3D (MPC52xx_IRQ_L1_P=
ERP << MPC52xx_IRQ_L1_OFFSET);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return irq_linear_revmap(mpc52xx_irqhost, irq);
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
