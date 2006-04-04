Return-Path: <ntl@pobox.com>
Received: from proof.pobox.com (proof.pobox.com [207.106.133.28])
	by ozlabs.org (Postfix) with ESMTP id 667DD679F0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 03:48:45 +1000 (EST)
Date: Tue, 4 Apr 2006 12:25:50 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp
	spinup
Message-ID: <20060404172550.GE25663@localdomain>
References: <20060404112459.C9170679EB@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060404112459.C9170679EB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Currently we use a cpumask called of_spin_map to keep track of which threads
> have been spun up. We basically guess that OF has spun up all even numbered
> threads, and so all the odd numbered threads need to be brought up.
> 
> That's a bit of a dicey assumption at best, and is totally incorrect for
> kexec.
>
> Luckily we have an rtas call which can tell us whether a cpu is up
> or not, so let's use it?

1. query-cpu-stopped-state isn't available on all RTAS systems (I
   believe it's required only on systems that support cpu offline).

2. I've tried it before.  Hope I'm remembering this correctly, but I
   think my experience was that query-cpu-stopped-state reported
   nonsense for cpus that were started by OF.  This was on Power5,
   btw.

3. This isn't how query-cpu-stopped-state was intended to be used.
   It's meant to be used by the OS to determine when a thread has
   stopped itself using the stop-self method.  Which might partially
   explain (2).

I'm fine with getting rid of the assumptions about thread numbering,
but I don't think this is gonna work, sorry.
