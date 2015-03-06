Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D77A51A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 16:12:05 +1100 (AEDT)
Message-ID: <1425615522.4636.173.camel@kernel.crashing.org>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 06 Mar 2015 15:18:42 +1100
In-Reply-To: <20150305171239.3a8135e6@gandalf.local.home>
References: <20150305171239.3a8135e6@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-05 at 17:12 -0500, Steven Rostedt wrote:
> A bug in ftrace was reported to me that affects ARM and ARM64 but not
> x86. Looking at the code it appears to affect PowerPC as well. So I
> booted up my old PA Semi, to give it a try. The last time I booted it
> was for a 3.17 kernel. Unfortunately, for 4.0-rc2 it crashed with:

Argh. Well, we have one of these here but Michael who owns it is off til
Tuesday. 

Can you shoot me the DT (/proc/device-tree in a tarball) ? Olof, can the
DT be updated on this thing or should we add workarounds to Linux if
something is really missing ?

Cheers,
Ben.

> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc0000000005cef88
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=2 PA Semi PWRficient
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.0.0-rc2-test #50
> task: c00000003816cb60 ti: c0000000381a4000 task.ti: c0000000381a4000
> NIP: c0000000005cef88 LR: c00000000007c1a0 CTR: c00000000007c184
> REGS: c0000000381a7a00 TRAP: 0300   Not tainted  (4.0.0-rc2-test)
> MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 22000028  XER: 00000000
> DAR: 0000000000000000 DSISR: 40000000 SOFTE: 0 
> GPR00: c00000000007c1a0 c0000000381a7c80 c000000000af4b98 0000000000000001 
> GPR04: 0000000000000000 0000000000000000 00000000000004ba 000000003d6de000 
> GPR08: 0100000000000000 0000000000000000 c0000000381a4080 0000000000000000 
> GPR12: 0000000024044042 c00000000ffff300 ffffffffffffffed 0000000000000000 
> GPR16: c000000000afb920 c0000000381a4000 c0000000009ad648 c0000000009ae580 
> GPR20: c0000000381a4080 c0000000381a4000 c0000000381a4080 c0000000381a4000 
> GPR24: c0000000381a4000 c0000000381a4000 c000000000afb880 c0000000381a4000 
> GPR28: c0000000009f8790 0000000000000000 c0000000381a4000 c000000000b02168 
> NIP [c0000000005cef88] .check_astate+0x28/0x50
> LR [c00000000007c1a0] sleep_common+0x14/0x74
> Call Trace:
> [c0000000381a7c80] [c000000000afb880] 0xc000000000afb880 (unreliable)
> [c0000000381a7cf0] [c00000000007c1a0] sleep_common+0x14/0x74
> [c0000000381a7d30] [c0000000000130f0] .arch_cpu_idle+0x70/0x160
> [c0000000381a7db0] [c0000000000d6660] .cpu_startup_entry+0x320/0x5a0
> [c0000000381a7ee0] [c000000000034570] .start_secondary+0x290/0x2c0
> [c0000000381a7f90] [c000000000008bfc] start_secondary_prolog+0x10/0x14
> Instruction dump:
> 60000000 60000000 7c0802a6 f8010010 f821ff91 60000000 60000000 3d220003 
> 39296870 a86d0038 e9290010 7c0004ac <7c004c2c> 0c000000 4c00012c 5463103a 
> ---[ end trace 40e864a431826b26 ]---
> 
> I kicked off a ktest bisect, and it came down to this commit:
> 
> commit 746c9e9f92dde2789908e51a354ba90a1962a2eb
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Fri Nov 14 17:55:03 2014 +1100
> 
>     of/base: Fix PowerPC address parsing hack
> 
> When I revert this from v4.0-rc2, I can successfully boot my PA Semi
> again.
> 
> -- Steve
