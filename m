Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E73D5B7B9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 22:26:58 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n97BQrnQ032001
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 16:56:53 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n97BQqk62101248
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 16:56:53 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n97BQpkH026681
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 16:56:52 +0530
Date: Wed, 7 Oct 2009 16:56:48 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arjan van de Ven <arjan@infradead.org>
Subject: Re: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
Message-ID: <20091007112648.GC7646@dirshya.in.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
	<20091006163521.GA10425@linux.vnet.ibm.com>
	<1254852279.17055.2.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1254852279.17055.2.camel@laptop>
Cc: linux-arch@vger.kernel.org, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	arun@linux.vnet.ibm.com, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-06 20:04:39]:

> On Tue, 2009-10-06 at 22:05 +0530, Arun R Bharadwaj wrote:
> 
> > Also, the per-cpu nature of registration/unregistration of cpuidle
> > has been maintained as ACPI needs this.
> 
> Right, so can't we ditch that and have acpi default to the lowest common
> C-state and warn when various cpus report different C-states?

Hi Peter,

As Arjan mentioned previously, the per-cpu registration has to stay
for x86 for now due to legacy ACPI compatibility.  Breaking that may
break lot of existing users and we do not have a clean fallback
method.  

As far as powerpc is concerned, we can work with a single global
registration.  However we would like to have the same interface across
different archs.

With the new re-factoring (v7), Arun has killed most of the list
traversal and linking between various cpu's cpuidle_driver structures.
Now we have a per-cpu stack of registered devices and we lookup the
structs using online cpumasks.  The cpuidle_driver structure has list
of idle routing pointers (struct cpuidle_state) and rest of it is
statistics that needs to be maintained at a per-cpu level anyway.  All
that is duplicated here is the array of idle routines (struct
cpuidle_state) on each cpu.

The objective of the refactoring is to have a single common idle
routine management framework (remove pm_idle) and we have it done
through cpuidle registration framework.  We can incrementally remove
the per-cpu registration later easily by splitting the cpuidle_driver
structure.

--Vaidy
