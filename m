Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BBC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 12:11:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACBA20652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 12:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahyfTx2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACBA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gcF1342vzDqVK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 22:11:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ahyfTx2q"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gcBk3TMDzDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 22:09:17 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id h5so5085651pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=FBMgiErZyB4f1kzCu8K9rdXtC4LQafqgTUgU60cxZFs=;
 b=ahyfTx2qWsm+w62+ePpY+88Padx0K4jIYo2qClaRCV+oPcsV2EKF5m/zZcie2fOGfx
 Bs7sNWM8J+zfKwx72dZhwGAodq0RmsYGWurxdfn1MoHSnkmijaNiOYdA87p9myMg4S0/
 Qr9IdOkJIVwPtHniBDEBYLA/DJ5ZL7gfYySmeBSNVu/p6Gz97ARbxysR5vxyxwgWR3rK
 wjXOpWLyHDIXtCVLwEL9Zq5deIioYhEiJp3WY5BVfafYKWWKTLvgjxlEbCdcZP0S1Ono
 w9KWqpuu5wmoP2estDGJqwDXvvVhzTBGbGJZpXABZ90wVgnOW3wHu3+qwqDSz6KQk15l
 QBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=FBMgiErZyB4f1kzCu8K9rdXtC4LQafqgTUgU60cxZFs=;
 b=d4JhDXEYJPMGFtOihySFxBGVNdyYpmFj/YjWdzj0N0airQkhOWgPBIcBmcwibEkuW+
 pbtWyogRsjQWcxipLjypgEqTJmhDgedcsLhGtwpBrULOmKa/SOk6Qs6OrOvi1U3XzmwV
 ecQdxTms17bTWMk5OTgmnyeE4DZtyJ03VI9h9y9WzHvE8St3tSu4J+GLKlnARv8SWpHO
 KfQoAqBh54acLiQSNJD0HwBYuQnVFhtM4pVPCVlWIgJ+oCBP56Nj5tahXB/Bc0lfA4Tj
 e440Z3FfyInZGPL1ugkgQAuy9VHVYb2UjLwkut84wfzbyUdLEDVSKr+aheKcOpDVvtJd
 IYbQ==
X-Gm-Message-State: APjAAAWZsl7kIm3Aqv0pW6ljosCD2A5zlK2B1A3vK9vKr/LRTRcpMF0J
 60cCk0bWyIL4raL6eHQyVI8=
X-Google-Smtp-Source: APXvYqySWNzjyvVCNNUOavZ3I9Csw73H6fpJ6p/EFchONsdxx9yc0zhdNItLbMj5H+V064l6nUpxBg==
X-Received: by 2002:a63:1912:: with SMTP id z18mr53533660pgl.115.1555070954402; 
 Fri, 12 Apr 2019 05:09:14 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
 by smtp.gmail.com with ESMTPSA id u5sm20224843pfa.169.2019.04.12.05.09.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Apr 2019 05:09:13 -0700 (PDT)
Date: Fri, 12 Apr 2019 22:09:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 1/2] powerpc/64s: reimplement book3s idle code in C
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
References: <20190408063431.23948-1-npiggin@gmail.com>
 <20190408073251.GA22000@sathnaga86.in.ibm.com>
