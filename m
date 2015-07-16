Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3A4C1A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 07:29:33 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 17:29:30 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 47F0FC90043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 17:20:34 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GLTRrE63111350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:29:27 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GLTRqQ023009
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 17:29:27 -0400
Date: Thu, 16 Jul 2015 14:28:18 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 3/8] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150716212818.GA31962@us.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716201749.GL3644@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150716201749.GL3644@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Jul 14, 2015 at 08:01:50PM -0700, Sukadev Bhattiprolu wrote:
| > @@ -1604,6 +1613,12 @@ static void power_pmu_start_txn(struct pmu *pmu)
| >  static void power_pmu_cancel_txn(struct pmu *pmu)
| >  {
| >  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
| > +	int txn_flags;
| > +
| > +	txn_flags = cpuhw->txn_flags;
| > +	cpuhw->txn_flags = 0;
| > +	if (cpuhw->txn_flags & ~PERF_PMU_TXN_ADD)
| > +		return;
| 
| That seems, unintentional? ;-)

Argh. Thanks for catching it.

Sukadev
