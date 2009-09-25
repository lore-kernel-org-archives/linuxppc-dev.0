Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5618CB7B91
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 17:06:48 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8P75RHi006732
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 17:05:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8P74cIq1622068
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 17:04:38 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8P76j9V004937
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 17:06:46 +1000
Date: Fri, 25 Sep 2009 12:36:23 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
Message-ID: <20090925070623.GH8595@dirshya.in.ibm.com>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
	<20090924051238.GA5963@linux.vnet.ibm.com>
	<20090924142228.5a2ddf59@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090924142228.5a2ddf59@infradead.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, arun@linux.vnet.ibm.com,
	Ingo Molnar <mingo@elte.hu>, Shaohua Li <shaohua.li@intel.com>,
	linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arjan van de Ven <arjan@infradead.org> [2009-09-24 14:22:28]:

> On Thu, 24 Sep 2009 10:42:41 +0530
> Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
> 
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22 16:55:27]:
> > 
> > Hi Len, (or other acpi folks),
> > 
> > I had a question regarding ACPI-cpuidle interaction in the current
> > implementation.
> > 
> > Currently, every cpu (i.e. acpi_processor) registers to cpuidle as
> > a cpuidle_device. So every cpu has to go through the process of
> > setting up the idle states and then registering as a cpuidle device.
> > 
> > What exactly is the reason behind this?
> > 
> 
> technically a BIOS can opt to give you C states via ACPI on some cpus,
> but not on others.
> 
> in practice when this happens it tends to be a bug.. but it's
> technically a valid configuration

So we will need to keep the per-cpu registration as of now because we
may have such buggy BIOS in the field and we don't want the cpuidle
framework to malfunction there.

--Vaidy
