Return-Path: <james.morse@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40HmyG2hTQzF1Wm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 03:33:42 +1000 (AEST)
Subject: Re: [PATCH 1/5] arm64: entry: isb in el1_irq
To: Mark Rutland <mark.rutland@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Pekka Enberg
 <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Klimov <klimov.linux@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
 <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
 <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
Date: Fri, 6 Apr 2018 18:30:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

On 06/04/18 18:22, Mark Rutland wrote:
> Digging a bit, I also thing that our ct_user_exit and ct_user_enter
> usage is on dodgy ground today.

[...]

> I think similar applies to SDEI; we don't negotiate with RCU prior to
> invoking handlers, which might need RCU.

The arch code's __sdei_handler() calls nmi_enter() -> rcu_nmi_enter(), which
does a rcu_dynticks_eqs_exit().


Thanks,

James
