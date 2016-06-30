Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgMYV0n1xzDr23
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 00:36:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UEYaee070419
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 10:36:28 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09rh6bf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 10:36:27 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 00:36:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1065C2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 00:36:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UEaMU414876880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 00:36:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UEaLs1006869
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 00:36:21 +1000
Date: Thu, 30 Jun 2016 20:06:18 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: rjw@rjwysocki.net
CC: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au,
 bsingharora@gmail.com, David.Laight@ACULAB.COM, arnd@arndb.de,
 nicolas.pitre@linaro.org
Subject: Re: [PATCH] cpuidle: Fix last_residency division
References: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57752E62.5030909@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please ignore this mail. I have resent this post using the correct
version number. Sorry for the noise.


On 06/30/2016 07:57 PM, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereby
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exits
> due to this timeout, its last_residency will be target_residency of next
> deeper state.
> 
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
> changed the math around last_residency calculation. Specifically, while
> converting last_residency value from nanoseconds to microseconds it does
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency of
> next available state. This pattern is picked up get_typical_interval()
> in the menu governor and therefore expected_interval in menu_select() is
> frequently less than the target_residency of any state but snooze.
> 
> Due to this we are entering snooze at a higher rate, thereby affecting
> the single thread performance.
> 
> Fix this by using a better approximation for division by 1000.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Suggested-by David Laight <david.laight@aculab.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> Changes in v4
> =============
>  - Increasing the threshold upto which approximation can be used.
>  - Removed explicit cast. Instead added a comment saying why cast
>    is safe.
> 
> Changes in v3
> =============
>  - Using approximation suggested by David
> 
> Changes in v2
> =============
>  - Fixing it in the cpuidle core code instead of driver code.
> 
