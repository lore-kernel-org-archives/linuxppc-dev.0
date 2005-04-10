Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 001AC67B2B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Apr 2005 20:08:49 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Date: Sun, 10 Apr 2005 12:08:29 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHEEGOCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050409223721.GA27454@logos.cnet>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 8xx v2.6 TLB problems and suggested workaround
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> On Sat, Apr 09, 2005 at 09:03:54PM +0200, Joakim Tjernlund wrote:
> > > 
> > > On Apr 8, 2005, at 7:07 AM, Marcelo Tosatti wrote:

[SNIP]

> > I still think this can be resolved in fault.c. Replace 
> > 	andis.	r11, r10, 0x0200	/* If set, indicates store op */
> > 	beq	2f
> > in the DTLB Error handler with
> > 	andis.	r11, r10, 0x4800	/* If set, indicates invalid pte or protection violation */
> > 	bne	2f
> 
> Why does the current code jump to page fault handler in case of store operation?

It doesn't. It jumps if some other bit is set as well. In your dcbst case it seems like invalid
is set too. I hope that will be enough to work something out in fault.c.
 
> 
> Out of curiosity, aren't there any other valid bit combinations for DSISR other
> than 0x4800 which should allow a fastpath DataTLBError ?

Don't know, hopefully Dan knows.

> 
> I can't find DSISR settings in MPC860UM.pdf neither paper manual. AFAICS it
> always refer to the PEM when talking about DSISR bit assignments. 
> 
> I can't find section "7-15" as you mentioned in the other email.

It is page 7-15 and I think(not having the manual handy) that chapter 7 describes the
different exceptions including the DTLB Error.

> 
> > In fault.c you can check if both store and invalid is set simultaneously. If it is, clear
> > the store flag and continue as usual.
> 
> One point is that by changing the in-kernel dcbst implementation userspace is 
> still vulnerable to the problem.
> 
> Now fixing the exception handler to deal with such boggosity as Joakim proposes is 
> complete - it handles userspace dcbst callers.

Yes, ldso uses dcbst and icbi. Currently it works fine because a normal store
has been performed before dcbst/icbi is executed.

 Jocke
