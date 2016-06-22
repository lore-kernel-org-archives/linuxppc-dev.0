Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZSr852jhzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:17:12 +1000 (AEST)
Date: Thu, 23 Jun 2016 01:16:55 +1000
From: Anton Blanchard <anton@samba.org>
To: shreyas@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, mpe@ellerman.id.au,
 mikey@neuling.org, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: cpuidle broken on mainline
Message-ID: <20160623011655.62c610bd@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I was noticing some pretty big run to run variations on single threaded
benchmarks, and I've isolated it cpuidle issues. If I look at
the cpuidle tracepoint, I notice we only go into the snooze state.

Do we have any known bugs in cpuidle at the moment?

While looking around, I also noticed PM_QOS_CPU_DMA_LATENCY,
which seems like a bad thing for us. It is used in places like
the e1000e adapter:

drivers/net/ethernet/intel/e1000e/netdev.c:
    pm_qos_add_request(&adapter->pm_qos_req, PM_QOS_CPU_DMA_LATENCY

Seems like that would force us into SMT8 mode all the time. Can we
disable it on ppc64le completely?

Anton
