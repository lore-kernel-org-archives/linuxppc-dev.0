Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88CB6DDFF7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 17:42:40 +1100 (EST)
Subject: Re: [PATCH] ppc: detect sbc610 boards and only fixup nec usb on them
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20090304035930.GD24834@bilbo.ozlabs.org>
References: <20090304012229.GN28503@bombadil.infradead.org>
	<20090304035930.GD24834@bilbo.ozlabs.org>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 17:42:20 +1100
Message-Id: <1236148940.6696.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kyle McMartin <kyle@infradead.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks, I applied Tony's patch and sent a pull request to Linus.

Cheers,
Ben.

On Wed, 2009-03-04 at 14:59 +1100, Tony Breeds wrote:
> On Tue, Mar 03, 2009 at 08:22:29PM -0500, Kyle McMartin wrote:
> > From: Kyle McMartin <kyle@redhat.com>
> > 
> > Bug #486511 in Fedora, this is getting applied to any machine with a NEC
> > USB pci device if this CONFIG_GEF_SBC610 is on (as it was in Fedora.)
> > Obviously this isn't appropriate to do in any more than the SBC610
> > case..., so flag that we're a sbc610 board, and skip the fixup if we're
> > not.
> > 
> > (Fedora: Should fix USB on Mac G4/G5...)
> > 
> > Signed-off-by: Kyle McMartin <kyle@redhat.com>
> > 
> > ---
> > diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
> > index fb371f5..54afda2 100644
> > --- a/arch/powerpc/platforms/86xx/gef_sbc610.c
> > +++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
> > @@ -51,6 +51,8 @@
> >  
> >  void __iomem *sbc610_regs;
> >  
> > +static int is_sbc610;
> 
> I came up with this as well, but used the machine_is() infrasturcture.
> 
> Subject: [PATCH] Run fixup code only on the appropriate platform.
> 
> commit a969e76a7101bf5f3d369563df1ca1253dd6131b (powerpc: Correct USB
> support for GE Fanuc SBC610) introduced a fixup for NEC usb controllers.
> This fixup should only run on GEF SBC610 boards.
> 
> Fixes Fedora bug #486511.
> (https://bugzilla.redhat.com/show_bug.cgi?id=486511)
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  arch/powerpc/platforms/86xx/gef_sbc610.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
> index fb371f5..d6b772b 100644
> --- a/arch/powerpc/platforms/86xx/gef_sbc610.c
> +++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
> @@ -142,6 +142,10 @@ static void __init gef_sbc610_nec_fixup(struct pci_dev *pdev)
>  {
>  	unsigned int val;
>  
> +	/* Do not do the fixup on other platforms! */
> +	if (!machine_is(gef_sbc610))
> +		return;
> +
>  	printk(KERN_INFO "Running NEC uPD720101 Fixup\n");
>  
>  	/* Ensure ports 1, 2, 3, 4 & 5 are enabled */
