Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysGNn5mDHzDrV1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 22:19:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB6BJ4cT126467
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 06:19:50 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2epem0k44w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 06:19:50 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 6 Dec 2017 06:19:49 -0500
Date: Wed, 6 Dec 2017 16:49:44 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 viresh.kumar@linaro.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, huntbag@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive &
 negative pstates
Reply-To: ego@linux.vnet.ibm.com
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <87r2s8dt3w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2s8dt3w.fsf@concordia.ellerman.id.au>
Message-Id: <20171206111944.GB22880@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, Dec 06, 2017 at 09:54:27PM +1100, Michael Ellerman wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > Pstates are 8bit values but on POWER8 they are negative and on POWER9
> > they are positive. This patch adds helper routines to differentiate
> > the sign to read the correct pstate value.
> 
> This sounds like it could be a bad bug, but I can't really tell from the
> change log. What is the actual impact of not having this patch?

On some POWER9 platforms, there can be more than 128 pstates. 

Without this patch, on such platforms, if the value of the current
frequency corresponds to a pstate greater than 128, then the code will
interpret it as a negative number, and report that the "pstate is out
of bound" while returning a nominal frequency.

> 
> Should it have a Fixes/Cc-stable tag?

This doesn't fix any prior commit, but is fixes a newly discovered
bug.

I will resend the patch Cc'ing stable.

> 
> cheers
> 
