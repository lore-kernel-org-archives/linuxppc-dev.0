Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6A82DDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 09:32:28 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m91NWPMJ000743
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 19:32:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m91NWPjv230734
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 19:32:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m91NWP0k030794
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 19:32:25 -0400
Date: Wed, 1 Oct 2008 19:32:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Message-ID: <20081001193223.5c43a2c6@zod.rchland.ibm.com>
In-Reply-To: <200810020014.20414.niklaus.giger@member.fsf.org>
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<20081001180835.GA7601@yoda.jdub.homelinux.org>
	<200810020014.20414.niklaus.giger@member.fsf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2 Oct 2008 00:14:19 +0200
Niklaus Giger <niklaus.giger@member.fsf.org> wrote:

> Am Mittwoch 01 Oktober 2008 20.08:35 schrieb Josh Boyer:
> > On Wed, Oct 01, 2008 at 07:47:16PM +0200, Niklaus Giger wrote:
> > >Adds preliminary support for a HCU4 PPC405GPr based board from
> > >Netstal Maschinen AG.
> > >
> > >For the last 3 years I have been the only user running Linux on this
> > > board, but it served me well as testbed for the xenomai realtime
> > > extension to the Linux kernel.
> >
> > Overall, really nice for a first submission.
> One never has a second chance to make a first imrpession.
> 
> It was easy to make the needed changes (except changing ibm -> amcc, see 
> below). The dtc does the conversion from the old to the new format dts-v1 
> without a hitch. Calling "dtc -I dts -O dts hcu5.dts.old >hcu5.dts.new"l
> 
> My board is now in even better shape than before as I discovered that in my 
> dts I even wrongly overwrote a the speed variable for the early boot messages.
> Thanks a lot for suggestion!
> 
> > >+/ {
> > >+	#address-cells = <1>;
> > >+	#size-cells = <1>;
> > >+	model = "ibm,hcu4";
> > >+	compatible = "ibm,hcu4";
> >
> > These shouldn't be "ibm,hcu4".  IBM didn't make these boards.
> > Instead, you should make them "<company>,<board>", where
> > <company> is the company that made them (often the stock ticker
> > is used), and <board> is obviously hcu4 in this case.
> 
> Can you explain this a little bit more to me. When we started to fabricate our 
> boards we got the chips (or were it only the even older PPC403?) from IBM. If 
> I just replace in this dts file "ibm" by "amcc" my board does not boot anymore. 
> But if you give me a hint where and what I have to replace. I would volunteer 
> to clean it up (if it not too much work) a little bit.

No no.  I don't mean throughout the DTS file.  I just mean in the top
level model and compatible properties.  Those properties apply to the
overall board.  The CPU an ASCIs (EMAC, serial, etc) in the DTS are most
certainly from IBM, but your company actually manufactures the board.

So the top should be something like:

model = "netstal,hcu4";
compatible = "netstal,hcu4";

Everything else in the DTS looked fine in this regard as it is.

You will have to change your hcu4.c file to have:

	if (!of_flat_dt_is-compatible(root, "netstal,hcu4"))
		return 0;

and then it should be ok.

josh
