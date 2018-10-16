Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B0C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77FF20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77FF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZGY46JnmzF3JZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:36:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZGDc2m1fzF3Wl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:21:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42ZGDc1KTKz9sBj; Wed, 17 Oct 2018 00:21:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ZGDb6bH6z9sB5;
 Wed, 17 Oct 2018 00:21:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 "linuxppc-dev\@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: Stack protector crash in pnv_smp_cpu_kill_self()
In-Reply-To: <a23f6298-f860-190c-4b45-333198fdc160@c-s.fr>
References: <87k1mjz6hd.fsf@concordia.ellerman.id.au>
 <a23f6298-f860-190c-4b45-333198fdc160@c-s.fr>
Date: Wed, 17 Oct 2018 00:21:50 +1100
Message-ID: <87ftx6kowh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Gautham R Shenoy <ego@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Looks like a lack of initialisation of the canary for the non-boot CPUs=20
> on SMP, you applied this morning the patch I sent you for that.
>
> Is the patch in ?

Yeah it is.

  $ git log --oneline 4ffe713b7587 arch/powerpc/kernel/smp.c
  8e8a31d7fd54 powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigc=
ores
  425752c63b6f powerpc: Detect the presence of big-cores via "ibm, thread-g=
roups"
  7241d26e8175 powerpc/64: properly initialise the stackprotector canary on=
 SMP.


It only happens on a specific Power9 machine, not in sim, but it's 100%
reproducible on that hardware.

The canary value has changed (?!).

The value in paca->canary and current->canary agree, but they don't
match what's in the stack.

Clearly the idle code is doing something I don't understand :)

cheers


Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: =
pnv_smp_cpu_kill_self+0x2a0/0x2b0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00190-g98c84=
7323b3a-dirty #103
Call Trace:
[c000000007967b00] [c000000000ae864c] dump_stack+0xb0/0xf4 (unreliable)
[c000000007967b40] [c0000000000e64ac] panic+0x144/0x328
[c000000007967be0] [c0000000000e5f2c] __stack_chk_fail+0x2c/0x30
[c000000007967c40] [c00000000009f720] pnv_smp_cpu_kill_self+0x2a0/0x2b0
[c000000007967e10] [c0000000000475d8] cpu_die+0x48/0x70
[c000000007967e30] [c000000000020620] arch_cpu_idle_dead+0x20/0x40
[c000000007967e50] [c00000000012e574] do_idle+0x274/0x390
[c000000007967ec0] [c00000000012e8e8] cpu_startup_entry+0x38/0x50
[c000000007967ef0] [c000000000047314] start_secondary+0x5e4/0x600
[c000000007967f90] [c00000000000ac70] start_secondary_prolog+0x10/0x14


c00000000009f480 <pnv_smp_cpu_kill_self>:
c00000000009f480:       f9 00 4c 3c     addis   r2,r12,249
c00000000009f484:       80 77 42 38     addi    r2,r2,30592
c00000000009f488:       a6 02 08 7c     mflr    r0
c00000000009f48c:       2d 48 fc 4b     bl      c000000000063cb8 <_mcount>
c00000000009f490:       a6 02 08 7c     mflr    r0
c00000000009f494:       c0 ff 01 fb     std     r24,-64(r1)
c00000000009f498:       c8 ff 21 fb     std     r25,-56(r1)
c00000000009f49c:       d0 ff 41 fb     std     r26,-48(r1)
c00000000009f4a0:       d8 ff 61 fb     std     r27,-40(r1)
c00000000009f4a4:       e0 ff 81 fb     std     r28,-32(r1)
c00000000009f4a8:       e8 ff a1 fb     std     r29,-24(r1)
c00000000009f4ac:       f0 ff c1 fb     std     r30,-16(r1)
c00000000009f4b0:       f8 ff e1 fb     std     r31,-8(r1)
c00000000009f4b4:       10 00 01 f8     std     r0,16(r1)
c00000000009f4b8:       31 fe 21 f8     stdu    r1,-464(r1)	-> c00000000796=
7e10 - 464 =3D c000000007967c40=20
c00000000009f4bc:       e8 0c 2d e9     ld      r9,3304(r13)
c00000000009f4c0:       88 01 21 f9     std     r9,392(r1)	c000000007967c40=
 + 392 =3D c000000007967dc8

paca->canary                    =3D 31fc80016f07fb00	(0xce8)

current->canary =3D
1:mon> d8 c0000000077ef150
c0000000077ef150 31fc80016f07fb00 c000200006600080

1:mon> d8 %r1
c000000007967a90 c000000007967af0 0000000000000001
c000000007967aa0 c0000000000c2c00 c000000001036c00
c000000007967ab0 fffffffffffffffe c0000000010ff9b0
c000000007967ac0 c0000000010ff9b0 ffffffffffffffff
1:mon>=20
c000000007967ad0 0000000000000000 0000000000000000
c000000007967ae0 c000000000f05330 c0000000000c2bd0
c000000007967af0 c000000007967b40 31fc80016f07fb00
                                  ^^^^^^^^^^^^^^^^

