Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.224])
	by ozlabs.org (Postfix) with ESMTP id 6DCD7DE087
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:06:45 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id a33so1633456qbd
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 14:06:43 -0700 (PDT)
Message-ID: <fa686aa40710151406i6700db4ewde49a2551b95393e@mail.gmail.com>
Date: Mon, 15 Oct 2007 15:06:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
In-Reply-To: <4713D35A.9080200@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
	<4713551B.9040103@genesi-usa.com>
	<fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
	<4713D35A.9080200@genesi-usa.com>
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
> Grant Likely wrote:
> > On 10/15/07, Matt Sealey <matt@genesi-usa.com> wrote:
> >> My nits:
> >>
> >> Grant Likely wrote:
> >>> From: Sylvain Munaut <tnt@246tNt.com>
> >>> +static int __devinit
> >>> +bcom_engine_init(void)
> >> Why "bcom" and not "bestcomm"?
> >
> > I can type 'bcom' twice as fast.  :-)  bcom is a suitable shortening;
> > I'm not concerned about it.
>
> I hate acronyms and shortening for the sake of it.
>
> My IDE highlights known symbols from includes and lets me tab complete them :D
>
> After all once all these APIs are fixed and most of the drivers are implemented
> (most of them are, already, anyway, and have been from TaskSomething to sdma_
> to bcom_ changes and major API reworks), I wonder why we have to constantly
> cut every function definition down to 4 characters rhp_bjz_ywh_moo_purr()
>
> I'd level the same thing at bcom_eng (what's an Eng when it's at home? English?
> Engraved? Surely Engine but.. come on :)
>
> There's no real good need to shorten the names of things except when those
> shortenings are also used in the documentation - after all, PSC is what Freescale
> call a PSC, we wouldn't be making structures called mpc52xx_programmable_serial_controller,
> that's redundant, I don't think calling it "bestcomm" (which is it's name) over
> "bcom" (which isn't) works to anyone's advantage here.

bcom is used consistently within this file and its use is unambiguous.
 It doesn't need to be changed for this submission.

>
> >>> +     /* Disable COMM Bus Prefetch, apparently it's not reliable yet */
> >>> +     /* FIXME: This should be done on 5200 and not 5200B ... */
> >>> +     out_be16(&bcom_eng->regs->PtdCntrl, in_be16(&bcom_eng->regs->PtdCntrl) | 1);
> >> This really, really shouldn't even be here, could it be moved to a platform
> >> init, or switched on a PVR/SVR here?
> >
> > I think I'd like to leave it here for getting this series merged; it
> > may not be good to have it here; but it's not dangerous either.  I'm
> > trying to keep churn on this series down to a minimum.
>
> Why not just accept the churn, and remove those two lines, and someone will
> submit a patch to make it work on the 5200 in the appropriate place later?

Simple; it's not my series.  I'm taking the viewpoint of only changing
what is critical to change to get the code in.  Those 2 lines may be
sub-optimal; but they are not *bad* or *dangerous* and they're easily
removed later.  I'm pushing this change with my maintainer hat on; not
as the device driver developer and as such only making necessary
changes.  My view is that it is *safe* and *good* to merge this driver
as is so that the FEC and other drivers can finally get unblocked.
Send me a patch to change it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
