Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FB411A012C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 17:39:47 +1000 (EST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 36B5514009C
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2014 17:39:45 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 01:39:43 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4571B6E8040
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2014 03:39:28 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s857ddMJ7209306
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2014 07:39:39 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s857dceY023804
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2014 03:39:39 -0400
Subject: [PATCH V2 0/2] cpufreq/powernv: Set core pstate to a minimum just
 before hotplugging it out
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Date: Fri, 05 Sep 2014 13:09:32 +0530
Message-ID: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pm@vger.kernel.org, dirk.j.brandewie@intel.com,
 shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 patrick.marlier@gmail.com, linuxppc-dev@ozlabs.org, dirk.brandewie@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today cpus go to winkle when they are offlined. Since it is the deepest
idle state that we have, it is expected to save good amount of power as compared
to online state, where cores can enter nap/fastsleep only which are
shallower idle states.
However we observed no powersavings with winkle as compared to nap/fastsleep
and traced the problem to the pstate of the core being kept at a high even
when the core is offline. This can keep the socket pstate high, thus burning
power unnecessarily. This patchset fixes this issue.

Changes in V2: Changed smp_call_function_any() to smp_call_function_single() in Patch[2/2]

---

Preeti U Murthy (2):
      cpufreq: Allow stop CPU callback to be used by all cpufreq drivers
      powernv/cpufreq: Set the pstate of the last hotplugged out cpu in policy->cpus to minimum


 drivers/cpufreq/cpufreq.c         |    2 +-
 drivers/cpufreq/powernv-cpufreq.c |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--
