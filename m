Return-Path: <linuxppc-dev+bounces-24864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B9C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7ts50LY3z2yhD;
	Mon, 27 Jul 2026 19:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785145288;
	cv=none; b=lSA6rFGizXihMMzdejGUIkfhTWpcIFR9ooTjv13Bhga9tSCRJZwtVKVGZGFisWAHHZfbbBJiyuq+DhBd+VjTpDOeU893swGF5F7+4whwUv66tAPah8nnZWBFId270P/GrLmjiEDb0C4xvB1f5IdZ9hQh+O5XDjmpE6+Ovmzbek4AZe+LK1bBUmMqR3m5AvGninnVPvl0s8uolk1V5okPLQngEBhRELAK+BiSp94FIQYmgFBQSWF2NLXJetPPqYyi4Vg3uSpBschNwqkYcD4svwt18uY2JwCxbiCmxrSmNf4CdatVgUt7ZRpY2jtg/rZuLM/Ok2WNjh6E1YKXTX31Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785145288; c=relaxed/relaxed;
	bh=cYoSUDC9Z79wzPbTityug0y1kMhyF/HQ67c66LqFjnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfiwQoNjgekaaNdCnEu6wsqIs/AcSToi0c4O2iUR94app5ZKlZRjLaVPxXa25ZjbF9vg+OWy6opE9tVuOg4mJGlMrB+413dRfI69cySNHkAJU6N21zvIQQLnRep4SbxynW/BxuJw9mXsDSB/FXXf6pRc/uCZzPOTm7sL9M3KGejz4G/L33EYBkTYo7Y3uLZ6ciJ1GZfHpHoUI4J8qnL1y8wVB3zDJmY+XMBDhjZCquwWYwEjbB63irI7YCILcTCeJBNrCcufpLMtK6qCrxDiLcL+9FRJG4wEkbe2HXBWekx4X9dt1c1tV9Df5OLhZK5qM+GzIoisEZIiE1LoZDwhsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HpJdfZcD; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HpJdfZcD; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HpJdfZcD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HpJdfZcD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7ts33FCGz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:41:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785145282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYoSUDC9Z79wzPbTityug0y1kMhyF/HQ67c66LqFjnw=;
	b=HpJdfZcDTDDQOcQGtrf6par4vR4raqKLheIQbaEbOOxm3FkUidWIcaTuIpu2zFtCtigM96
	kw7lkzYvtXrzR0cPg+Dx/3j1srHbBGWXKLJNArELe6qTP+olV6MLTMQHd5/qlW6rYIbC8q
	jqsir52zjDWitGtxbk0t8iu8HNtQTb4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785145282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYoSUDC9Z79wzPbTityug0y1kMhyF/HQ67c66LqFjnw=;
	b=HpJdfZcDTDDQOcQGtrf6par4vR4raqKLheIQbaEbOOxm3FkUidWIcaTuIpu2zFtCtigM96
	kw7lkzYvtXrzR0cPg+Dx/3j1srHbBGWXKLJNArELe6qTP+olV6MLTMQHd5/qlW6rYIbC8q
	jqsir52zjDWitGtxbk0t8iu8HNtQTb4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-olJQlDApMLaDNxR7mSMnww-1; Mon, 27 Jul 2026 05:41:20 -0400
X-MC-Unique: olJQlDApMLaDNxR7mSMnww-1
X-Mimecast-MFC-AGG-ID: olJQlDApMLaDNxR7mSMnww_1785145280
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c0fb008616so2473414e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 02:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145280; x=1785750080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYoSUDC9Z79wzPbTityug0y1kMhyF/HQ67c66LqFjnw=;
        b=OskMkQdJ+deiaFERrmbbTxJcLJMKbejIgVDIurr/SwjuwuUdhLs2cROWo25c+mdXR/
         foSUw+IQA3Mhi33ySWKoSiS5Kj9Gbwrs+lbcB0an1MqG6RK+3GrYimv9evb1AxkP034r
         zw5+siwrkhW+ps3q8aiJh1CRAhr5TiyrSeXEAIIeEb4DKimHDi7W9LLvsQNnTy2lZtQ1
         CNndTlKsbm7Fq+5/IHxSvZemHh2pe5Ld10IFxIcAEQ1knnBRAjIi9hSGPAkLJz6O8+nl
         CD4ewl9CBd5YOqqvRCmoNrNb2zzGwuv+Jmn/S4DMs78GR7Kn0acq4id1e5BqVpSvxAoo
         cDMA==
X-Forwarded-Encrypted: i=1; AHgh+RqaBOiLYNY6IbwM9ZDaoEwpEh2wr7LjbScn1DVVehyoSJXsE6ZJUtFawwZlAvcxtpVBk3jFkRTtuMI/etQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxka+hvYf4Zs6TsczkUvOX0vbGaHpU4Ha2lfrItes6xwwBoTvvZ
	IhGGbejUZssBf3hBuM2aiacXL4dO+oxIk+Dw0C4kL1tV70ZF5VEBXGn9FTRS7RBWenxBE6Xw78Y
	jbLiCbduG9U2OGNb8hpM1MZxynm5yH06mx3i9oMYu8Nm9xDfXNXxKzfuSe8EFeM5HvlhSjXEI9H
	zsvAGQvExRvNL7uzCUewEd9YbsDfm1FdrN708mPskkTw==
