Return-Path: <ibmirkin@gmail.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F9351A0144
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 00:42:44 +1000 (AEST)
Received: by obcid8 with SMTP id id8so44448526obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:42:41 -0700 (PDT)
MIME-Version: 1.0
Sender: ibmirkin@gmail.com
In-Reply-To: <CAKb7UvjQnHeOQF_BO4eQGPaB0z0qHz5S-pRCDvGtjqFAf8bsAw@mail.gmail.com>
References: <CAKb7Uvi5xTpU=XniQgVbtb8C7ac_6m0L96ZWD8ovg+vCpbXa5g@mail.gmail.com>
 <1440726995.8076.3.camel@ellerman.id.au>
 <CAKb7UvjQnHeOQF_BO4eQGPaB0z0qHz5S-pRCDvGtjqFAf8bsAw@mail.gmail.com>
Date: Mon, 31 Aug 2015 10:42:40 -0400
Message-ID: <CAKb7UvjJ5esbr43nizCh=O-PRpdhCD_9hBcDFfgY5VUrx84M-A@mail.gmail.com>
Subject: Re: Kernel access of bad area on kernel 4.1.6
From: Ilia Mirkin <imirkin@alum.mit.edu>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2015 at 1:30 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> On Thu, Aug 27, 2015 at 9:56 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On Thu, 2015-08-27 at 11:31 -0400, Ilia Mirkin wrote:
>>> I've recently come into the possession of a PowerMac7,3 and have been
>>> cross-compiling a chroot for it on my (x86_64) desktop. However
>>> elfutils doesn't cross-compile for ppc64 due to its biarch m4 script
>>> which tries to execute a built program, so I kicked off a build
>>> locally and left for a few minutes.
>>
>> OK, cross compiling how? A bunch of the guys here use buildroot, but maybe they
>> aren't building elfutils?
>
> This is what I get in configure:
>
> checking whether powerpc64-unknown-linux-gnu-gcc -m32 makes
> executables we can run... configure: error: in
> `/usr/powerpc64-unknown-linux-gnu/tmp/portage/dev-libs/elfutils-0.158/work/elfutils-0.158-abi_ppc_64.ppc64':
> configure: error: cannot run test program while cross compiling
>
> and config.log has:
>
>   $ /usr/powerpc64-unknown-linux-gnu/tmp/portage/dev-libs/elfutils-0.158/work/elfutils-0.158/configure
> --prefix=/usr --build=x86_64-pc-linux-gnu
> --host=powerpc64-unknown-linux-gnu --mandir=/usr/share/man
> --infodir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc
> --localstatedir=/var/lib --disable-dependency-tracking
> --libdir=/usr/lib64 --disable-werror --enable-nls
> --disable-thread-safety --program-prefix=eu- --with-zlib --with-bzlib
> --without-lzma
> ...
> configure:6465: checking powerpc64-unknown-linux-gnu-gcc option for
> 32-bit word size
> configure:6478: powerpc64-unknown-linux-gnu-gcc -m32 -c -O2 -pipe
> -mcpu=G5 -mtune=G5 -fomit-frame-pointer  conftest.c >&5
> configure:6478: $? = 0
> configure:6486: result: -m32
> configure:6490: checking for 64-bit host
> configure:6511: result: yes
> configure:6538: checking whether powerpc64-unknown-linux-gnu-gcc -m32
> makes executables we can run
> configure:6546: error: in
> `/usr/powerpc64-unknown-linux-gnu/tmp/portage/dev-libs/elfutils-0.158/work/elfutils-0.158-abi_ppc_64.ppc64':
> configure:6548: error: cannot run test program while cross compiling
> See `config.log' for more details
>
> I'm building with the help of gentoo's crossdev scripts, which in
> addition to setting up a crosscompiler, also sets up an easy way to
> "emerge" packages into some chroot.
>
> Looking at https://git.fedorahosted.org/cgit/elfutils.git/tree/m4/biarch.m4
> makes it seem like it runs AC_RUN_IFELSE irrespective of
> cross-compilation. Unfortunately I'm not well-enough versed in m4 or
> how cross-compilation is normally handled to suggest a proper fix. I
> seem to recall it's normally done by just saying "if you're
> cross-compiling, you probably know what you're doing and so let's just
> assume things work as expected".
>
>>
>>> When I came back, I saw the below
>>> through netconsole, the fans were going full blast, and the machine
>>> was unresponsive.
>>
>> Fans going full blast is normal when the kernel crashes, it's just a safety
>> precaution so your machine doesn't melt.
>>
>>> Is this a kernel issue?
>>
>> Probably.
>>
>>> Hardware issue?
>>
>> Unlikely to be a hardware issue.
>>
>>> What do I need to do in order
>>> for the instruction dump to not be XXX's and have a call trace?
>>
>> The XXX's mean that we couldn't read the memory where the instructions were in
>> order to dump them, which is odd. I can't immediately see why that happened
>> here.
>>
>> That's separate to getting a call trace, but possibly the same issue is causing
>> both to not be emitted.
>
> Yeah, after sending the email I took a look at
> arch/powerpc/kernel/process.c which has
>
> show_instructions() { ...
>                 if (!__kernel_text_address(pc) ||
>                      probe_kernel_address((unsigned int __user *)pc, instr)) {
>                         printk(KERN_CONT "XXXXXXXX ");
>
> and has various guards around printing a call trace.
>
>>
>>> (Is this the annoying security stuff in action? I started with the
>>
>> Which stuff? Probably not though.
>
> Oh I just remember a bunch of stuff getting added to the kernel to
> prevent information leaks via dmesg prints, in conjunction with kaslr.
> But you're right, this isn't it.
>
>>
>>> g5_defconfig, perhaps that was a mistake.)
>>
>> That should be a good config, and it booted originally right.
>>
>>> Sorry for the newbie questions, but I'm very new to ppc.
>>
>> No worries, welcome to ppc land! :)
>>
>>
>>> In case it matters, it's booted on an nfsroot, no swap.
>>
>> OK. I don't test nfsroot so that could be the problem.
>>
>> What kernel version, 4.1.6 ?
>
> Yes, 4.1.6 (as one could surmise from the backtrace).
>
>>
>>> Thanks for any help,
>>>
>>>   -ilia
>>>
>>> [ 8419.415061] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [ 8419.416338] SMP NR_CPUS=4 PowerMac
>>> [ 8419.417623] Modules linked in: snd_aoa_codec_tas snd_aoa snd
>>> nouveau soundcore btusb btbcm btintel ttm bluetooth drm_kms_helper drm
>>> uninorth_agp agpgart
>>> [ 8419.419138] CPU: 0 PID: 12927 Comm: as Not tainted 4.1.6 #4
>>> [ 8419.420539] task: c0000000573f3520 ti: c000000057698000 task.ti:
>>> c000000057698000
>>> [ 8419.421963] NIP: c00000005769bca8 LR: c00000005769bca8 CTR: c00000000008a710
>>> [ 8419.423400] REGS: c00000005769b7e0 TRAP: 0400   Not tainted  (4.1.6)
>>> [ 8419.424850] MSR: 9000000010001032 <SF,HV,ME,IR,DR,RI>  CR: 001048fc
>>>  XER: 00000000
>>> [ 8419.426407] SOFTE: 0
>>> GPR00: 00000000ffffffff c00000005769ba60 c000000000b9ac00 c0000000590bb520
>>> GPR04: c0000000573f3ab0 c0000000573f3588 c0000000001048fc c00000005769bca8
>>> GPR08: c00000005769b890 c000000050000000 0000000000000001 c00000005ee0a290
>>> GPR12: 0000000024044048 c00000000ffff000 c00000005769ba20 0000000000000600
>>> GPR16: 0000000000000001 0000000000000000 c00000005bbd8e00 c000000058ccbcb0
>>> GPR20: c00000005769ba50 0000000000000000 c000000000103d60 c00000005bbd8e00
>>> GPR24: c00000005769ba40 0000000000000000 0000000000000001 0000000000000001
>>> GPR28: 000000001007d630 0000000010049d08 c00000005769bc80 c000000058ccbcb0
>>> [ 8419.440558] NIP [c00000005769bca8] 0xc00000005769bca8
>>> [ 8419.442170] LR [c00000005769bca8] 0xc00000005769bca8
>>> [ 8419.443774] Call Trace:
>>> [ 8419.445351] Instruction dump:
>>> [ 8419.446946] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>>> XXXXXXXX XXXXXXXX
>>> [ 8419.448659] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>>> XXXXXXXX XXXXXXXX
>>> [ 8419.456445] ---[ end trace ad7c77d8920840ff ]---
>>> [ 8419.456511]
>>> [ 8419.456565] Fixing recursive fault but reboot is needed!
>>
>> Is this definitely the first oops?
>>
>> That looks like a pretty standard null pointer deref, or other bad pointer in
>> the kernel. I can't tell exactly without the instruction dump though.
>
> Not *definitely* the first oops, but definitely the first one in
> netconsole. I unfortunately didn't have time to deal with the problem
> when it happened and just shut the system off without looking at the
> console. I'll give it all another shot.
>
> Thanks for the detailed reply!

I've been having lots of general trouble on this machine... like no
older kernels boot, but 4.1.6 and 4.2-rc8 are fine. I suspect that the
toolchain might have some issues :( I've downgraded gcc to 4.8, but
that didn't resolve it, binutils is next. However on 4.2-rc8 (well,
~airlied/drm-next), I managed to capture on netconsole the below
(although it hangs fairly often, but usually without any messaging on
OFfb or netconsole). By the way, you can tell if it's a first oops or
not based on the taint... first oops will say 'Not tainted', while
follow-up ones will have some taint.

[  247.551040] Oops: Kernel access of bad area, sig: 11 [#1]
[  247.551215] SMP NR_CPUS=4 PowerMac
[  247.551323] Modules linked in: cfg80211 snd_aoa_codec_tas snd_aoa
snd soundcore uninorth_agp agpgart
[  247.551655] CPU: 0 PID: 2122 Comm: syslog-ng Not tainted
4.2.0-rc8-01316-g4b9e78b #6
[  247.551873] task: c000000059b61a90 ti: c000000059bcc000 task.ti:
c000000059bcc000
[  247.552081] NIP: c0000000002d4e14 LR: c0000000002d4df8 CTR: c0000000002ef380
[  247.552276] REGS: c000000059bcf530 TRAP: 0300   Not tainted
(4.2.0-rc8-01316-g4b9e78b)
[  247.552496] MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR:
42004422  XER: 20000000
[  247.552808] DAR: 0000000000100108 DSISR: 42000000 SOFTE: 1
GPR00: c0000000002d4f5c c000000059bcf7b0 c000000000b9dc00 c0000000570058a0
GPR04: c0000000580880c8 0000000000000081 0000000000000001 0000000000100100
GPR08: c0000000580880d0 0000000000200200 0000000000100100 7f7f7f7f7f7f7f7f
GPR12: 0000000022004428 c00000000ffff000 0000000044000000 0000000022000000
GPR16: 0000000010042418 00003fffe6383ae6 0000000000000000 ffffffffffffffff
GPR20: 000000000000003a 00003fffe6382b58 0000000010020400 0000000000000000
GPR24: 000000001001db68 fffffffffffffff6 c000000059b4501d 0000000000000081
GPR28: c0000000570058b8 c000000057106d00 c0000000580881b8 c0000000570058a0
[  247.554756] NIP [c0000000002d4e14] .nfs_do_access+0x3b4/0x410
[  247.554918] LR [c0000000002d4df8] .nfs_do_access+0x398/0x410
[  247.555075] Call Trace:
[  247.555147] [c000000059bcf7b0] [c0000000002d4e44]
.nfs_do_access+0x3e4/0x410 (unreliable)
[  247.563012] [c000000059bcf8a0] [c0000000002d4f5c] .nfs_permission+0xac/0x230
[  247.567129] [c000000059bcf930] [c000000000171f84]
.__inode_permission+0x94/0x100
[  247.575049] [c000000059bcf9c0] [c00000000017548c] .link_path_walk+0x8c/0x630
[  247.579155] [c000000059bcfa90] [c000000000175ba8] .path_lookupat+0xb8/0x1b0
[  247.583183] [c000000059bcfb20] [c00000000017802c] .filename_lookup+0x8c/0x180
[  247.587134] [c000000059bcfc90] [c00000000016ad68] .vfs_fstatat+0x78/0x130
[  247.590989] [c000000059bcfd40] [c00000000016b38c] .SyS_newstat+0x1c/0x50
[  247.594733] [c000000059bcfe30] [c000000000007c98] system_call+0x38/0xd0
[  247.598380] Instruction dump:
[  247.601901] 4bfff79d 4bfffd8c 7fe3fb78 389eff10 481656ad 60000000
e91f0020 e8ff0018
[  247.609048] 3d400010 3d200020 61290200 614a0100 <f9070008> f8e80000
f95f0018 f93f0020
[  247.616395] ---[ end trace c9fc24592b1a7aba ]---
[  247.619918]
[  247.624094] Unable to handle kernel paging request for data at
address 0x00000014
[  247.631108] Faulting instruction address: 0xc0000000004f60d0
[  247.634787] Oops: Kernel access of bad area, sig: 11 [#2]
[  247.638480] SMP NR_CPUS=4 PowerMac
[  247.642140] Modules linked in: cfg80211 snd_aoa_codec_tas snd_aoa
snd soundcore uninorth_agp agpgart
[  247.649826] CPU: 0 PID: 1052 Comm: kwindfarm Tainted: G      D
   4.2.0-rc8-01316-g4b9e78b #6
[  247.657608] task: c000000059524fb0 ti: c000000059afc000 task.ti:
c000000059afc000
[  247.665544] NIP: c0000000004f60d0 LR: c0000000004f60c4 CTR: c000000000041770
[  247.669647] REGS: c000000059aff700 TRAP: 0300   Tainted: G      D
       (4.2.0-rc8-01316-g4b9e78b)
[  247.677582] MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR:
22022442  XER: 20000000
[  247.685687] DAR: 0000000000000014 DSISR: 40000000 SOFTE: 1
GPR00: c0000000004f60c4 c000000059aff980 c000000000b9dc00 0000000000000001
GPR04: 00000000025da79d 0000000000000000 c000000059524fb0 0000000000000000
GPR08: 0000000080000000 0000000000000009 0000000000000000 0000000000009324
GPR12: 0000000022022448 c00000000ffff000 c0000000000780a0 c000000059ae0740
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR28: c000000000b66f40 0000000000000000 0000000000000004 c000000059affacc
[  247.721539] NIP [c0000000004f60d0] .wf_fcu_fan_get_rpm+0x50/0x150
[  247.725125] LR [c0000000004f60c4] .wf_fcu_fan_get_rpm+0x44/0x150
[  247.728656] Call Trace:
[  247.732114] [c000000059aff980] [c0000000004f60c4]
.wf_fcu_fan_get_rpm+0x44/0x150 (unreliable)
[  247.739328] [c000000059affa30] [c0000000004f9204]
.pm72_wf_notify+0x784/0x1260
[  247.746623] [c000000059affb50] [c0000000000794ec]
.notifier_call_chain+0x7c/0xf0
[  247.754143] [c000000059affbf0] [c000000000079954]
.__blocking_notifier_call_chain+0x64/0xa0
[  247.761831] [c000000059affc90] [c0000000004f544c] .wf_thread_func+0x9c/0x170
[  247.765805] [c000000059affd30] [c0000000000781a4] .kthread+0x104/0x130
[  247.769715] [c000000059affe30] [c000000000007fa8]
.ret_from_kernel_thread+0x58/0xb0
[  247.777183] Instruction dump:
[  247.780808] 3880000b f8010010 f821ff51 ebc30048 38a10073 ebfe0020
7fe3fb78 837f0048
[  247.788221] 4bfffc31 2f830001 409e00b8 89210073 <815e0010> 7d295630
793d07e1 408200d4
[  247.795659] ---[ end trace c9fc24592b1a7abb ]---
[  247.799338]
