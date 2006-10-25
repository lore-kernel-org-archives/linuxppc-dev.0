Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 1AB7D67CB3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 08:41:37 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so210835ugc
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 15:41:35 -0700 (PDT)
Message-ID: <528646bc0610251541s21bb45f1t6fc911778d5084@mail.gmail.com>
Date: Wed, 25 Oct 2006 16:41:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <17727.56923.634981.723647@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453FB582.20802@bplan-gmbh.de>
	<17727.56923.634981.723647@cargo.ozlabs.ibm.com>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/25/06, Paul Mackerras <paulus@samba.org> wrote:
> Nicolas DET writes:
>
> >       if (machine && strncmp(machine, "Pegasos", 7) == 0) {
> >               _chrp_type = _CHRP_Pegasos;
> > +     } else if (machine && strncmp(machine, "EFIKA5K2", 8) == 0) {
> > +             _chrp_type =_CHRP_E5K2;
>
> This whole _chrp_type thing, and having to do different things based
> on the root-node model property, is really only a workaround for
> older machines with inadequate device trees.  Decisions about things
> like which interrupt controller driver(s) to instantiate should be
> taken based on properties in the appropriate device-tree nodes, for
> instance the model and compatible properties in the node(s) for the
> interrupt controller(s).  In fact I'd like to get rid of _chrp_type
> completely.

What are the implications anyway for the bplan board being CHRP vs the
way the rest of the embedded ppcs are set up?  Will having this setup
as a CHRP system conflict w/ non-CHRP embedded boards?  (I'm assuming
that CHRP requires more capable firmware than u-boot passing in a fdt)

>
> > diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
> > --- a/include/asm-ppc/mpc52xx.h       2006-10-25 19:07:48.000000000 +0200
> > +++ b/include/asm-ppc/mpc52xx.h       2006-10-25 19:11:55.000000000 +0200
> > @@ -119,7 +119,7 @@ enum ppc_sys_devices {
> >  #define MPC52xx_SDMA_IRQ_NUM 17
> >  #define MPC52xx_PERP_IRQ_NUM 23
> >
> > -#define MPC52xx_CRIT_IRQ_BASE        1
> > +#define MPC52xx_CRIT_IRQ_BASE        0
>
> What is this going to do to other 52xx users?

Shouldn't be a big deal if all drivers use the macros; but as you
pointed out on IRC, the interrupt stuff needs to be reworked for the
interrupt mapping interface anyway

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
