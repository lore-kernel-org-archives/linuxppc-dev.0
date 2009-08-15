Return-Path: <wangbj.ml@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B4AAB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 14:32:37 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 6AF1DDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 14:32:34 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b6so759606ana.39
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 21:32:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090815003904.5378cb35@xilun.lan.proformatique.com>
References: <17dc9c530908140727l6423bebawaed8808f195d4d20@mail.gmail.com>
	<20090815003904.5378cb35@xilun.lan.proformatique.com>
Date: Sat, 15 Aug 2009 12:32:31 +0800
Message-ID: <17dc9c530908142132oab0339di36b5e7bf111badd0@mail.gmail.com>
Subject: Re: Configure CPM2 PORTC pin (PC9) for external interrupt?
From: Baojun Wang <wangbj.ml@gmail.com>
To: Guillaume Knispel <gknispel@proformatique.com>
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

hi, Guillaume

    Thank you very much. the kernel I'm using is linux-2.6.21 (for the
target system), actually I have also read 2.6.30 source code, but I
didn't find the change, and I think the problem was caused by fault
configuration of the PORTC io-port. The commit you mentioned haven't
applied for 2.6.21.

    Next time I will include the exact kernel version (and related)
info, many thanks again.

    Best Regards,
Wang Baojun

On Sat, Aug 15, 2009 at 6:39 AM, Guillaume Knispel
<gknispel@proformatique.com> wrote:
>
> On Fri, 14 Aug 2009 22:27:39 +0800
> Baojun Wang <wangbj.ml@gmail.com> wrote:
>
> > =A0 I need to configure CPM2 PORTC pin (PC9) for external interrupt, wh=
en I
> > read the MPC8555ERM.pdf and cpm2-pic.c, I find that PC9 interrupt numbe=
r is
> > 56, and I request the IRQ in this way:
> >
> > =A0 hw_irq =3D 56;
> > =A0 virq =3D irq_create_mapping(cpm2_host, hw_irq);
> >
> > =A0 reqeust_irq(virq, ...);
> >
> > =A0 I can request the irq successfully, but the interrupt is never gene=
rated
> > (ISR is not called) to the PC9 pins, even though the hardware said an
> > interrupt was raised. (the hardware have a register with a special bit)
> >
> > =A0 Should I configure the cpm2 io port first to allow PORTC interrupt?=
 I have
> > read the cpm2 io port documentation, and I initialize the PC9 as:
> >
> > =A0 PPARC[pc9_bit] =3D 0; =A0 =A0/* for general purpose IO, not dedicat=
ed */
> > =A0 PSORC[pc9_bit] =3D 0; =A0 =A0/* no special option */
> > =A0 PDIRC[pc9_bit] =3D 0; =A0 =A0 /* for both input/output */
> >
> > =A0 Am I missing some thing? Any suggestion will be greatly appreciated=
.
>
> Hi,
>
> Have a look on commit 7f3ea17f316577e31db868f720ac575c74d20163, which
> fixes a linux bug about Port C interrupts
>
> Also note that the 8555 have the same issue that the 8272 about
> PC2 / PC3 missing which shifts other vectors, but I don't know if 56
> for PC9 take that into account.
>
> PS: in the future make sure to include your Linux version number, so we
> know if an issue apply or not.
>
> --
> Guillaume KNISPEL
