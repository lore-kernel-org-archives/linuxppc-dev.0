Return-Path: <linuxppc-dev+bounces-26572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EE3C79F82
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 20:34:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc7Tq75Y2z2yvs;
	Sat, 05 Sep 2026 06:33:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788554031;
	cv=none; b=dq4l/oOCW8Rj7lTFdK4bytHK7QQLS1AeYoYNqpsbeLOXlVN4bIyntfyO2LBSALYl5hQKUC7dgew48nMkfi826eQMbnrxPj6sIFXgeKe2rXoiYW6t/duGEjMeBBlCwM18ISNJgmxLSCAv9dO3a8ep72PAe5qDF9Ejt1m2JQt95NL3ym4idwIPAykB3kDWPRHz4OHjr0R2xq0wv4PV17R+XFjfPhAnBsp9qCc/3v1kCmK5iitWdVkKU+mPeaHej3TLNvu2TaiMD8beQI7/oiKSQhz5MtJKVnoVCRyBDAoM5yCeG3fnZlNx08e3xjJpYAiMiIEskPimG2ZetxSiZfqz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788554031; c=relaxed/relaxed;
	bh=vAH6Kx/+f1y/dA82fhj1/GE5vDzTAqE05dgfOpLPlKQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DV4W2Ye2/OWi30RoND8gSMFivAa1Oi9SeTx9ZiT/ZoemA2LlqkmzVzIh2vKt7EZdixGhoqXq5wTnEWO9GmuWxrFY+OwreEFEGDzy6xHWJT074Lx4h2TKVXqMrs44+FDXmKlNLmNAf9BO9Qo9LsaJQQNPxDiNr3taWZThyLfz0FJ6joYTWSNI1w4cUGZ68dHQilleQo2R9h5Ia3b18V2iDJrmO9Q1aemxNkJ7090DuP3R/uhir7V64xgTEGo+vXT74CNdcKVXFgoBU9UT+txywIZUpwIZHZcEragu7wJuZgtBAQ53wa12wHEiRIIRkJG6bkpOiet5sxIvpSjU7iN/jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOs13i6E; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOs13i6E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc7Tq0RvLz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 06:33:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4609740C04;
	Fri,  4 Sep 2026 20:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F161F00A3F;
	Fri,  4 Sep 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788554028;
	bh=vAH6Kx/+f1y/dA82fhj1/GE5vDzTAqE05dgfOpLPlKQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AOs13i6EDO2Fzu97k8IOOEWHKjMF7tiKJZrWtE9Hqu/jrpY7Gigs3l2rjFc3oVQCE
	 vgthG19FvLLx7MtgPkQWNBNnXWb1qZNe+M0kvxfs9hB6Zl1irBKK/UUaUg4UE1iOPy
	 hZDbstFUbxL2so8v8NdxI8o5uJ5gMzYOcT38qEIrolAYlyQM9BQH8coVigkKMRNi+9
	 EVQfI7vh5UhjEssJjkYKyeGzL8pjEvvawojOWZX+H2CMK7pZEtTxvmUqCwRA4ywMP0
	 RiAjlKNc+SFMMJQumREkewHyc6t7tcYW/GvgiaIJxdUIcLhxaTjkZGyXn96ZlYDFg4
	 /GBn9ndzSQYhQ==
Content-Type: multipart/mixed; boundary="===============1590814207464027886=="
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
Message-Id: <f57cf431f791ef17d4e2d70bfcc30ae31eb1224c6ee152d382c8245c41f88c3a@mail.kernel.org>
In-Reply-To: <20260904195132.141068-7-sidchintamaneni@gmail.com>
References: <20260904195132.141068-7-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/7] bpf, s390: Use resolved pointer for timed may_goto
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,jeremy.jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,a.s.protopopov@gmail.com,puranjay@kernel.org,linuxppc-dev@lists.ozlabs.org,linux-s390@vger.kernel.org,linux-riscv@lists.infradead.org,rlmenge@gmail.com,hargar@linux.microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 20:33:46 +0000 (UTC)

--===============1590814207464027886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 20356163d51e7b8551f96780e7e969a26767c5c4
> Author:     Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> AuthorDate: Fri Sep 4 19:51:31 2026 +0000
> Commit:     Kernel Patches Daemon <kernel-patches-bot@fb.com>
> CommitDate: Fri Sep 4 13:03:02 2026 -0700
>
>     bpf, s390: Use resolved pointer for timed may_goto
>
>     The timed may_goto fixup now passes the resolved counter pointer through
>     BPF_REG_AX instead of a stack offset and BPF frame pointer pair.
>
>     Copy the pointer directly into the first argument register and update the
>     special calling convention documentation.
>
>     Fixes: b8efa810c1db ("s390/bpf: Add s390 JIT support for timed may_goto")
>     Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
>     Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
>     Assisted-by: Copilot:gpt-5.6-sol
>     Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Should the Fixes: tag point at b8efa810c1db?

At that commit the s390 trampoline was correct for the ABI in force at the
time. kernel/bpf/fixups.c emitted `insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX,
stack_off_cnt)`, so %r12 held a signed byte offset and `lay
%r2,0(%r12,%r13)` correctly resolved it against the s390 BPF frame pointer
%r13. Nothing was wrong with b8efa810c1db.

What makes the old code wrong is the parent commit in this series,
d8319a04dafc ("bpf: Fix timed may_goto stack pointer for private stacks"),
which replaced that with:

  insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
  insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt)

so that %r12 now carries an already-resolved pointer. Only after that does
`lay %r2,0(%r12,%r13)` double-add the frame pointer.

If a stable maintainer or AUTOSEL picks 20356163d51e on the strength of
its Fixes: tag without also taking d8319a04dafc, s390 is left with `lgr
%r2,%r12` while the fixup still puts a raw offset (stack_off_cnt =
-stack_depth - 16, e.g. -528) in %r12:

  bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)

then does `p->count` / `p->timestamp` loads and stores through a small
negative integer treated as a kernel pointer, which would trigger an oops
or memory corruption on every timed may_goto timeout.

The mirror case is equally bad: d8319a04dafc carries `Fixes:
e723608bf428` and will be selected for stable on its own, leaving s390
(and arm64/ppc64/riscv) double-adding the frame pointer.

The generic ABI change and its five arch consumers are not independently
correct, so either they belong in one commit, or the arch patches should
carry the same `Fixes: e723608bf428 ("bpf: Add verifier support for timed
may_goto")` and a `Cc: <stable@vger.kernel.org> # <sha>: <generic
commit>` prerequisite note. No Cc: stable and no prerequisite note is
present today.

Note: the same pattern is used by all four sibling commits (28bd77eb835b
x86, d35642770d98 arm64, 6e03227c5677 ppc64, 7053db7d3c0d riscv), so this
is a series-wide tagging decision rather than an s390-only slip.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33914557238
--===============1590814207464027886==--

