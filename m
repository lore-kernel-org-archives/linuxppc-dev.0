Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE006.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id DCF01DE106
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 06:30:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 14:30:45 -0600
In-Reply-To: <fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
	<200904171307.47734.hollisb@us.ibm.com>
	<1239995087.7210.19.camel@pasglop>
	<fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Message-ID: <20090417203053.1D692F88052@mail119-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca] =

> Sent: Friday, April 17, 2009 1:10 PM
> To: Benjamin Herrenschmidt
> Cc: Hollis Blanchard; linuxppc-dev@ozlabs.org; John Linn; =

> Tirumala Reddy Marri
> Subject: Re: Question about DBCR0 initialization for 440
> =

> On Fri, Apr 17, 2009 at 1:04 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Fri, 2009-04-17 at 13:07 -0500, Hollis Blanchard wrote:
> >> On Friday 17 April 2009 12:22:37 Josh Boyer wrote:
> >> > On Fri, Apr 17, 2009 at 11:46 AM, John Linn =

> <John.Linn@xilinx.com> wrote:
> >> > > Josh, any thoughts on putting this into head_44x.S?
> >> >
> >> > The code in the fsl file looks like the right solution. =A0
I do have an
> >> > odd question though, in that it's hard for the
> >> > kernel to really know if something like a BDI is =

> running. =A0Namely,
> >> > that config option doesn't cover RiscWatch in an obvious manner.
> >>
> >> Yeah, setting DBCR0 would interfere with all JTAG probes. =

> The ifdef meands you
> >> can't support both a JTAG debugger and hardware =

> breakpoints in the same
> >> binary? Now that's an annoying restriction.
> >
> > Might be worth checking if external debug is enabled, and =

> override it
> > only if it's not.
> =

> ppc440x5_um.pdf says that both can be enabled.
> =


The code that I started the thread with, from the fsl file, has conditional=
 for the BDI around it.

We think that we still need that conditional as the code is not Oring in th=
e enable such that it would
disable external debug mode for the BDI. But we need it this way for our Xi=
linx pod.

#if !defined(CONFIG_BDI_SWITCH)
            /*
             * The Abatron BDI JTAG debugger does not tolerate others
             * mucking with the debug registers.
             */
            lis     r2,DBCR0_IDM@h
            mtspr   SPRN_DBCR0,r2
            isync
            /* clear any residual debug events */
            li      r2,-1
            mtspr   SPRN_DBSR,r2
#endif =





> g.
> =

> -- =

> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> =

> =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
