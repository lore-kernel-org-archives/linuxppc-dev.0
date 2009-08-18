Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2E1A0B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 14:24:49 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79F00DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:24:48 +1000 (EST)
Subject: Re: [PATCH 2/3 v3] powerpc: Allow perf_counters to access user
	memory at interrupt time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19081.57621.37210.987830@cargo.ozlabs.ibm.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<19081.57621.37210.987830@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 14:24:40 +1000
Message-Id: <1250569480.19007.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-18 at 09:00 +1000, Paul Mackerras wrote:
> This provides a mechanism to allow the perf_counters code to access
> user memory in a PMU interrupt routine.  Such an access can cause
> various kinds of interrupt: SLB miss, MMU hash table miss, segment
> table miss, or TLB miss, depending on the processor.  This commit
> only deals with 64-bit classic/server processors, which use an MMU
> hash table.  32-bit processors are already able to access user memory
> at interrupt time.  Since we don't soft-disable on 32-bit, we avoid
> the possibility of reentering hash_page or the TLB miss handlers,
> since they run with interrupts disabled.

  .../...

> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