X-Gm-Gg: AR+sD11lNX5rBQOxb6ka1exfHsB+JDXADmtzHnXYgvrH4sTJYpixBgzxuUSmAWzyw3/
	CMR9HXC8T5hdwxVxuO2kp+l+ZUZJWOOJHlKyeKH4kNmYnbktbXPn6sRRiFkN5KjiX//pHILVZo4
	OOtwdill4u1J/7yV89Kl1H9K+x6rv5P9Nfs8ncnHk+s6y2ENzpRt+gsZ4=
X-Received: by 2002:a05:6122:d92:b0:5c2:ae1f:bd0c with SMTP id 71dfb90a1353d-5c2fc87c81cmr5481054e0c.7.1785145280253;
        Mon, 27 Jul 2026 02:41:20 -0700 (PDT)
X-Received: by 2002:a05:6122:d92:b0:5c2:ae1f:bd0c with SMTP id
 71dfb90a1353d-5c2fc87c81cmr5481019e0c.7.1785145279781; Mon, 27 Jul 2026
 02:41:19 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260427122742.210074-1-mkchauras@gmail.com>
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Mon, 27 Jul 2026 11:41:07 +0200
X-Gm-Features: AUfX_mxH2zssgiq0u-883ROpy9H6J10DvDLgKznDdMqbAqoW16kNL0m7QrirPN4
Message-ID: <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, 
	ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, 
	ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com, 
	segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com, 
	pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org, 
	kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L1GateCBYtGtuIupUUHxa69gcKHWJc-DwQfzsCqaAxg_1785145280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mukesh, Shrikanth, Madhavan,

I'm seeing a ~19% throughput regression on ppc64le (POWER10) in
syscall-heavy workloads between kernel 7.1 and 7.2-rc4, which I've
narrowed down to the GENERIC_ENTRY enablement for powerpc (commit
bee25f97ad24 "powerpc: Enable GENERIC_ENTRY feature").

The regression manifests specifically when SELinux is enabled. Regression
disappears with selinux=3D0. With SELinux disabled, 7.2 is actually
slightly *faster* than 7.1.

Test: stress-ng --kill 1 -t 23 (single-thread kill() syscall loop)
Machine: IBM,9080-HEX POWER10, 8 vCPUs (1 core SMT-8), 64 GiB

Results (bogo-ops/sec, higher is better):

Kernel   Enforcing   Permissive   Disabled    SELinux tax
------   ---------   ----------   --------    -----------
7.1      69,107      70,248       93,566      -26.1%
7.2-rc4  56,247      59,075       99,240      -43.3%
Delta    -18.6%      -15.9%       +6.1%

Key observations:
- SELinux permissive ~ enforcing on both kernels (overhead is in the
  code path, not policy evaluation)
- SELinux disabled: 7.2 is 6% faster than 7.1 -- the generic entry
  path itself is not slower for the base syscall
- The SELinux "tax" nearly doubles from 26% to 43% between 7.1->7.2
- No changes to security/selinux/avc.c between v7.1 and v7.2-rc4

The kill() hot path (sys_kill -> check_kill_permission -> security_task_kil=
l
-> selinux_task_kill -> avc_has_perm -> avc_lookup) wraps every AVC lookup
in rcu_read_lock()/rcu_read_unlock(). On ppc64le with PREEMPT_RCU, each
pair requires lwsync/isync barriers. I suspect the generic entry path
changes something in how context tracking, tracing, or RCU interacts
with the syscall fast path that amplifies the per-call RCU cost.

Note: this is on top of a separate ~36% regression from 6.12->7.1 caused
by HAVE_PREEMPT_DYNAMIC_KEY enabling CONFIG_PREEMPT_RCU on ppc64le
(commit 6ad7751537e8), which I reported separately on the v4 thread.

Thank you
Jirka