In-Reply-To: <20190408073251.GA22000@sathnaga86.in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555070681.0mx84q05j4.astroid@bobo.none>
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Satheesh Rajendran's on April 8, 2019 5:32 pm:
> Hi,
>=20
> Hit with below kernel crash during Power8 Host boot with this patch serie=
s on top
> of powerpc merge branch commit https://git.kernel.org/pub/scm/linux/kerne=
l/git/powerpc/linux.git/commit/?h=3Dmerge&id=3D6a821ffee18a6e6c0027c523fa8c=
958df98ca361
>=20
> built with ppc64le_defconfig
>=20
> Host Console log:
> [    0.454666] EEH: PCI Enhanced I/O Error Handling Enabled
> [    0.456524] create_dump_obj: New platform dump. ID =3D 0x4 Size 745796=
8
> [    0.457627] opal-power: OPAL EPOW, DPO support detected.
> [    0.457722] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.457733] Faulting instruction address: 0xc00000000001a94c
> [    0.457740] Oops: Kernel access of bad area, sig: 11 [#1]
> [    0.457745] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA Powe=
rNV
> [    0.457750] Modules linked in:
> [    0.457756] CPU: 58 PID: 0 Comm: swapper/58 Not tainted 5.1.0-rc2-gd0a=
e6c548 #1
> [    0.457762] NIP:  c00000000001a94c LR: c0000000000a6e9c CTR: c00000000=
0008000
> [    0.457768] REGS: c000000f272b7b50 TRAP: 0380   Not tainted  (5.1.0-rc=
2-gd0ae6c548)
> [    0.457773] MSR:  9000000000001033 <SF,HV,ME,IR,DR,RI,LE>  CR: 2400422=
2  XER: 00000000
> [    0.457781] CFAR: c0000000000a6e98 IRQMASK: 1=20
> [    0.457781] GPR00: c0000000000a6e9c c000000f272b7de0 0000000000000004 =
0000000000000006=20
> [    0.457781] GPR04: c0000000000a5dd4 0000000024004222 c000000f272b7d48 =
0000000000000001=20
> [    0.457781] GPR08: 0000000000000002 ffffffffff761844 c000000f27250c00 =
0000c3feb1676be1=20
> [    0.457781] GPR12: 0000000000004400 c000000ffff9d380 c000000ffe60ff90 =
0000000000000000=20
> [    0.457781] GPR16: 0000000000000000 0000000000000000 c00000000004b4d0 =
c00000000004b4a0=20
> [    0.457781] GPR20: c000000001526214 0000000000000800 0000000000000001 =
c000000001521b78=20
> [    0.457781] GPR24: 000000000000003a 0000000000000000 0000000000080000 =
0000000000000000=20
> [    0.457781] GPR28: c000000001526140 0000000000000001 0400000000000000 =
c000000001525ce0=20
> [    0.457829] NIP [c00000000001a94c] irq_set_pending_from_srr1+0x1c/0x50
> [    0.457835] LR [c0000000000a6e9c] power7_idle+0x3c/0x50
> [    0.457839] Call Trace:
> [    0.457843] [c000000f272b7de0] [c0000000000a6e98] power7_idle+0x38/0x5=
0 (unreliable)
> [    0.457849] [c000000f272b7e00] [c0000000000210f4] arch_cpu_idle+0x54/0=
x160
> [    0.457856] [c000000f272b7e30] [c000000000c47bc4] default_idle_call+0x=
74/0x88
> [    0.457862] [c000000f272b7e50] [c000000000158f54] do_idle+0x2f4/0x3d0
> [    0.457868] [c000000f272b7ec0] [c000000000159288] cpu_startup_entry+0x=
38/0x40
> [    0.457874] [c000000f272b7ef0] [c00000000004dae4] start_secondary+0x65=
4/0x680
> [    0.457881] [c000000f272b7f90] [c00000000000b25c] start_secondary_prol=
og+0x10/0x14
> [    0.457886] Instruction dump:
> [    0.457890] 992d098b 7c630034 5463d97e 4e800020 60000000 3c4c014d 3842=
4dd0 7c0802a6=20
> [    0.457898] 60000000 3d22ff76 78637722 39291840=20
> [    0.457900] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.457901] <7d4918ae> 2b8a00ff 419e001c 892d098b=20
> [    0.457907] Faulting instruction address: 0xc00000000001a94c
> [    0.457910] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.457915] ---[ end trace fa7343cfd21c8798 ]---
> [    0.457919] Faulting instruction address: 0xc00000000001a94c
> [    0.458961] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.458963] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.458964] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.458966] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.458968] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.458970] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.458972] Faulting instruction address: 0xc00000000001a94c
> [    0.458973] Faulting instruction address: 0xc00000000001a94c
> [    0.458974] Faulting instruction address: 0xc00000000001a94c
> [    0.458975] Faulting instruction address: 0xc00000000001a94c
> [    0.458976] Faulting instruction address: 0xc00000000001a94c
> [    0.458978] initcall __machine_initcall_powernv_pnv_init_idle_states+0=
x0/0xb30 returned 0 after 0 usecs
> [    0.458981] calling  __machine_initcall_powernv_opal_time_init+0x0/0x1=
50 @ 1
> [    0.458982] Faulting instruction address: 0xc00000000001a94c
> [    0.459022] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.459040] Faulting instruction address: 0xc00000000001a94c
> [    0.459043] initcall __machine_initcall_powernv_opal_time_init+0x0/0x1=
50 returned 0 after 0 usecs
> [    0.459044] BUG: Unable to handle kernel data access at 0xffffffffff76=
184c
> [    0.459045] Faulting instruction address: 0xc00000000001a94c
> [    0.459060] calling  __machine_initcall_powernv_rng_init+0x0/0x334 @ 1
> [    0.459084] powernv-rng: Registering arch random hook.
> [    0.459141] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.459147] Faulting instruction address: 0xc00000000001a94c
> [    0.459191] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.459199] Faulting instruction address: 0xc00000000001a94c
> [    0.459216] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.459224] Faulting instruction address: 0xc00000000001a94c
> [    0.459228] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.459234] Faulting instruction address: 0xc00000000001a94c
> [    0.459268] BUG: Unable to handle kernel data access at 0xffffffffff76=
184a
> [    0.459275] Faulting instruction address: 0xc00000000001a94c
> [    0.459375]=20
> [    0.459380] Oops: Kernel access of bad area, sig: 11 [#2]
> [    0.459385] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA Powe=
rNV
> [    0.459390] Modules linked in:
> [    0.459395] CPU: 63 PID: 0 Comm: swapper/63 Tainted: G      D         =
  5.1.0-rc2-gd0ae6c548 #1
> [    0.459401] NIP:  c00000000001a94c LR: c0000000000a6e9c CTR: c00000000=
0008000
> [    0.459407] REGS: c000000f272a3b50 TRAP: 0380   Tainted: G      D     =
       (5.1.0-rc2-gd0ae6c548)
> [    0.459414] MSR:  9000000000001033 <SF,HV,ME,IR,DR,RI,LE>  CR: 2400422=
2  XER: 00000000
> [    0.459419] BUG: Unable to handle kernel data access at 0xffffffffff76=
184c
> [    0.459422] CFAR: c0000000000a6e98 IRQMASK: 1=20
> [    0.459422] GPR00: c0000000000a6e9c c000000f272a3de0 0000000000000004 =
0000000000000006=20
> [    0.459422] GPR04: c0000000000a5dd4 0000000024004222 c000000f272a3d48 =
0000000000000001=20
> [    0.459422] GPR08: 0000000000000007 ffffffffff761844 c000000f27244e00 =
0000c3feb18a5128=20
> [    0.459422] GPR12: 0000000000004400 c000000ffff99080 c000000ffe623f90 =
0000000000000000=20
> [    0.459422] GPR16: 0000000000000000 0000000000000000 c00000000004b4d0 =
c00000000004b4a0=20
> [    0.459422] GPR20: c000000001526214 0000000000000800 0000000000000001 =
c000000001521b78=20
> [    0.459422] GPR24: 000000000000003f 0000000000000000 0000000000080000 =
0000000000000000=20
> [    0.459422] GPR28: c000000001526140 0000000000000001 8000000000000000 =
c000000001525ce0=20
> [    0.459443] NIP [c00000000001a94c] irq_set_pending_from_srr1+0x1c/0x50
> [    0.459449] Faulting instruction address: 0xc00000000001a94c
> [    0.459483] LR [c0000000000a6e9c] power7_idle+0x3c/0x50
> [    0.459485] Call Trace:
> [    0.459490] initcall __machine_initcall_powernv_rng_init+0x0/0x334 ret=
urned 0 after 0 usecs
> [    0.459493] calling  __machine_initcall_pseries_init_ras_IRQ+0x0/0xf4 =
@ 1
> [    0.459497] [c000000f272a3de0] [c0000000000a6e98] power7_idle+0x38/0x5=
0 (unreliable)
> [    0.459500] [c000000f272a3e00] [c0000000000210f4] arch_cpu_idle+0x54/0=
x160
> [    0.459503] [c000000f272a3e30] [c000000000c47bc4] default_idle_call+0x=
74/0x88
> [    0.459507] initcall __machine_initcall_pseries_init_ras_IRQ+0x0/0xf4 =
returned 0 after 0 usecs
> [    0.459510] calling  __machine_initcall_pseries_rng_init+0x0/0xa4 @ 1
> [    0.459514] [c000000f272a3e50] [c000000000158f54] do_idle+0x2f4/0x3d0
> [    0.459518] [c000000f272a3ec0] [c000000000159288] cpu_startup_entry+0x=
38/0x40
> [    0.459523] initcall __machine_initcall_pseries_rng_init+0x0/0xa4 retu=
rned 0 after 0 usecs
> [    0.459527] [c000000f272a3ef0] [c00000000004dae4] start_secondary+0x65=
4/0x680
> [    0.459531] [c000000f272a3f90] [c00000000000b25c] start_secondary_prol=
og+0x10/0x14
> [    0.459535] calling  __machine_initcall_pseries_ioei_init+0x0/0xd8 @ 1
> [    0.459539] Instruction dump:
> [    0.459542] 992d098b 7c630034 5463d97e 4e800020 60000000 3c4c014d 3842=
4dd0 7c0802a6=20
> [    0.459549] initcall __machine_initcall_pseries_ioei_init+0x0/0xd8 ret=
urned 0 after 0 usecs
> [    0.459553] 60000000 3d22ff76 78637722 39291840 <7d4918ae> 2b8a00ff 41=
9e001c 892d098b=20
> [    0.459559] calling  uid_cache_init+0x0/0x108 @ 1
> [    0.459564] ---[ end trace fa7343cfd21c8799 ]---
> [    0.459574] initcall uid_cache_init+0x0/0x108 returned 0 after 0 usecs
> [    0.459576] calling  param_sysfs_init+0x0/0x248 @ 1
>=20

This is the problem, the nap sequence does a dummy store to the stack
which clobbers our r2 save:

>> +#define IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
>> +	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
>> +	std	r0,0(r1);					\
>> +	ptesync;						\
>> +	ld	r0,0(r1);					\
>> +236:	cmpd	cr0,r0,r0;					\
>> +	bne	236b;						\
>> +	IDLE_INST;						\
>> +	b	.	/* catch bugs */

vs

>> +_GLOBAL(isa206_idle_insn_mayloss)
>> +	std	r1,PACAR1(r13)
>> +	mflr	r4
>> +	mfcr	r5
>> +	/* use stack red zone rather than a new frame for saving regs */
>> +	std	r2,-8*0(r1)

I'm not sure where I broke this, I may have been loading r2 from
PACATOC before.

Thanks,
Nick

=
