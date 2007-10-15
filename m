Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id 9E142DE2EC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:04:18 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so806802wri
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:04:17 -0700 (PDT)
Message-ID: <fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
Date: Mon, 15 Oct 2007 08:04:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
In-Reply-To: <4713551B.9040103@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
	<4713551B.9040103@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Matt Sealey <matt@genesi-usa.com> wrote:
>
> My nits:
>
> Grant Likely wrote:
> > From: Sylvain Munaut <tnt@246tNt.com>
> > +static int __devinit
> > +bcom_engine_init(void)
>
> Why "bcom" and not "bestcomm"?

I can type 'bcom' twice as fast.  :-)  bcom is a suitable shortening;
I'm not concerned about it.

>
> > +     /* Disable COMM Bus Prefetch, apparently it's not reliable yet */
> > +     /* FIXME: This should be done on 5200 and not 5200B ... */
> > +     out_be16(&bcom_eng->regs->PtdCntrl, in_be16(&bcom_eng->regs->PtdCntrl) | 1);
>
> This really, really shouldn't even be here, could it be moved to a platform
> init, or switched on a PVR/SVR here?

I think I'd like to leave it here for getting this series merged; it
may not be good to have it here; but it's not dangerous either.  I'm
trying to keep churn on this series down to a minimum.

Please submit a patch to make this change once it's merged.

>
> > +int bcom_sram_init(struct device_node *sram_node, char *owner)
> > +{
> > +     int rv;
> > +     const u32 *regaddr_p;
> > +     u64 regaddr64, size64;
> > +     unsigned int psize;
> > +
> > +     /* Create our state struct */
> > +     if (bcom_sram) {
> > +             printk(KERN_ERR "%s: bcom_sram_init: "
> > +                     "Already initialiwed !\n", owner);
> > +             return -EBUSY;
> > +     }
>
> initialised or initialized :)

fixed

>
> > +             printk(KERN_ERR "%s: bcom_sram_init: "
> > +                     "Couln't request region !\n", owner);
> > +             rv = -EBUSY;
> > +             goto error_free;
>
> Couldn't or could not.

fixed; thanks.

Cheers,
g.

>
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
