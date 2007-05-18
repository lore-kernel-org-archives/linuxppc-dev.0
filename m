Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2918FDDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 04:19:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4IIJloK022149
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 11:19:48 -0700 (MST)
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
From: Jon Loeliger <jdl@freescale.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <464DE8BB.5040601@freescale.com>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino> <464CA302.9060707@freescale.com>
	<20070518005641.GA27350@localhost.localdomain>
	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com>
	<464DE5D2.5000301@freescale.com> <464DE6C1.2010108@freescale.com>
	<464DE7F7.3030302@freescale.com>  <464DE8BB.5040601@freescale.com>
Content-Type: text/plain
Message-Id: <1179512385.19664.8.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 18 May 2007 13:19:45 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Wei Zhang <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-18 at 12:56, Timur Tabi wrote:
> Scott Wood wrote:
> 
> > That's your model.  Mine involves merging a fragment that corresponds to 
> > an active hwoption, with no complex conditional evaluation or deletion 
> > of anything from the main tree.
> 
> I think my model (which is also Jon's, I think) is easier to read and implement.

Harumph.

> 
> phy-node [ if j22 = on ]
> {
> 	phy-type = 1
> }
> 
> phy-node [ if j22 = off ]
> {
> 	phy-type = 2
> }
> 
> Obviously, j22 can be either on or off, but never both.  If the DTS is coded incorrectly, 
> then it will have problems, but I think that's a fair trade-off for the easier implementation.

First of all, I wanted to get away from the notion of calling
anything a "jumper".  What I said to you was to predicate the
clause based on some arbitrary conditional, not just some "jumper
setting."

Second, I never came anywhere near the syntax above.

Third, I am pretty sure we've always really been talking
about a DTC enhancement to selectively add regions to the
DTB in much the same way as if one had said:

    #if <compile-time-conditional>
        {
            <use this node or property snippet>
        }
    #else
        {
            <use this other snippet>

        }
    #endif

So embedding a full runtime evaluation of conditionals
expressions wasn't really in my suggestion at this time
at all.  I had essentially proposed (to you, Timur) that
we have a predicate clause in the DTS that guarded a the
presence/absence of a node.

And finally, I wasn't sure I was happy with it all yet
in any event, so I hadn't acted on it yet.  I was still
pondering "the right approach here".

Ah well,
jdl
