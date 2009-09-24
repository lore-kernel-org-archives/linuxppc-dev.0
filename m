Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64B94B7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 15:13:08 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8O56O0s014775
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2009 15:06:24 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8O5D5KJ1077326
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2009 15:13:05 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8O5D3Km029978
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2009 15:13:04 +1000
Date: Thu, 24 Sep 2009 10:42:41 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Len Brown <lenb@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>, Shaohua Li <shaohua.li@intel.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and
	introduce cpuidle to POWER.
Message-ID: <20090924051238.GA5963@linux.vnet.ibm.com>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090922112526.GA7788@linux.vnet.ibm.com>
Cc: linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22 16:55:27]:

Hi Len, (or other acpi folks),

I had a question regarding ACPI-cpuidle interaction in the current
implementation.

Currently, every cpu (i.e. acpi_processor) registers to cpuidle as
a cpuidle_device. So every cpu has to go through the process of
setting up the idle states and then registering as a cpuidle device.

What exactly is the reason behind this?

Is this really necessary or can we have a system-wide one-time registering
to cpuidle by ACPI?

I'm currently in the process of enabling cpuidle for POWER systems and
find that having a system-wide registering mechanism to be a cleaner
design.

--arun
