Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D20211A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 14:16:11 +1000 (AEST)
In-Reply-To: <1438344538.13223.9.camel@tiscali.nl>
To: Paul Bolle <pebolle@tiscali.nl>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: windfarm: decrement client count when unregistering
Message-Id: <20150805041611.ACBD6140324@ozlabs.org>
Date: Wed,  5 Aug 2015 14:16:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-31-07 at 12:08:58 UTC, Paul Bolle wrote:
> wf_unregister_client() increments the client count when a client
> unregisters. That is obviously incorrect. Decrement that client count
> instead.
> 
> Fixes: 75722d3992f5 ("[PATCH] ppc64: Thermal control for SMU based machines")
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> cross-compiled only. I don't have a PPC machine at hand, sorry. And this
> does need some run-time testing, I'd day.
> 
> windfarm_corex_exit() contains:
>     BUG_ON(wf_client_count != 0);
> 
> I wonder why that, apparently. never triggered.

Hmm interesting.

A quick test here on an iMacG5 shows that we get into a state where we can't
remove windfarm_core:

  $ lsmod
  Module                  Size  Used by
  windfarm_smu_sensors    7549  2
  windfarm_core          15391  1 windfarm_smu_sensors


Which means we can't trigger windfarm_core_exit() and the BUG_ON().

I also get an oops when removing windfarm_lm75_sensor, so I suspect there are
gremlins in the module ref counting for windfarm.

I'll merge this as probably correct.

  ------------[ cut here ]------------
  WARNING: at ../kernel/module.c:1116
  Modules linked in: windfarm_lm75_sensor(-) windfarm_smu_sensors windfarm_smu_controls windfarm_core [last unloaded: windfarm_cpufreq_clamp]
  CPU: 0 PID: 2860 Comm: modprobe Not tainted 4.2.0-rc2-00043-gf4e908dd3cbe-dirty #2
  task: c00000003d9c4fe0 ti: c00000003df20000 task.ti: c00000003df20000
  NIP: c0000000000d62d0 LR: d0000000004338bc CTR: c0000000000d62a0
  REGS: c00000003df23660 TRAP: 0700   Not tainted  (4.2.0-rc2-00043-gf4e908dd3cbe-dirty)
  MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 82002884  XER: 20000000
  SOFTE: 1 
  GPR00: d0000000004338b0 c00000003df238e0 c000000000b27800 d000000000474b00 
  GPR04: c00000003d185900 0000000000000001 000000003e5de000 000000000000175c 
  GPR08: c000000000a2c068 0000000000000001 ffffffffffffffff d0000000004343c0 
  GPR12: c0000000000d62a0 c00000000ffff000 0000000000000004 0000000000000001 
  GPR16: 0000000000000000 0000000000000000 0000000000000000 00000000ffe108bc 
  GPR20: 0000000000000000 00000000209b0278 0000000000000000 0000000000000001 
  GPR24: 00000000ffe11915 00000000209b0008 00000000209b02ac 0000000000000000 
  GPR28: 0000000000000000 c00000003d1b3c80 0000000000000000 d000000000474b00 
  NIP [c0000000000d62d0] .module_put+0x30/0x40
  LR [d0000000004338bc] .wf_put_sensor+0x9c/0xf0 [windfarm_core]
  Call Trace:
  [c00000003df238e0] [d0000000004338b0] .wf_put_sensor+0x90/0xf0 [windfarm_core] (unreliable)
  [c00000003df23960] [d000000000474020] .wf_lm75_remove+0x20/0x40 [windfarm_lm75_sensor]
  [c00000003df239d0] [c00000000058cb8c] .i2c_device_remove+0x7c/0xb0
  [c00000003df23a50] [c000000000450dd4] .__device_release_driver+0xb4/0x180
  [c00000003df23ad0] [c000000000451a08] .driver_detach+0x138/0x180
  [c00000003df23b70] [c000000000450720] .bus_remove_driver+0x70/0xf0
  [c00000003df23bf0] [c0000000004523a8] .driver_unregister+0x38/0x70
  [c00000003df23c70] [c00000000058d718] .i2c_del_driver+0x28/0x40
  [c00000003df23cf0] [d0000000004743fc] .wf_lm75_driver_exit+0x18/0x2cc [windfarm_lm75_sensor]
  [c00000003df23d60] [c0000000000d82bc] .SyS_delete_module+0x18c/0x250
  [c00000003df23e30] [c000000000007c98] system_call+0x38/0xd0
  Instruction dump:
  2c230000 4d820020 392302e0 7c2004ac 7d404828 2c0a0001 394affff 41c00010 
  7d40492d 40c2ffec 7c0004ac 55490ffe <0b090000> 4e800020 60000000 60000000 
  ---[ end trace 013348a741cf9320 ]---


cheers
