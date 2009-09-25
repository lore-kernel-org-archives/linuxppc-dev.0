Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61313B7BC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 03:09:09 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8PH93aO022613
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 22:39:03 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8PH93wR2617428
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 22:39:03 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8PH92RI014788
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 22:39:03 +0530
Date: Fri, 25 Sep 2009 22:38:51 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
Message-ID: <20090925170851.GA28191@linux.vnet.ibm.com>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090922112526.GA7788@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
Hi,

I have done the following experiments and have posted the results
below.


Average of 5 iterations:
------------------------------------------------------------------------------
------------------------------------------------------------------------------

Kernbench make -j16 results on a
16 core x86 machine _with_deep_sleep_ support (C1,C2,C3)


Without the patches applied			With the patches applied


	31.8s						30.4s

------------------------------------------------------------------------------
------------------------------------------------------------------------------


Kernbench make -j8 results on a
8 core x86 machine _without_deep_sleep_ support (only mwait)


Without the patches applied			With the patches applied


	20.2s						20.4s

------------------------------------------------------------------------------
------------------------------------------------------------------------------

Kernbench make -j8 results on a 8 core _dedicated_lpar_pSeries_ machine


Without the patches applied                     With the patches applied


	4m, 37s						4m, 36s

------------------------------------------------------------------------------
------------------------------------------------------------------------------

Please let me know if any other kind of testing is necessary.


Based on the feedback, I will post out the next iteration with a few
minor bug fixes.


thanks,
arun