pnv_smp_cpu_kill_self frame:
1:mon> d8 c000000007967c40
c000000007967c40 c000000007967e10 0000000000063fec
c000000007967c50 c00000000009f720 f6251c2ce0f21b00
c000000007967c60 c000001fec9f0280 c000000007bc3680
c000000007967c70 c000000007967ca0 c0000000077eeb80
c000000007967c80 c00000000012de20 c00000000001ee7c
c000000007967c90 c000000007967cb0 c000000000ef2b80
c000000007967ca0 c000000007967d50 0000000000000001
c000000007967cb0 c000000007967d90 0000000024028222
c000000007967cc0 c00000000017b0a0 0000000000000001
c000000007967cd0 c000000007967d50 0000000000000001
c000000007967ce0 c000000007967d20 c000000001036c00
c000000007967cf0 c000000007967d30 c000001ffe84d980
c000000007967d00 c00000000001ee7c 0000001ffd970000
c000000007967d10 c000000007967d30 c000001ffe862b80
c000000007967d20 0000000000000000 c000000000044c50
c000000007967d30 c000001ffe8451e0 c000000007bc3680
c000000007967d40 c000000007967d60 0000000000000000
c000000007967d50 c000000007967d90 c000000001036c00
c000000007967d60 c000000007967d90 c000000000f3bc80
c000000007967d70 c0000000001ae0f8 c000000000f12880
c000000007967d80 0000001ffd970000 c000000007967dc0
c000000007967d90 c000000007967e10 0000000000000004
c000000007967da0 c0000000001ae2b8 c000001ffe84e050
c000000007967db0 c000000007967e50 c000000001070174
c000000007967dc0 0000000000000000 f6251c2ce0f21b00
                                  ^^^^^^^^^^^^^^^^
				  canary

c000000007967dd0 0000000000000000 0000000000000004
c000000007967de0 0000000000080000 0000000000000002
c000000007967df0 c0000000010700b8 0000000000000001
c000000007967e00 0000000000000002 c00000000106fc58

cpu_die frame:
c000000007967e10 c000000007967e30 c000001ffe84e050
c000000007967e20 c0000000000475d8 c000000001036c00
c000000007967e30 c000000007967e50 0000000000000001
c000000007967e40 c000000000020620 c00000000106fc58
c000000007967e50 c000000007967ec0 c000000000004000
c000000007967e60 c00000000012e574 0000000000004000
c000000007967e70 010000000014c0d4 f6251c2ce0f21b00
                                  ^^^^^^^^^^^^^^^^
				  canary


> Le 15/10/2018 =C3=A0 15:26, Michael Ellerman a =C3=A9crit=C2=A0:
>> Hi all,
>>=20
>> Spotted this today, haven't had time to debug it further, just FYI in
>> case anyone else sees it.
>>=20
>>    Running tests in cpufreq
>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>    selftests: cpufreq: main.sh
>>    pid 9727's current affinity mask: fffffffffffffffffffffffffffffffffff=
fffffffff
>>    pid 9727's new affinity mask: 1
>>    Kernel panic - not syncing: stack-protector: Kernel stack is corrupte=
d in: pnv_smp_cpu_kill_self+0x2a0/0x2b0
>>=20=20=20=20
>>    CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00168-=
g4ffe713b7587 #94
>>    Call Trace:
>>    [c000000007a1fb00] [c000000000ae7b4c] dump_stack+0xb0/0xf4 (unreliabl=
e)
>>    [c000000007a1fb40] [c0000000000e59cc] panic+0x144/0x328
>>    [c000000007a1fbe0] [c0000000000e544c] __stack_chk_fail+0x2c/0x30
>>    [c000000007a1fc40] [c00000000009eca0] pnv_smp_cpu_kill_self+0x2a0/0x2=
b0
>>    [c000000007a1fe10] [c0000000000475f8] cpu_die+0x48/0x70
>>    [c000000007a1fe30] [c000000000020620] arch_cpu_idle_dead+0x20/0x40
>>    [c000000007a1fe50] [c00000000012da94] do_idle+0x274/0x390
>>    [c000000007a1fec0] [c00000000012de08] cpu_startup_entry+0x38/0x50
>>    [c000000007a1fef0] [c000000000047334] start_secondary+0x5e4/0x600
>>    [c000000007a1ff90] [c00000000000ac70] start_secondary_prolog+0x10/0x14
>>    Rebooting in 10 seconds..
>>    [39378.502863506,5] OPAL: Reboot request
>>=20
>>=20
>>=20
>> cheers
>>=20
