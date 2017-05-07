Return-Path: <linuxuser330250@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLHv04xgbzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 May 2017 17:53:32 +1000 (AEST)
Subject: Re: WARNING: CPU: 0 PID: 1 at
 /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
 check_features+0x38/0x7c
To: Michael Ellerman <mpe@ellerman.id.au>,
 Mathieu Malaterre <mathieu.malaterre@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CA+7wUsyo5HEVrNFGaH0WGB5WTatX7R7t_s2XhcbZ3kSDsAh2hA@mail.gmail.com>
 <878tmdyllf.fsf@concordia.ellerman.id.au>
 <b1d293d3-ebfe-94c0-0fd7-d1f85d7d7247@gmx.net>
From: Linux User #330250 <linuxuser330250@gmx.net>
Message-ID: <7e00c45a-3ff8-f029-cf5e-befe18395382@gmx.net>
Date: Sun, 7 May 2017 09:53:15 +0200
MIME-Version: 1.0
In-Reply-To: <b1d293d3-ebfe-94c0-0fd7-d1f85d7d7247@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 2017-05-06 um 16:11 schrieb Linux User #330250:
> Am 2017-05-04 um 12:15 schrieb Michael Ellerman:
>> Mathieu Malaterre <mathieu.malaterre@gmail.com> writes:
>>
>>> Hi all,
>>>
>>> Does this dmesg output speaks to anyone here (smp kernel):
>>>
>>>
>>> [    4.767389] ------------[ cut here ]------------
>>> [    4.774668] WARNING: CPU: 0 PID: 1 at
>>> /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
>>> check_features+0x38/0x7c
>> Is there anything prior to the "cut here" line?
>>
>> cheers
>>
>
> # uname -a
> Linux G4QS 4.9.0-2-powerpc-smp #1 SMP Debian 4.9.18-1 (2017-03-30) ppc 
> GNU/Linux

Follow-up: I updated to 4.9.0-3-powerpc-smp Debian kernel, which is 
4.9.25-1 (2017-05-02) and the fault is still the same.
Overnight I also compiled a vanilla 4.11.0 kernel using the Debian 
config as a starting point and "make olddefconfig" for a couple of new 
config options, booted it today and it gives the same messages.

This is 4.9.25-1 (Debian 4.9.0-3) smp kernel: https://pastebin.com/vq7XQ39U
NET: Registered protocol family 17
mpls_gso: MPLS GSO support
CPU features changed after feature patching!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at 
/build/linux-pGBmiG/linux-4.9.25/arch/powerpc/lib/feature-fixups.c:208 
check_features+0x38/0x7c
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-3-powerpc-smp #1 Debian 
4.9.25-1
task: df4aa9a0 task.stack: df4e8000
NIP: c07e3a00 LR: c07e3a00 CTR: 00000000
REGS: df4e9dd0 TRAP: 0700   Not tainted  (4.9.0-3-powerpc-smp Debian 
4.9.25-1)
MSR: 00029032 <EE,ME,IR,DR,RI>
   CR: 28000422  XER: 00000000

GPR00: c07e3a00 df4e9e80 df4aa9a0 0000002c 00009032 0000010d ffffffff 
00000000
GPR08: 00000001 c0861064 c0861064 00000000 22000444 00000000 c00048b8 
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
c08d0000
GPR24: c07dbcec c08449b4 c07d3ab4 c0823434 00000000 c08d6610 c08d0000 
c0820000
NIP [c07e3a00] check_features+0x38/0x7c
LR [c07e3a00] check_features+0x38/0x7c
Call Trace:
[df4e9e80] [c07e3a00] check_features+0x38/0x7c (unreliable)
[df4e9e90] [c0004214] do_one_initcall+0x4c/0x188
[df4e9f00] [c07dc5c8] kernel_init_freeable+0x198/0x230
[df4e9f30] [c00048dc] kernel_init+0x24/0x128
[df4e9f40] [c0018080] ret_from_kernel_thread+0x5c/0x64
--- interrupt: 0 at   (null)
     LR =   (null)
Instruction dump:
bfc10008 90010014 3fc0c08d 811e6028 3fe0c082 80ff45c4 8108000c 7f883800
41be0014 3c60c072 3863cb38 4be574f5 <0fe00000> 815e6028 3bff45c4 813f0004
---[ end trace db276e67fcbb7c47 ]---
registered taskstats version 1
zswap: loaded using pool lzo/zbud
ima: No TPM chip found, activating TPM-bypass!


This is my vanilla 4.11.0 kernel (based on Debian kernel config): 
https://pastebin.com/n5nPMS9g
NET: Registered protocol family 17
mpls_gso: MPLS GSO support
CPU features changed after feature patching!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at arch/powerpc/lib/feature-fixups.c:209 
check_features+0x38/0x7c
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0 #1
task: df4da020 task.stack: df4dc000
NIP: c0822768 LR: c0822768 CTR: 00000000
REGS: df4ddde0 TRAP: 0700   Not tainted  (4.11.0)
MSR: 00029032 <EE,ME,IR,DR,RI>
   CR: 28301422  XER: 00000000

GPR00: c0822768 df4dde90 df4da020 0000002c 00001032 0000010e ffffffff 
1f2b3000
GPR08: 00001032 c08a2208 c08a2208 00000000 28301422 00000000 c0004880 
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
c0920000
GPR24: c081a9c8 c0883c2c c08129a0 c0863494 00000000 c091a670 c0920000 
c0860000
NIP [c0822768] check_features+0x38/0x7c
LR [c0822768] check_features+0x38/0x7c
Call Trace:
[df4dde90] [c0822768] check_features+0x38/0x7c (unreliable)
[df4ddea0] [c00041ec] do_one_initcall+0x4c/0x178
[df4ddf00] [c081b2b4] kernel_init_freeable+0x1a0/0x238
[df4ddf30] [c00048a4] kernel_init+0x24/0x120
[df4ddf40] [c0018900] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
bfc10008 90010014 3fc0c092 811ea028 3fe0c086 80ff4624 8108000c 7f883800
41be0014 3c60c076 3863d154 4be44e45 <0fe00000> 815ea028 3bff4624 813f0004
---[ end trace c67815660f5f31c3 ]---
registered taskstats version 1
zswap: loaded using pool lzo/zbud
ima: No TPM chip found, activating TPM-bypass! (rc=-19)
