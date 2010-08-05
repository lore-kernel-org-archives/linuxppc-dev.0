Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11769B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Aug 2010 23:31:27 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id o75DVMn4022475
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Aug 2010 19:01:22 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o75DVMvC3191030
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Aug 2010 19:01:22 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o75DVLBX012756
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Aug 2010 23:31:21 +1000
Date: Thu, 5 Aug 2010 19:01:09 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH] powerpc: ONLINE to OFFLINE CPU state transition during
	removal
Message-ID: <20100805133109.GH3282@dirshya.in.ibm.com>
References: <20100723024343.GC32534@linux.vnet.ibm.com>
	<20100723041309.GB4728@dirshya.in.ibm.com>
	<4C4DDE5F.7090207@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4C4DDE5F.7090207@austin.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>, Julia Lawall <julia@diku.dk>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nathan Fontenot <nfont@austin.ibm.com> [2010-07-26 14:13:35]:

> On 07/22/2010 11:13 PM, Vaidyanathan Srinivasan wrote:
> > * Robert Jennings <rcj@linux.vnet.ibm.com> [2010-07-22 21:43:44]:
> > 
> >> If a CPU remove is attempted using the 'release' interface on hardware
> >> which supports extended cede, the CPU will be put in the INACTIVE state
> >> rather than the OFFLINE state due to the default preferred_offline_state
> >> in that situation.  In the INACTIVE state it will fail to be removed.
> >>
> >> This patch changes the preferred offline state to OFFLINE when an CPU is
> >> in the ONLINE state.  After cpu_down() is called in dlpar_offline_cpu()
> >> the CPU will be OFFLINE and CPU removal can continue.
> > 
> > Hi Robert,
> > 
> > Thanks for the patch.  In dlpar operation, we would offline the CPU
> > first using the sysfs online file and then write to the sysfs release
> > file to complete the sequence right?  The current code in
> > dlpar_offline_cpu() would work as long as the cpu is in either
> > inactive state or offline state (in case of unsupported platform).
> > 
> > Is the dlpar tools being changed to complete the operation with one
> > sysfs write to release file?
> 
> The dlpar tools were updated so that a single write to the 'release' file
> would offline the cpu and remove it from the system.  Given this, I think
> Robert's patch should go forward to maintain compatability.

Hi Nathan,

Thanks for clarifying.  One concern that I have is that this change
could race with sysfs write to cpuN/online file.

dlpar_offline_cpu() is called with cpu_hotplug_driver_lock() held so
the sysfs operation on online file should wait.  However by the time
the cpu_hotplug_driver_unlock() happens the dlpar operation should
have completed and we should not be able to online or offline the cpu
from sysfs online file.

I wanted to confirm whether any concurrent sysfs write will not cause
the dlpar operation to fail in the middle of the operation.

The previous code will work fine for platforms not supporting
cede_offline where we have only two states for the cpu.

When cede_offline is supported, we have three states and the state
transitions are controlled by online file and the release file in two
steps so that the failures can be retried in user space.

This patch will work and I do not see any problem as such, but we
still need to carefully evaluate the retry and error handling paths
before switching over to a single sysfs write based dlpar operation.

--Vaidy
