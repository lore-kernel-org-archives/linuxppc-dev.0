Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrvR10D9NzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 11:04:45 +1100 (AEDT)
Date: Mon, 27 Mar 2017 11:04:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: kvmppc: BUG: using smp_processor_id() in preemptible
Message-ID: <20170327000441.GA21072@fergus.ozlabs.ibm.com>
References: <CAOJe8K3h2a9QDb0F7cTUUxFNP_i7w4LGy4eedFYSzLOuoJwRbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K3h2a9QDb0F7cTUUxFNP_i7w4LGy4eedFYSzLOuoJwRbg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 25, 2017 at 03:00:27PM +0300, Denis Kirjanov wrote:
> [Now with the proper subject]
> 
> Hi,
> 
> the commit 5a319350a46572d073042a3194676099dd2c135d
> has introduces the following warning with CONFIG_DEBUG_PREEMPT enabled:
> 
> [  129.314426] BUG: using smp_processor_id() in preemptible [00000000]
> code: modprobe/5459
> [  129.314580] caller is .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
> [  129.314697] CPU: 11 PID: 5459 Comm: modprobe Not tainted
> 4.11.0-rc3-00022-gc7e790c #1
> [  129.314848] Call Trace:
> [  129.314915] [c0000007d624b810] [c0000000023eef10]
> .dump_stack+0xe4/0x150 (unreliable)
> [  129.315065] [c0000007d624b8a0] [c000000001f6ec04]
> .check_preemption_disabled+0x134/0x150
> [  129.315210] [c0000007d624b940] [d00000000a010274]
> .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
> [  129.315339] [c0000007d624ba00] [c00000000191d5cc] .do_one_initcall+0x5c/0x1c0
> [  129.315416] [c0000007d624bad0] [c0000000023e9494] .do_init_module+0x84/0x240
> [  129.315492] [c0000007d624bb70] [c000000001aade18] .load_module+0x1f68/0x2a10
> [  129.315568] [c0000007d624bd20] [c000000001aaeb30] .SyS_finit_module+0xc0/0xf0
> [  129.315645] [c0000007d624be30] [c00000000191baec] system_call+0x38/0xfc
> 
> I think that we have to explicitly add a call to preempt_disable to
> the get_paca() macro with the CONFIG_DEBUG_PREEMPT enabled.
> 
> Probably we need to create a common accessor function since we already
> have a special cases like svcpu_get/svcpu_put
> 
> If you agree I'm going send a patch.

I don't think we should put a preempt_disable() in get_paca().  If we
did that then we would also have to make a put_paca() that does
preempt_enable() and add a call to put_paca() everywhere that we call
get_paca().

All we really need to do is add a preempt_disable/enable pair in
kvmppc_book3s_init_hv().

Paul.
