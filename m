Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E672C67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 08:07:17 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Sun, 24 Apr 2005 00:07:08 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHIEIKCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <585e588ae8021963207cc6ee9955289e@embeddededge.com>
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

> On Apr 9, 2005, at 3:03 PM, Joakim Tjernlund wrote:
> 
> > yes, but I think these operates on physical addresses which makes it a 
> > bit harder.
> > I still think this can be resolved in fault.c. Replace
> > 	andis.	r11, r10, 0x0200	/* If set, indicates store op */
> > 	beq	2f
> > in the DTLB Error handler with
> > 	andis.	r11, r10, 0x4800	/* If set, indicates invalid pte or 
> > protection violation */
> > 	bne	2f
> > In fault.c you can check if both store and invalid is set 
> > simultaneously. If it is, clear
> > the store flag and continue as usual.
> 
> The purpose for the code in TLB Error is to create fast path for 
> tracking
> writable pages as dirty.  I think we should stop writing all of this 
> assembler

Do you refer to the assembler code above or some other assembler code such
as my dcbX workaround? I once had a C version of that workaround that lived
in fault.c. Sadly it think it is gone now, not sure if I ever sent it to the list.

> code and if we find anything that isn't simply updating the "dirty" 
> flags, we
> should bail out to the fault.c and do whatever is necessary.  This 
> includes
> simulating any cache instructions that fail.
> 
> As a further performance enhancement, which used to be the standard
> mode for 8xx, we should allow the option to mark all writable pages as
> dirty when the PTE is created.  This eliminates the TLB Error fault in 
> this
> case completely.  Since most 8xx systems don't do page swapping, this
> has no other effect.  If it does page swapping, it may swap more pages
> than necessary, or the option can be disabled to do proper paging.
> 
> Thanks.
> 
> 
> 	-- Dan
> 
