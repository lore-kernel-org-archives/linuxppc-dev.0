Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3792AB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 16:45:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87047DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 16:45:00 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Allow perf_counters to access user memory
	at interrupt time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19066.25278.925555.133212@drongo.ozlabs.ibm.com>
References: <19066.25278.925555.133212@drongo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 16:44:53 +1000
Message-Id: <1249973093.9841.107.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 14:57 +1000, Paul Mackerras wrote:
> This provides a mechanism to allow the perf_counters code to access
> user memory in a PMU interrupt routine.  Such an access can cause
> various kinds of interrupt: SLB miss, MMU hash table miss, segment
> table miss, or TLB miss, depending on the processor.  This commit
> only deals with the classic/server processors that use an MMU hash
> table, not processors that have software-loaded TLBs.

 .../...

> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

As discussed in the lab, you should also do a pre-req patch to pgtable.h
that changes ppc32 with 64-bit PTE without CONFIG_SMP to use the same
path as SMP to order the stores to the two halves of the PTEs though.

Cheers,
Ben.
