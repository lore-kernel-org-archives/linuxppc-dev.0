Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9D7822C0294
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 23:02:11 +1100 (EST)
Date: Sat, 2 Feb 2013 13:02:01 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] powerpc/512x: add function for CS parameter configuration
Message-ID: <20130202130201.204ee2fd@crub>
In-Reply-To: <CAOZdJXUfe5KWBtabUUPrGHhcFb6dbnPNJCsU23yoxb-4GeKQsg@mail.gmail.com>
References: <1359725305-23916-1-git-send-email-agust@denx.de>
 <CAOZdJXUfe5KWBtabUUPrGHhcFb6dbnPNJCsU23yoxb-4GeKQsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 1 Feb 2013 22:31:51 -0600
Timur Tabi <timur@tabi.org> wrote:

> On Fri, Feb 1, 2013 at 7:28 AM, Anatolij Gustschin <agust@denx.de> wrote:
> > Add ability to configure CS parameters for devices that need
> > different CS parameters setup after their configuration. I.e.
> > an FPGA device on LP bus can require different CS parameters
> > for its bus interface after loading firmware into it. A driver
> > can easily reconfigure the LPC CS parameters using this function.
> 
> Could you define "CS" somewhere?

I'll define it in revised commit log in v2.

> > +struct mpc512x_lpc {
> > +       u32     cs_cfg[8];      /* CS config */
> > +       u32     cs_ctrl;        /* CS Control Register */
> > +       u32     cs_status;      /* CS Status Register */
> > +       u32     burst_ctrl;     /* CS Burst Control Register */
> > +       u32     deadcycle_ctrl; /* CS Deadcycle Control Register */
> > +       u32     holdcycle_ctrl; /* CS Holdcycle Control Register */
> > +       u32     alt;            /* Address Latch Timing Register */
> > +};
> 
> These should be __be32.

Why? To add a new bunch of sparse warnings?

...
> > +       if (cs < 0 || cs > 7)
> > +               return -EINVAL;
> 
> If you make cs an unsigned int, you won't need to test for < 0.

can do that, yes.

> > +
> > +       if (!lpc) {
> > +               np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-lpc");
> > +               lpc = of_iomap(np, 0);
> > +               of_node_put(np);
> > +               if (!lpc)
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       out_be32(&lpc->cs_cfg[cs], val);
> 
> You forgot the iounmap() if lpc == NULL.

No, it is intentional, no need to map/unmap again and again for all
subsequent calls.


> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mpc512x_cs_config);
> 
> EXPORT_SYMBOL, please, to match the rest of the Freescale platforms.

I'll change it in v2. Thanks!

Anatolij
