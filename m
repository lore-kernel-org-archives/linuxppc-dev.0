Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED9331A030E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 00:25:34 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 405F5140D98
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2015 00:25:34 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 06:25:32 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 264C83E40047
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2015 06:25:31 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tA3DOMoi5833212
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Nov 2015 06:24:22 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA3DPUle017032
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Nov 2015 06:25:30 -0700
Date: Tue, 3 Nov 2015 05:25:26 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: tracing: don't trace hcalls on offline CPUs
Message-ID: <20151103132526.GF29027@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1446145810-5383-1-git-send-email-kda@linux-powerpc.org>
 <1446545202.2801.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446545202.2801.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 03, 2015 at 09:06:42PM +1100, Michael Ellerman wrote:
> On Thu, 2015-10-29 at 22:10 +0300, Denis Kirjanov wrote:
> 
> > ./drmgr -c cpu -a -r gives the following warning:
> > 
> > [ 2327.035563] RCU used illegally from offline CPU!  rcu_scheduler_active = 1, debug_locks = 1
> > [ 2327.035564] no locks held by swapper/12/0.
> > [ 2327.035565] stack backtrace:
> > [ 2327.035567] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G S   4.3.0-rc3-00060-g353169a #5
> > [ 2327.035568] Call Trace:
> > [ 2327.035573] [c0000001d62578e0] [c0000000008977fc] .dump_stack+0x98/0xd4 (unreliable)
> > [ 2327.035577] [c0000001d6257960] [c000000000109bd8] .lockdep_rcu_suspicious+0x108/0x170
> > [ 2327.035580] [c0000001d62579f0] [c00000000006a1d0] .__trace_hcall_exit+0x2b0/0x2c0
> > [ 2327.035584] [c0000001d6257ab0] [c00000000006a2e8] plpar_hcall_norets_trace+0x70/0x8c
> > [ 2327.035588] [c0000001d6257b20] [c000000000067a14] .icp_hv_set_cpu_priority+0x54/0xc0
> > [ 2327.035592] [c0000001d6257ba0] [c000000000066c5c] .xics_teardown_cpu+0x5c/0xa0
> > [ 2327.035595] [c0000001d6257c20] [c0000000000747ac] .pseries_mach_cpu_die+0x6c/0x320
> > [ 2327.035598] [c0000001d6257cd0] [c0000000000439cc] .cpu_die+0x3c/0x60
> > [ 2327.035602] [c0000001d6257d40] [c0000000000183d8] .arch_cpu_idle_dead+0x28/0x40
> > [ 2327.035606] [c0000001d6257db0] [c0000000000ff1dc] .cpu_startup_entry+0x4fc/0x560
> > [ 2327.035610] [c0000001d6257ed0] [c000000000043728] .start_secondary+0x328/0x360
> > [ 2327.035614] [c0000001d6257f90] [c000000000008a6c] start_secondary_prolog+0x10/0x14
> > [ 2327.035620] cpu 12 (hwid 12) Ready to die...
> > [ 2327.144463] cpu 13 (hwid 13) Ready to die...
> > [ 2327.294180] cpu 14 (hwid 14) Ready to die...
> > [ 2327.403599] cpu 15 (hwid 15) Ready to die...
> > 
> > Make the hypervisor tracepoints conditional by introducing
> > TRACE_EVENT_FN_COND similar to TRACE_EVENT_FN
> 
> We've fixed other cases like this with RCU_NONIDLE(), but I assume that
> doesn't work here because we're actually offline?

Yes, RCU_NONIDLE() only works for idle CPUs.  (For tracing, you can also
use the _rcuidle() event-tracing suffix.)  The only way to safely have
RCU readers on offline CPUs is to bring them online.  (SRCU being the
only exception.)

								Thanx, Paul
