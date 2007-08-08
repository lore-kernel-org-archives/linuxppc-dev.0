Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CFEEDDE44
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 02:00:34 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78G0Wtv022028
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:00:32 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78G0VmW254850
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 10:00:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78G0VNp021443
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 10:00:31 -0600
Date: Wed, 8 Aug 2007 11:00:29 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070808110029.43c110ef@weaponx.rchland.ibm.com>
In-Reply-To: <BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Volkmar Uhlig <vuhlig@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Todd Inglett <tinglett@us.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 8 Aug 2007 10:20:45 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 6, 2007, at 11:20 PM, David Gibson wrote:
> 
> > The 440 family of processors don't have a tlbie instruction.  So, we
> > implement TLB invalidates by explicitly searching the TLB with tlbsx.,
> > then clobbering the relevant entry, if any.  Unfortunately the PID for
> > the search needs to be stored in the MMUCR register, which is also
> > used by the TLB miss handler.  Interrupts were enabled in _tlbie(), so
> > an interrupt between loading the MMUCR and the tlbsx could cause
> > incorrect search results, and thus a failure to invalide TLB entries
> > which needed to be invalidated.
> >
> > This patch fixes the problem in both arch/ppc and arch/powerpc by
> > inhibiting interrupts (even critical and debug interrupts) across the
> > relevant instructions.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > Paul, this one's a bugfix, which I think should go into 2.6.23.
> 
> Did you actually see this happen?

Yes.

josh
