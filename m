Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com
	[209.85.211.198]) by ozlabs.org (Postfix) with ESMTP id D693BB7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 05:33:44 +1100 (EST)
Received: by ywh36 with SMTP id 36so67836ywh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 11:33:43 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1dc0d81f3202c61cbd1bb1508cb3a2ed04dc036a.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<1dc0d81f3202c61cbd1bb1508cb3a2ed04dc036a.1255499081.git.michael@ellerman.id.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 12:33:23 -0600
Message-ID: <fa686aa40910141133m29117b3cm6047d666c66a5d71@mail.gmail.com>
Subject: Re: [PATCH 2/6] powerpc/pseries: Use irq_has_action() in
	eeh_disable_irq()
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2009 at 11:44 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> Rather than open-coding our own check, use irq_has_action()
> to check if an irq has an action - ie. is "in use".
>
> irq_has_action() doesn't take the descriptor lock, but it
> shouldn't matter - we're just using it as an indicator
> that the irq is in use. disable_irq_nosync() will take
> the descriptor lock before doing anything also.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Looks good to me
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/platforms/pseries/eeh_driver.c | =A0 18 +----------------=
-
> =A01 files changed, 1 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/p=
latforms/pseries/eeh_driver.c
> index 0e8db67..ef8e454 100644
> --- a/arch/powerpc/platforms/pseries/eeh_driver.c
> +++ b/arch/powerpc/platforms/pseries/eeh_driver.c
> @@ -63,22 +63,6 @@ static void print_device_node_tree(struct pci_dn *pdn,=
 int dent)
> =A0}
> =A0#endif
>
> -/**
> - * irq_in_use - return true if this irq is being used
> - */
> -static int irq_in_use(unsigned int irq)
> -{
> - =A0 =A0 =A0 int rc =3D 0;
> - =A0 =A0 =A0 unsigned long flags;
> - =A0 struct irq_desc *desc =3D irq_desc + irq;
> -
> - =A0 =A0 =A0 spin_lock_irqsave(&desc->lock, flags);
> - =A0 =A0 =A0 if (desc->action)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D 1;
> - =A0 =A0 =A0 spin_unlock_irqrestore(&desc->lock, flags);
> - =A0 =A0 =A0 return rc;
> -}
> -
> =A0/**
> =A0* eeh_disable_irq - disable interrupt for the recovering device
> =A0*/
> @@ -93,7 +77,7 @@ static void eeh_disable_irq(struct pci_dev *dev)
> =A0 =A0 =A0 =A0if (dev->msi_enabled || dev->msix_enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 if (!irq_in_use(dev->irq))
> + =A0 =A0 =A0 if (!irq_has_action(dev->irq))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0PCI_DN(dn)->eeh_mode |=3D EEH_MODE_IRQ_DISABLED;
> --
> 1.6.2.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
