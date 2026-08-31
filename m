Return-Path: <linuxppc-dev+bounces-26251-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A826C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:12:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMDP4KVfz2y2f;
	Mon, 31 Aug 2026 18:12:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788163957;
	cv=none; b=DuoKVZym0dJF8Bk3yhki4QzbPUbybG2JwDmM/MPDRSunVEwjYGuTfGt/XoVobI8A82pFsKflWeO+bXYHXskxPD9GQpA2WOURgp3NLf9SXa8dhyUmCf5z/4TtT5np4LZXQPeFknNckTvZpwtZbQwTvGEnPS5oV1Iek+RBsZbn/HGScPLGaEVP+Vj7Uskl7IGuikISJ3ilLsxzp2NgWjA/0M5KJT/yqTC/T9mizfOUisiP6tq8bE/0lZRy9Tt0hqtk/KubR5D1IToRXDnWKc0Iktgf6gG7dmS9C44HnvNP++wiunUBlwZYKEEsKnLIZnKHOt9Q7RLDhXheT4FJbgdBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788163957; c=relaxed/relaxed;
	bh=dCW1uDpTCPb3PKxcuIP9dHEaxG/ORyGwzRGm/N4s7HY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z4WGhclt+QkaYoRtU0iqlXIX/7ZIWUtZRF4TEOnRrhre0UUUfRBXHILvz9JQA6Up30EUWDTFEVdWqVKSf91OKOyOO0uu7u0FqRl3198QIjDRXQ96tY9FjxoCrWI9UdVHy3dF/yNlGlCeZhVc7DrpnohAFmRtsPtAtkRtSV88qtN1n4h68Q/yBmAl8xFfk+2LZ6kWN7Br9HG1NYGanvgqFJZuOnpIiuo0UKBj9h1+ZafJ+nnojdA3VEsK6wb/44wQ+ilrVOvVXH+wAorK1YezQTZwzg2Ykj2ko+6XipKN1v9VFikU60RX3YEGen7JEfy6UesNGy/yO2qUzp4MASk9fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrv0Bna/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrv0Bna/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMDN45Wtz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:12:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 672F560120;
	Mon, 31 Aug 2026 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122F1F000E9;
	Mon, 31 Aug 2026 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163953;
	bh=dCW1uDpTCPb3PKxcuIP9dHEaxG/ORyGwzRGm/N4s7HY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Jrv0Bna/xyjZZBhuUxtTbI1EvY5Hir50ZAzftdhurTEoTwbfPd4Cq80m3Tdh42iEG
	 zpXbO3HPs8ZEoJq4rOk8Tb2zB4eRC+d+pnH9QdOBLVRV/vbmM/GuY6VsnW5x7PBrVn
	 GkJwO9CR4kPSxrd0EJrjad+994YFqjAnsil6fbE1OsenBayNd/pwJ5dEX5h0iPkXdq
	 mLPccO2oEsmJW9AMLpWwLaq1qXPAiN75pfesSe7lGFWCKJFqI3TF8/O1myt2XHQ8Pc
	 L8rhACd/YbVjutQ7m6vYcszxg8EKF1Y10TSROdOFQwf6HYYq3tRKspiQiM/BBMK3RP
	 kjNF2s+o06LXQ==
Content-Type: multipart/mixed; boundary="===============5021915201797315316=="
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
Message-Id: <64781ad3c02ca742220618dd46b27654a7dc71a4fe998ef7c20f50efbf355583@mail.kernel.org>
In-Reply-To: <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
References: <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 6/8] selftests/bpf: Fix powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:12:32 +0000 (UTC)

--===============5021915201797315316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Fix powerpc JIT disassembly failure
>
> Ensure that the trampoline stubs JITed at the tail of the
> epilogue do not expose the dummy trampoline address stored
> in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
> to the disassembly flow. Prevent the disassembler from
> ingesting this memory address, as it may occasionally decode
> into a seemingly valid but incorrect instruction. Fix this
> issue by truncating the last 8/4 bytes from JITed buffers
> before supplying them for disassembly.

Does the changelog accurately describe when this fix takes effect?

Looking at this commit, get_jited_program_text() is only called from
run_subtest() in tools/testing/selftests/bpf/test_loader.c when
subspec->jited.cnt != 0. The __jited expectations are only recorded
when the preceding __arch_* tag matches the running architecture:

    } else if ((val = str_has_pfx(s, "test_arch="))) {
            ...
            collect_jit = get_current_arch() == arch;

Since get_current_arch() in this tree has no powerpc case, it returns
ARCH_UNKNOWN, no __arch_* tag ever matches on powerpc, jited.cnt stays
0, and get_jited_program_text() is never invoked on powerpc.

The path only becomes reachable with the later patches in the same
series, 422d7386c6a2b (which adds ARCH_POWERPC64 / __arch_powerpc64) and
b787dda9a979d (which adds tailcall verifier selftest). Would it be more
accurate to describe this as a prerequisite for that enablement rather
than as a fix for a current failure?

Also, the changelog says the address "may occasionally decode into a
seemingly valid but incorrect instruction", whereas the comment added by
this same hunk says the bytes "can't disassemble to a valid
instruction", and the companion patch 0cd8bd7da278d quotes the concrete
symptom:

    Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0

A hard "Can't disasm" abort (what disasm_insn() reports via PRINT_FAIL)
is a different problem from a mis-decode into a plausible-looking
instruction. Could the commit message be more precise about which
failure mode actually occurs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============5021915201797315316==--

