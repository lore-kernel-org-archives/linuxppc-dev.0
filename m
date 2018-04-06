Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40Hmzj6xw6zF219
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 03:34:57 +1000 (AEST)
Date: Fri, 6 Apr 2018 18:34:50 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: James Morse <james.morse@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Christopher Lameter <cl@linux.com>,
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
Message-ID: <20180406173450.5h7lgh2xdtcs5fbs@lakrids.cambridge.arm.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
 <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
 <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
 <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 06, 2018 at 06:30:50PM +0100, James Morse wrote:
> Hi Mark,
> 
> On 06/04/18 18:22, Mark Rutland wrote:
> > Digging a bit, I also thing that our ct_user_exit and ct_user_enter
> > usage is on dodgy ground today.
> 
> [...]
> 
> > I think similar applies to SDEI; we don't negotiate with RCU prior to
> > invoking handlers, which might need RCU.
> 
> The arch code's __sdei_handler() calls nmi_enter() -> rcu_nmi_enter(), which
> does a rcu_dynticks_eqs_exit().

Ah, sorry. I missed that!

Thanks,
Mark.
