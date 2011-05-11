Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8BC4EB6F5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:07:54 +1000 (EST)
Received: by iwc10 with SMTP id 10so899366iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:07:51 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <ddef30cc215715662c6e997f9e82e8d79d1c4582.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<ddef30cc215715662c6e997f9e82e8d79d1c4582.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:07:31 +0200
Message-ID: <BANLkTinm9cL-EDpJvpbQEpFbe5V+w63J1w@mail.gmail.com>
Subject: Re: [PATCH 29/37] powerpc: mpc5121_ads_cpld: remove use of
	NO_IRQ_IGNORE
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
> As NO_IRQ_IGNORE is only used between the static function cpld_pic_get_ir=
q
> and its caller cpld_pic_cascade, and cpld_pic_cascade only uses it to
> suppress calling handle_generic_irq, we can change these uses to NO_IRQ
> and remove the extra tests and pathlength in cpld_pic_cascade.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ---
> =A0arch/powerpc/platforms/512x/mpc5121_ads_cpld.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerp=
c/platforms/512x/mpc5121_ads_cpld.c
> index a8bc0d4..9f09319 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
> @@ -97,7 +97,7 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *sta=
tusp,
> =A0 =A0 =A0 =A0status |=3D (ignore | mask);
>
> =A0 =A0 =A0 =A0if (status =3D=3D 0xff)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ_IGNORE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
>
> =A0 =A0 =A0 =A0cpld_irq =3D ffz(status) + offset;
>
> @@ -109,14 +109,14 @@ cpld_pic_cascade(unsigned int irq, struct irq_desc =
*desc)
> =A0{
> =A0 =A0 =A0 =A0irq =3D cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_st=
atus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&cpld_regs->pci_mask);
> - =A0 =A0 =A0 if (irq !=3D NO_IRQ && irq !=3D NO_IRQ_IGNORE) {
> + =A0 =A0 =A0 if (irq !=3D NO_IRQ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0generic_handle_irq(irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0irq =3D cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_=
status,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&cpld_regs->misc_mask);
> - =A0 =A0 =A0 if (irq !=3D NO_IRQ && irq !=3D NO_IRQ_IGNORE) {
> + =A0 =A0 =A0 if (irq !=3D NO_IRQ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0generic_handle_irq(irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
