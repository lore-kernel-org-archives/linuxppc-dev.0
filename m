Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xD6L34vCwzDrHG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 07:22:19 +1000 (AEST)
Message-ID: <1500585713.10674.10.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers: cpuidle: Disable preemption before get_lppaca
 function call in pseries_idle_probe function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Victor Aoqui <victora@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: ltc-interlock@lists.linux.ibm.com, victora@br.ibm.com,
 mauricfo@linux.vnet.ibm.com
Date: Fri, 21 Jul 2017 07:21:53 +1000
In-Reply-To: <20170720175735.3957-1-victora@linux.vnet.ibm.com>
References: <20170720175735.3957-1-victora@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-20 at 14:57 -0300, Victor Aoqui wrote:
> When CONFIG_PREEMPT=y, the following warning shows up:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is pseries_processor_idle_init+0x58/0x21c
> 
> This warning shows up because preemption cannot occur when using
> get_paca(), otherwise the paca_struct it points to may be the wrong one
> just after.
> 
> For this reason, preemption needs to be disabled before
> lppaca_shared_proc(get_lppaca()).

Also chekc the generated assembly. We had all sort of interesting
issues where gcc would copy the paca pointer or the lppaca pointer
to a GPR *outside* of the preempt disabled section...

In that specific case it's not a big deal but overall, I am not
comfortable with PREEMPT on powerpc until we do something a bit
more drastic...

I would like to remove all such direct accesses to paca, instead have a
"new" get_paca() written in asm that does the preempt disable then
returns the PACA in a GPR (not directly use r13, hide that from gcc),
and which is paired with a put_paca().

The few places where we want to directly access r13 should be hand
written in asm too to hide r13 from gcc, for accessing the irq_happened
in the fast path of local_irq_enable/disable/... we should do the same
with lock tokens.

Ben.
