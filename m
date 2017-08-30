Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjLP345FLzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 08:52:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gregory Fong <gregory.0xf0@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mpic IRQ_TYPE_BOTH handling
In-Reply-To: <CADtm3G6VVthsOX7d_LHNtFdCvw+oiku=ATL8J-cBHBpLTVrpyg@mail.gmail.com>
References: <CADtm3G6VVthsOX7d_LHNtFdCvw+oiku=ATL8J-cBHBpLTVrpyg@mail.gmail.com>
Date: Thu, 31 Aug 2017 08:52:21 +1000
Message-ID: <87efrs8y8q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gregory,

Gregory Fong <gregory.0xf0@gmail.com> writes:
> Hi all,
>
> In arch/powerpc/sysdev/mpic.c , it looks like IRQ_TYPE_EDGE_BOTH is
> handled the same way as IRQ_TYPE_EDGE_FALLING:
>
> static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
> {
>         /* Now convert sense value */
>         switch(type & IRQ_TYPE_SENSE_MASK) {
>         case IRQ_TYPE_EDGE_RISING:
>                 return MPIC_INFO(VECPRI_SENSE_EDGE) |
>                        MPIC_INFO(VECPRI_POLARITY_POSITIVE);
>         case IRQ_TYPE_EDGE_FALLING:
>         case IRQ_TYPE_EDGE_BOTH:
>                 return MPIC_INFO(VECPRI_SENSE_EDGE) |
>                        MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
>         case IRQ_TYPE_LEVEL_HIGH:
>                 return MPIC_INFO(VECPRI_SENSE_LEVEL) |
>                        MPIC_INFO(VECPRI_POLARITY_POSITIVE);
>         case IRQ_TYPE_LEVEL_LOW:
>         default:
>                 return MPIC_INFO(VECPRI_SENSE_LEVEL) |
>                        MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
>         }
> }
>
> If IRQ_TYPE_EDGE_BOTH is unsupported, shouldn't we be returning an
> error, instead of silently setting to use IRQ_TYPE_EDGE_FALLING?
> Something like the following (sorry if the diff wraps weirdly, on
> webmail at the moment):

I don't know this code so I asked Ben and he said something like
"PowerMacs never use BOTH, so it hasn't mattered, but Freescale machines
might".

So if you want to send a proper signed-off patch, and confirm that all
the callers can handle the error properly, then we can merge it.

cheers

> ----8<----
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index b9aac95..5867ea2 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -876,6 +876,9 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
> int flow_type)
>         if (src >= mpic->num_sources)
>                 return -EINVAL;
>
> +       if (flow_type & IRQ_TYPE_SENSE_MASK == IRQ_TYPE_EDGE_BOTH)
> +               return -EINVAL;
> +
>         vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
>
>         /* We don't support "none" type */
> ---->8----
>
> Thanks,
> Gregory
