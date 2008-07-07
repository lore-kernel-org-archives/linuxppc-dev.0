Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2239DDFCC
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:10:30 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67EAQ76014525
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:10:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67EAQOx207798
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:10:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67EAQ8X006469
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:10:26 -0400
Date: Mon, 7 Jul 2008 10:07:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify
	additional default targets
Message-ID: <20080707100704.26f1630c@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40807070634t6e9047d1k7d8ca2b443d1ae68@mail.gmail.com>
References: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
	<fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
	<20080707091818.72d584fe@zod.rchland.ibm.com>
	<fa686aa40807070634t6e9047d1k7d8ca2b443d1ae68@mail.gmail.com>
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

On Mon, 7 Jul 2008 07:34:23 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Mon, Jul 7, 2008 at 7:18 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > On Fri, 4 Jul 2008 00:51:44 -0600
> > "Grant Likely" <grant.likely@secretlab.ca> wrote:
> >
> >> Anyone had a chance to look at this?  I think this could be used to
> >> eliminate a lot of the platform specific default targets in
> >> arch/powerpc/boot/Makefile by moving them into the defconfigs.  Josh,
> >> Kumar, what are your thoughts?
> >
> > So for cases like Kilauea/Haleakala or Bamboo/Yosemite, you would
> > specify Yosemite in the bamboo defconfig?  Or?
> 
> If they share a defconfig, then yes, that is what I'm thinking about...
> 
> > I actually sort of prefer having a separate defconfig/CONFIG_YOSEMITE
> > (as an example) because it's much easier for an end user to figure out
> > if the board is supported or not.
> 
> ...however, these don't have to disappear if you prefer them.

Right.

> > I could be totally misunderstanding the intention of this patch though,
> > so I'll stop rambling and wait to see what the use case is.
> 
> Specifically the case I'm thinking of is when a user of a Xilinx FPGA
> drops a new .dts file into arch/powerpc/boot/dts (say
> 'super-sexy-platform.dts').  However, instead of modifying the
> Makefile or always typing 'make simpleImage.super-sexy-platform', then
> can add 'simpleImage.super-sexy-platform' to their defconfig which I
> can see being easier for someone to get their head around.

Yeah, I thought about the Virtex case with the differing bitstreams
after I sent out my original question.  For purposes like that, this
seems like a great fit.  For truly discrete boards, I prefer discrete
defconfigs.

So overall I see value in the patch.  If nobody else has objections,
then it's fine with me.

josh
