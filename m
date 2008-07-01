Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id A2D62DE2EE
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 02:36:18 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so402128yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 09:36:17 -0700 (PDT)
Date: Tue, 1 Jul 2008 10:36:12 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH2/2] [POWERPC] CPM1: implement GPIO LIB API on CPM1
	Freescale SoC.
Message-ID: <20080701163612.GD6918@secretlab.ca>
References: <4808D606.5070309@scram.de>
	<fa686aa40804210730s2f356d92ib4247423d55911cd@mail.gmail.com>
	<486A4FFE.6020407@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486A4FFE.6020407@scram.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 01, 2008 at 05:40:46PM +0200, Jochen Friedrich wrote:
> Hi Grant,
> 
> sorry for the late response on this one.
> 
> > 2. You need to specifiy exact chip names in your compatible string.
> > "fsl,cpm1-pario-<bank>" is a made up thing.
> 
> >>  +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank16")
> >>  +               cpm1_gpiochip_add16(np);
> >>  +
> >>  +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32b")
> >>  +               cpm1_gpiochip_add32(np);
> >>  +
> >>  +       /* Port E uses CPM2 layout */
> >>  +       for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32e")
> >>  +               cpm2_gpiochip_add32(np);
> 
> What do you suggest here?
> 
> All GPIO ports of CPM1/CPM2 are on the SoC, so the chip name is in fact the CPU itself
> (like fsl,mpc866-pario-bank16).

Right; so that is what I think you should call them. 'fsl,mpc866-*' instead
of 'fsl,cpm1-*'.  If multiple mpc8xx parts have the cpm1 core, then
choose one of the parts for all the others to claim compatibility with.

Now, there is a possible exception here... *IF* 'fsl,cpm1' is a very
well defined ASIC logic block that is known to be identical or versioned
between the various 8xx parts, *THEN* it is probably okay to call it
fsl,cpm1 and my previous comment does not apply.  But, I think it must
be documented in the device tree binding as to what it is and where to
get documentation for it.  And you should still have the first
compatible value to be something like "fsl,mpc866-pario-bank16",
followed by the cpm ones.

This was recently discussed between Kim and Segher.

g.
