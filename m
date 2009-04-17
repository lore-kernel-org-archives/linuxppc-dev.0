Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 5E25CDE098
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 06:57:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 14:57:18 -0600
In-Reply-To: <200904171550.19625.hollisb@us.ibm.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
	<20090417203053.1D692F88052@mail119-dub.bigfish.com>
	<200904171550.19625.hollisb@us.ibm.com>
From: John Linn <John.Linn@xilinx.com>
To: "Hollis Blanchard" <hollisb@us.ibm.com>
Message-ID: <20090417205724.4B3DE9F0063@mail101-dub.bigfish.com>
Cc: Tirumala Reddy Marri <tmarri@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Hollis Blanchard [mailto:hollisb@us.ibm.com] =

> Sent: Friday, April 17, 2009 2:50 PM
> To: John Linn
> Cc: grant.likely@secretlab.ca; Benjamin Herrenschmidt; =

> linuxppc-dev@ozlabs.org; Tirumala Reddy Marri
> Subject: Re: Question about DBCR0 initialization for 440
> =

> On Friday 17 April 2009 15:30:45 John Linn wrote:
> > We think that we still need that conditional as the code is =

> not Oring in the =

> enable such that it would
> > disable external debug mode for the BDI. But we need it =

> this way for our =

> Xilinx pod.
> > =

> > #if !defined(CONFIG_BDI_SWITCH)
> >             /*
> >              * The Abatron BDI JTAG debugger does not =

> tolerate others
> >              * mucking with the debug registers.
> >              */
> >             lis     r2,DBCR0_IDM@h
> >             mtspr   SPRN_DBCR0,r2
> >             isync
> >             /* clear any residual debug events */
> >             li      r2,-1
> >             mtspr   SPRN_DBSR,r2
> > #endif
> =

> So change the code to OR in your bits. What's the problem?

The Xilinx pod uses external mode and we don't want it set when running
Linux on the board. It is targeted more to stand alone (non-OS)
applications with different debug requirements.

> =

> -- =

> Hollis Blanchard
> IBM Linux Technology Center
> =

> =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
