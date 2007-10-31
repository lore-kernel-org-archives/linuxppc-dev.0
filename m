Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 0B301DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Nov 2007 06:49:47 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so543946pyi
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 12:49:45 -0700 (PDT)
Message-ID: <8496f91a0710311249p5841d66elc6ae5183df9b043f@mail.gmail.com>
Date: Wed, 31 Oct 2007 22:49:45 +0300
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Theo Gjaltema" <gjalt007@chello.nl>
Subject: Re: Too many spurious interrupts on mpc82xx with linux-2.4.35.5
In-Reply-To: <4728C35B.7000709@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8496f91a0707032251m6fea386cu2405899d2945fd07@mail.gmail.com>
	<4728C35B.7000709@chello.nl>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm glad to hear it! :)

2007/10/31, Theo Gjaltema <gjalt007@chello.nl>:
> Matvejchikov,
>
> I've tried this on 2.4.25 kernel from the denx eldk3.1.1 distribution
> and it works here fine as well.
> Thanks,
>   Theo.
>
> Matvejchikov Ilya schreef:
> > Hi all!
> >
> > If you still have this problem, try this patch. It helps :)
> >
> > Signed-off-by : Matvejchikov Ilya <matvejchikov@gmail.com>
> > ---
> > diff -purN linux-2.4.34.5-vanilla/arch/ppc/kernel/cpm2_pic.c
> > linux-2.4.34.5/arch/ppc/kernel/cpm2_pic.c
> > --- linux-2.4.34.5-vanilla/arch/ppc/kernel/cpm2_pic.c 2007-06-06
> > 23:20:53.000000000 +0400
> > +++ linux-2.4.34.5/arch/ppc/kernel/cpm2_pic.c 2007-06-28
> > 12:17:42.000000000 +0400
> > @@ -79,6 +79,12 @@ static void cpm2_mask_and_ack(unsigned i
> >       ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
> >       simr[word] = ppc_cached_irq_mask[word];
> >       sipnr[word] = 1 << (31 - bit);
> > +
> > +     /*
> > +      * Work around large numbers of spurious IRQs on PowerPC 82xx
> > +      * systems.
> > +      */
> > +     mb();
> >  }
> >
> >  static void cpm2_end_irq(unsigned int irq_nr)
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>
>
