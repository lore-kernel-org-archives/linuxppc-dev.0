Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8CAFB7C5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 03:35:44 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n96GQVol008500
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 03:26:32 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n96GZggE364854
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 03:35:42 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n96GZewc022998
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 03:35:42 +1100
Date: Tue, 6 Oct 2009 22:05:21 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and
	introduce cpuidle to POWER.
Message-ID: <20091006163521.GA10425@linux.vnet.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20091006152421.GA7278@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-06 20:54:21]:

> Hi
> 
> Please consider this for inclusion into the testing tree.
> 
> This patchset introduces cpuidle infrastructure to POWER, prototyping
> for pSeries, and also does a major refactoring of current x86 idle
> power management and a cleanup of cpuidle infrastructure.
> 
> Earlier discussions on the same can be found at:
> 
> v6 --> http://lkml.org/lkml/2009/9/22/180
> v5 --> http://lkml.org/lkml/2009/9/22/26
> v4 --> http://lkml.org/lkml/2009/9/1/133
> v3 --> http://lkml.org/lkml/2009/8/27/124
> v2 --> http://lkml.org/lkml/2009/8/26/233
> v1 --> http://lkml.org/lkml/2009/8/19/150
> 
> 
> Changes in this version:
> -----------------------------------------
> 
> * Earlier implementation maintained a list of cpuidle devices and
>   the list was traversed to disable and enable the cpuidle devices
>   when switching governors. This list is not necessary and is removed.
>   Now, we get the per cpu structure cpuidle_devices and disable and
>   enable it for each online cpu while switching governors.
> 
> * Earlier iterations were buggy w.r.t the sysfs interface of the cpuidle.
>   This iteration removes the bug in PATCH 1/7.
> 
> * In PATCH 7/7, smt_snooze_delay was not being updated whenever it was
>   changed through the sysfs interface. Provide a helper routine to
>   update it.
> 
> * In PATCH 7/7, the idle loops are renamed to denote the idle states
>   to avoid any confusion.
> 

Also, the per-cpu nature of registration/unregistration of cpuidle
has been maintained as ACPI needs this.

> 
> thanks,
> arun
