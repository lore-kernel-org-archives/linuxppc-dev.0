Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410QPK4wRSzF1g2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 18:45:41 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w558jBVq131478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2018 04:45:39 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jdpdptcec-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 04:45:38 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 5 Jun 2018 02:45:37 -0600
Date: Tue, 5 Jun 2018 14:15:30 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Reply-To: ego@linux.vnet.ibm.com
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <87fu22bxlf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fu22bxlf.fsf@concordia.ellerman.id.au>
Message-Id: <20180605084529.GA5656@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On Mon, Jun 04, 2018 at 09:27:40PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
> > snooze to deeper idle state") introduced a timeout for the snooze idle
> > state so that it could be eventually be promoted to a deeper idle
> > state. The snooze timeout value is static and set to the target
> > residency of the next idle state, which would train the cpuidle
> > governor to pick the next idle state eventually.
> >
> > The unfortunate side-effect of this is that if the next idle state(s)
> > is disabled, the CPU will forever remain in snooze, despite the fact
> > that the system is completely idle, and other deeper idle states are
> > available.
> 
> That sounds like a bug, I'll add?
>

Yes, this is a bug-fix for a customer scenario which we encountered
recently.

> Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
> Cc: stable@vger.kernel.org # v4.2+

This patch applies cleanly from v4.13 onwards. Prior to that there are
some (minor) conflicts.

Should I spin a version separately for the prior stable versions ?

> 
> cheers
> 
