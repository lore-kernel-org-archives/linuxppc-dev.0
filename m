Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E05251A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:56:35 +1000 (AEST)
Message-ID: <1440726995.8076.3.camel@ellerman.id.au>
Subject: Re: Kernel access of bad area on kernel 4.1.6
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Aug 2015 11:56:35 +1000
In-Reply-To: <CAKb7Uvi5xTpU=XniQgVbtb8C7ac_6m0L96ZWD8ovg+vCpbXa5g@mail.gmail.com>
References: <CAKb7Uvi5xTpU=XniQgVbtb8C7ac_6m0L96ZWD8ovg+vCpbXa5g@mail.gmail.com>
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

On Thu, 2015-08-27 at 11:31 -0400, Ilia Mirkin wrote:
> I've recently come into the possession of a PowerMac7,3 and have been
> cross-compiling a chroot for it on my (x86_64) desktop. However
> elfutils doesn't cross-compile for ppc64 due to its biarch m4 script
> which tries to execute a built program, so I kicked off a build
> locally and left for a few minutes.

OK, cross compiling how? A bunch of the guys here use buildroot, but maybe they
aren't building elfutils?

> When I came back, I saw the below
> through netconsole, the fans were going full blast, and the machine
> was unresponsive.

Fans going full blast is normal when the kernel crashes, it's just a safety
precaution so your machine doesn't melt.

> Is this a kernel issue?

Probably.

> Hardware issue? 

Unlikely to be a hardware issue.

> What do I need to do in order
> for the instruction dump to not be XXX's and have a call trace? 

The XXX's mean that we couldn't read the memory where the instructions were in
order to dump them, which is odd. I can't immediately see why that happened
here.

That's separate to getting a call trace, but possibly the same issue is causing
both to not be emitted.

> (Is this the annoying security stuff in action? I started with the

Which stuff? Probably not though.

> g5_defconfig, perhaps that was a mistake.) 

That should be a good config, and it booted originally right.

> Sorry for the newbie questions, but I'm very new to ppc.

No worries, welcome to ppc land! :)


> In case it matters, it's booted on an nfsroot, no swap.

OK. I don't test nfsroot so that could be the problem.

What kernel version, 4.1.6 ?

> Thanks for any help,
> 
>   -ilia
> 
> [ 8419.415061] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 8419.416338] SMP NR_CPUS=4 PowerMac
> [ 8419.417623] Modules linked in: snd_aoa_codec_tas snd_aoa snd
> nouveau soundcore btusb btbcm btintel ttm bluetooth drm_kms_helper drm
> uninorth_agp agpgart
> [ 8419.419138] CPU: 0 PID: 12927 Comm: as Not tainted 4.1.6 #4
> [ 8419.420539] task: c0000000573f3520 ti: c000000057698000 task.ti:
> c000000057698000
> [ 8419.421963] NIP: c00000005769bca8 LR: c00000005769bca8 CTR: c00000000008a710
> [ 8419.423400] REGS: c00000005769b7e0 TRAP: 0400   Not tainted  (4.1.6)
> [ 8419.424850] MSR: 9000000010001032 <SF,HV,ME,IR,DR,RI>  CR: 001048fc
>  XER: 00000000
> [ 8419.426407] SOFTE: 0
> GPR00: 00000000ffffffff c00000005769ba60 c000000000b9ac00 c0000000590bb520
> GPR04: c0000000573f3ab0 c0000000573f3588 c0000000001048fc c00000005769bca8
> GPR08: c00000005769b890 c000000050000000 0000000000000001 c00000005ee0a290
> GPR12: 0000000024044048 c00000000ffff000 c00000005769ba20 0000000000000600
> GPR16: 0000000000000001 0000000000000000 c00000005bbd8e00 c000000058ccbcb0
> GPR20: c00000005769ba50 0000000000000000 c000000000103d60 c00000005bbd8e00
> GPR24: c00000005769ba40 0000000000000000 0000000000000001 0000000000000001
> GPR28: 000000001007d630 0000000010049d08 c00000005769bc80 c000000058ccbcb0
> [ 8419.440558] NIP [c00000005769bca8] 0xc00000005769bca8
> [ 8419.442170] LR [c00000005769bca8] 0xc00000005769bca8
> [ 8419.443774] Call Trace:
> [ 8419.445351] Instruction dump:
> [ 8419.446946] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX
> [ 8419.448659] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX
> [ 8419.456445] ---[ end trace ad7c77d8920840ff ]---
> [ 8419.456511]
> [ 8419.456565] Fixing recursive fault but reboot is needed!

Is this definitely the first oops?

That looks like a pretty standard null pointer deref, or other bad pointer in
the kernel. I can't tell exactly without the instruction dump though.

cheers
