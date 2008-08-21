Return-Path: <hollisb@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08D49DF663
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:25:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7LMPgb6015446
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:25:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7LMPf45222544
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 16:25:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7LMPf1h030353
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 16:25:41 -0600
Subject: Re: [PATCH 2/4] kvmppc: add hypercall infrastructure - guest part
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808191328.16934.arnd@arndb.de>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<200808191328.16934.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 21 Aug 2008 17:25:40 -0500
Message-Id: <1219357540.20238.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-19 at 13:28 +0200, Arnd Bergmann wrote:
> On Tuesday 19 August 2008, ehrhardt@linux.vnet.ibm.com wrote:
> > +static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
> > +{
> > +       register unsigned long hcall asm ("r0") = nr;
> > +       register unsigned long arg1 asm ("r3") = p1;
> > +       register long ret asm ("r11");
> > +
> > +       asm volatile(".long %1"
> > +                       : "=r"(ret)
> > +                       : "i"(KVM_HYPERCALL_BIN), "r"(hcall), "r"(arg1)
> > +                       : "r4", "r5", "r6", "r7", "r8",
> > +                         "r9", "r10", "r12", "cc");
> > +       return ret;
> > +}
> 
> What is the reasoning for making the calling convention different from
> all the existing hcall interfaces here?
> 
> pseries uses r3 for the hcall number, lv1 and beat use r11, so using
> r0 just for the sake of being different seems counterintuitive.

There was a really good reason at the time, but I can't seem to remember
it now. ;) We're thinking about it.

-- 
Hollis Blanchard
IBM Linux Technology Center
