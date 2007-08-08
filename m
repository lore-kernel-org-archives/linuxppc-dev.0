Return-Path: <vuhlig@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD053DDEBA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 01:33:50 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78FXlTL015825
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 11:33:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78FXl0E507332
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 11:33:47 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78FXkKF026991
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 11:33:47 -0400
Subject: RE: Fix small race in 44x tlbie function
Date: Wed, 8 Aug 2007 11:34:09 -0400
MIME-Version: 1.0
To: galak@kernel.crashing.org, david@gibson.dropbear.id.au
From: Volkmar Uhlig <vuhlig@us.ibm.com>
Message-ID: <OF737C2252.4B2755F5-ON04257331.005563C4@us.ibm.com>
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Todd Inglett <tinglett@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: galak@kernel.crashing.org [mailto:galak@kernel.crashing.org] 
> Sent: Wednesday, August 08, 2007 11:21 AM
> To: david@gibson.dropbear.id.au
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org; Todd Inglett; 
> Volkmar Uhlig
> Subject: Re: Fix small race in 44x tlbie function
> 
> 
> On Aug 6, 2007, at 11:20 PM, David Gibson wrote:
> 
> > The 440 family of processors don't have a tlbie instruction.  So, we
> > implement TLB invalidates by explicitly searching the TLB 
> with tlbsx.,
> > then clobbering the relevant entry, if any.  Unfortunately 
> the PID for
> > the search needs to be stored in the MMUCR register, which is also
> > used by the TLB miss handler.  Interrupts were enabled in 
> _tlbie(), so
> > an interrupt between loading the MMUCR and the tlbsx could cause
> > incorrect search results, and thus a failure to invalide TLB entries
> > which needed to be invalidated.
> >
> > This patch fixes the problem in both arch/ppc and arch/powerpc by
> > inhibiting interrupts (even critical and debug interrupts) 
> across the
> > relevant instructions.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > Paul, this one's a bugfix, which I think should go into 2.6.23.
> 
> Did you actually see this happen?

Yes!  (I guess you didn't get the initial mail...)

- Volkmar