On Mon, Apr 27, 2026 at 2:33=E2=80=AFPM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> Adding support for the generic irq entry/exit handling for PowerPC. The
> goal is to bring PowerPC in line with other architectures that already
> use the common irq entry infrastructure, reducing duplicated code and
> making it easier to share future changes in entry/exit paths.
>
> This is slightly tested of ppc64le and ppc32.
>
> The performance benchmarks are below:
>
> perf bench syscall usec/op (-ve is improvement)
>
> | Syscall | Base        | test        | change % |
> | ------- | ----------- | ----------- | -------- |
> | basic   | 0.093543    | 0.093023    | -0.56    |
> | execve  | 446.557781  | 450.107172  | +0.79    |
> | fork    | 1142.204391 | 1156.377214 | +1.24    |
> | getpgid | 0.097666    | 0.092677    | -5.11    |
>
> perf bench syscall ops/sec (+ve is improvement)
>
> | Syscall | Base     | New      | change % |
> | ------- | -------- | -------- | -------- |
> | basic   | 10690548 | 10750140 | +0.56    |
> | execve  | 2239     | 2221     | -0.80    |
> | fork    | 875      | 864      | -1.26    |
> | getpgid | 10239026 | 10790324 | +5.38    |
>
>
> IPI latency benchmark (-ve is improvement)
>
> | Metric         | Base (ns)     | New (ns)      | % Change |
> | -------------- | ------------- | ------------- | -------- |
> | Dry run        | 583136.56     | 584136.35     | 0.17%    |
> | Self IPI       | 4167393.42    | 4149093.90    | -0.44%   |
> | Normal IPI     | 61769347.82   | 61753728.39   | -0.03%   |
> | Broadcast IPI  | 2235584825.02 | 2227521401.45 | -0.36%   |
> | Broadcast lock | 2164964433.31 | 2125658641.76 | -1.82%   |
>
>
> Thats very close to performance earlier with arch specific handling.
>
> Tests done:
>  - Build and boot on ppc64le pseries.
>  - Build and boot on ppc64le powernv8 powernv9 powernv10.
>  - Build and boot on ppc32.
>  - Performance benchmark done with perf syscall basic on pseries.
>
> Changelog:
> V4 -> V5:
>  - Rebased on latest mainline
> V4: https://lore.kernel.org/all/20260123073916.956498-1-mkchauras@linux.i=
bm.com/
>
> V3 -> V4:
>  - Fixed the issue in older gcc version where linker couldn't find
>    mem functions
>  - Merged IRQ enable and syscall enable into a single patch
>  - Cleanup for unused functions done in separate patch.
>  - Some other cosmetic changes
> V3: https://lore.kernel.org/all/20251229045416.3193779-1-mkchauras@linux.=
ibm.com/
>
> V2 -> V3:
>  - #ifdef CONFIG_GENERIC_IRQ_ENTRY removed from unnecessary places
>  - Some functions made __always_inline
>  - pt_regs padding changed to match 16byte interrupt stack alignment
>  - And some cosmetic changes from reviews from earlier patch
> V2: https://lore.kernel.org/all/20251214130245.43664-1-mkchauras@linux.ib=
m.com/
>
> V1 -> V2:
>  - Fix an issue where context tracking was showing warnings for
>    incorrect context
> V1: https://lore.kernel.org/all/20251102115358.1744304-1-mkchauras@linux.=
ibm.com/
>
> RFC -> PATCH V1:
>  - Fix for ppc32 spitting out kuap lock warnings.
>  - ppc64le powernv8 crash fix.
>  - Review comments incorporated from previous RFC.
> RFC https://lore.kernel.org/all/20250908210235.137300-2-mchauras@linux.ib=
m.com/
>
> Mukesh Kumar Chaurasiya (8):
>   powerpc: rename arch_irq_disabled_regs
>   powerpc: Prepare to build with generic entry/exit framework
>   powerpc: introduce arch_enter_from_user_mode
>   powerpc: Introduce syscall exit arch functions
>   powerpc: add exit_flags field in pt_regs
>   powerpc: Prepare for IRQ entry exit
>   powerpc: Enable GENERIC_ENTRY feature
>   powerpc: Remove unused functions
>
>  arch/powerpc/Kconfig                    |   1 +
>  arch/powerpc/include/asm/entry-common.h | 533 ++++++++++++++++++++++++
>  arch/powerpc/include/asm/hw_irq.h       |   4 +-
>  arch/powerpc/include/asm/interrupt.h    | 386 +++--------------
>  arch/powerpc/include/asm/kasan.h        |  15 +-
>  arch/powerpc/include/asm/ptrace.h       |   6 +-
>  arch/powerpc/include/asm/signal.h       |   1 -
>  arch/powerpc/include/asm/stacktrace.h   |   6 +
>  arch/powerpc/include/asm/syscall.h      |   5 +
>  arch/powerpc/include/asm/thread_info.h  |   1 +
>  arch/powerpc/include/uapi/asm/ptrace.h  |  14 +-
>  arch/powerpc/kernel/interrupt.c         | 254 ++---------
>  arch/powerpc/kernel/ptrace/ptrace.c     | 142 +------
>  arch/powerpc/kernel/signal.c            |  25 +-
>  arch/powerpc/kernel/syscall.c           | 119 +-----
>  arch/powerpc/kernel/traps.c             |   2 +-
>  arch/powerpc/kernel/watchdog.c          |   2 +-
>  arch/powerpc/perf/core-book3s.c         |   2 +-
>  18 files changed, 690 insertions(+), 828 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/entry-common.h
>
> --
> 2.53.0
>
>


--=20
-Jirka


