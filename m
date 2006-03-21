Return-Path: <nathanl@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7600A679E6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 10:27:06 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2LNR4LX008508
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 18:27:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2LNO3PM257792
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 16:24:03 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2LNR3wH016649
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 16:27:03 -0700
Subject: Re: [PATCH 7/7] powerpc numa: Consolidate assignment of cpus to nodes
From: Nathan Lynch <nathanl@austin.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <200603221009.19523.michael@ellerman.id.au>
References: <11429014352189-git-send-email-nathanl@austin.ibm.com>
	<1142966317.10906.172.camel@localhost.localdomain>
	<1142968571.27114.28.camel@pants.austin.ibm.com>
	<200603221009.19523.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 17:22:59 -0600
Message-Id: <1142983379.28864.9.camel@pants.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-22 at 10:09 +1100, Michael Ellerman wrote:
> On Wed, 22 Mar 2006 06:16, Nathan Lynch wrote:
> > On Tue, 2006-03-21 at 10:38 -0800, Dave Hansen wrote:
> > > By the way, what do the "l" and "h" in front of "cpu" mean anyway?
> >
> > "logical" and "hot"?  I dunno, just seemed to be the convention in other
> > cpu notifiers at the time the code was written.
> 
> Ouch, that's unfortunate. In the powerpc code hcpu _usually_ means hard cpu 
> number, as opposed to logical (lcpu).

Grep begs to differ:

$ grep -rw hcpu arch/powerpc include/asm-powerpc
arch/powerpc/kernel/sysfs.c:                                  unsigned long action, void *hcpu)
arch/powerpc/kernel/sysfs.c:    unsigned int cpu = (unsigned int)(long)hcpu;
arch/powerpc/mm/numa.c:                      void *hcpu)
arch/powerpc/mm/numa.c: unsigned long lcpu = (unsigned long)hcpu;
