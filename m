Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0BB86DE0AE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:30:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BKWCg7002389
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 16:32:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BKUgxc126832
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 16:30:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BKUV43030182
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 16:30:31 -0400
Date: Thu, 11 Oct 2007 15:30:21 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Hard hang in hypervisor!?
Message-ID: <20071011203021.GC4258@austin.ibm.com>
References: <20071009203724.GM4350@austin.ibm.com>
	<20071009211819.GR29559@localdomain>
	<20071009212810.GN4350@austin.ibm.com>
	<18189.26776.326248.278431@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18189.26776.326248.278431@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 10:04:40AM +1000, Paul Mackerras wrote:
> Linas Vepstas writes:
> 
> > Err ..  it was cpu 0 that was spinlocked.  Are interrupts not
> > distributed?
> 
> We have some bogosities in the xics code that I noticed a couple of
> days ago.  Basically we only set the xics to distribute interrupts to
> all cpus if (a) the affinity mask is equal to CPU_MASK_ALL (which has
> ones in every bit position from 0 to NR_CPUS-1) and (b) all present
> cpus are online (cpu_online_map == cpu_present_map).  Otherwise we
> direct interrupts to the first cpu in the affinity map.  So you can
> easily have the affinity mask containing all the online cpus and still
> not get distributed interrupts.
> 
> So in your case it's quite possible that all interrupts were directed
> to cpu 0.

Thanks,
I'll give this a whirl if I don't get distracted by other tasks. 

A simple cat /proc/interrupts shows them evenly distributed on
my "usual" box, and all glommed up on cpu 0 on the one thats 
giving me fits.

Also, I noticed years ago that "BAD" was non-zero and large.
Vowed to look into it someday ...

--linas
