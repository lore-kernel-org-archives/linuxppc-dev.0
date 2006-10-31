Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 7A2FC67B7C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 03:24:48 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1301304ugc
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 08:24:46 -0800 (PST)
Message-ID: <528646bc0610310824n114b844fv4afb9f0b66070d99@mail.gmail.com>
Date: Tue, 31 Oct 2006 09:24:44 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
In-Reply-To: <4546F7DE.6070104@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<4546F7DE.6070104@bplan-gmbh.de>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/31/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> Kumar Gala wrote:
> > +/* MBAR position */
> > +#define MPC52xx_MBAR        0xf0000000    /* Phys address */
> > +#define MPC52xx_MBAR_VIRT    0xf0000000    /* Virt address */
> > +#define MPC52xx_MBAR_SIZE    0x00010000
> > +
> > +#define MPC52xx_PA(x)        ((phys_addr_t)(MPC52xx_MBAR + (x)))
> > +#define MPC52xx_VA(x)        ((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
> >
> > This should be handled dynamically (pulled from the device tree), I
> > doubt MBAR will be at the same location for all boards.
>
> Well, 0xf000000 seems some kind of 'standart' value. we could have a
> global variable 'mpc52xx_mbar' which would be default 0xf0000000 and
> modified by each platform.

In my lite5200 device tree; I've got an "soc5200@f0000000" node which
provides the MBAR base address.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
