Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F59FDE0CE
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:15:33 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4IGFWgC003001
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:15:32 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IGFXYE1507578
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:15:33 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IGFWwJ010774
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:15:32 +1000
Date: Mon, 18 May 2009 21:45:25 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [RFC Patch 1/6] Prepare the PowerPC platform for HW Breakpoint
	infrastructure
Message-ID: <20090518161525.GC27641@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134335.GB14229@in.ibm.com>
	<1242617732.18075.29.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1242617732.18075.29.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>, paulus@samba.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 18, 2009 at 01:35:32PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-05-14 at 19:13 +0530, K.Prasad wrote:
> > plain text document attachment (ppc64_prepare_code_01)
> > Prepare the PowerPC code for HW Breakpoint infrastructure patches by including
> > relevant constant definitions and function declarations.
> 
> Hi !
> 
> Some comments below...
> 
> > +#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */
> 
> Can you use a more verbose constant ? reg.h is included everywhere so
> the risk of collision is high.
>

This constant is used by the generic HW Breakpoint code in
kernel/hw_breakpoint.c too and renaming it here will require changes
there too, while I don't see any existing name-space clashes.

Instead the definition can be moved into arch/powerpc/include/asm/hw_breakpoint.h
and in arch/power/include/asm/processor.h. What do you think?
 
> >  #define   DABR_TRANSLATION	(1UL << 2)
> >  #define   DABR_DATA_WRITE	(1UL << 1)
> >  #define   DABR_DATA_READ	(1UL << 0)
> > +#define   DABR_DATA_RW		(3UL << 0)
> 
> Do you really need that ? It's just DABR_DATA_WRITE | DABR_DATA_READ :-)
> 

Yes, it looks silly. I will remove it. The HW_BREAKPOINT_RW defined in
arch/powerpc/include/asm/hw_breakpoint.h will instead be defined as:

#define HW_BREAKPOINT_RW (DABR_DATA_READ | DABR_DATA_WRITE)


> Cheers,
> Ben.
>

Thanks,
K.Prasad
 
