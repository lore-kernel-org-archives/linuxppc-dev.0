Return-Path: <Yuri.Norov@cavium.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0058.outbound.protection.outlook.com [104.47.38.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Hm50518SzF1yF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 02:54:27 +1000 (AEST)
Date: Fri, 6 Apr 2018 19:54:02 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: James Morse <james.morse@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Klimov <klimov.linux@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: entry: isb in el1_irq
Message-ID: <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 06, 2018 at 11:02:56AM +0100, James Morse wrote:
> Hi Yury,
> 
> An ISB at the beginning of the vectors? This is odd, taking an IRQ to get in
> here would be a context-synchronization-event too, so the ISB is superfluous.
> 
> The ARM-ARM  has a list of 'Context-Synchronization event's (Glossary on page
> 6480 of DDI0487B.b), paraphrasing:
> * ISB
> * Taking an exception
> * ERET
> * (...loads of debug stuff...)

Hi James, Mark,

I completely forgot that taking an exception is the context synchronization
event. Sorry for your time on reviewing this crap. It means that patches 1,
2 and 3 are not needed except chunk that adds ISB in do_idle() path. 

Also it means that for arm64 we are safe to mask IPI delivering to CPUs that
run any userspace code, not only nohz_full.

In general, kick_all_cpus_sync() is needed to switch contexts. But exit from
userspace is anyway the switch of context. And while in userspace, we cannot
do something wrong on kernel side. For me it means that we can safely drop
IPI for all userspace modes - both normal and nohz_full. 

If it's correct, for v3 I would suggest:
 - in kick_all_cpus_sync() mask all is_idle_task() and user_mode() CPUs;
 - add isb() for arm64 in do_idle() path only - this path doesn't imply
   context switch.

What do you think?

Yury
