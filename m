Return-Path: <linuxppc-dev+bounces-21018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545FCD4F47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 18:30:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJTyC0v0Fz2yQH;
	Mon, 18 May 2026 04:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779042627;
	cv=none; b=fIMDYQfuP66QMeWplw34soBKNx35/rmZWC2UD26KlYTyZx3hyiHtbRZ88XgnfzGvfIRUqdBzRa8RNjv/d9uY5+A7CZ/RyzQchtKuie2o6aW4srEky/i/s8Cu50KGMNDIiGnA0aMNMvCQJlkOq7Hq6lQ4Ol3qZVThyFfWz8c08xQIgNpmupFnOa4oDgnFISEi3Z6hdyWnrHNvNCJ4KyhKvARqg5CrytQSYmW/6BrWnmamBQaz6AEmjxxEBpJTYFHEyvA0AT1i28w1ZGLrWTym14ZO/MAbLs0h/rT/e+/S35difinax2t5i1Qij3jdi7z9t5qTiddjYLo5zBwBk+j4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779042627; c=relaxed/relaxed;
	bh=uMp+tW7SVDh5WczhkOZ3wPvmeAxfiAL0KvfaljwtlTE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=owsFiAwAVX/pi6jGhw2aBmJNlrfgyVFSkGtSlcQvguKb4uadkJKtxzPWPU/b5sS/KhA0s/WDxEf4QJPvkk/ShCVoo9WN8zzdetVvpHiSfzB46PvaZ5HUMGRpKRT5HZ7WtBXO0jaI5m+rKtQM6qXfk01c8WCMJYIXBayQKeaxNZUdAHNXdyN+XIi+7M2n1NP0mcPFvlqtH7zdlxuvXFp8bcT4pcGAKEZLkgXZHTenWOTvByhcmQhNJ30zd6E6pIWAeYVTTsXtIppPSK/Ykp0un1F3JOitAfbDeGmhiRsvfFsqNkcOeL5yWAgF9LiYJwDFtLFXnHya+6hBsACno9gILg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BJaAOyKE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BJaAOyKE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJTyB1R1fz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 04:30:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A84544566;
	Sun, 17 May 2026 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F44BC2BCB0;
	Sun, 17 May 2026 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042623;
	bh=nDFX9uuRrmdDrCwTCTS95orRvf1rp8grxvP/ByCFZvM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BJaAOyKEKlX19EPYOWJOIShJm1MKuTQtDGtXFdTYh6MtNYCZTjrqb4xVR9cZ6AjJJ
	 0kVs9q4gMnIzfV0p2+qerot1pNnXNZI7c7VCHu6cQ8AF0l/3mY9mUGIJ5bva6e548y
	 g2wPkppvB5Eb1CVbvFO0J6g/gBQ5l4BJ+ij2CyBKtel9l5qJoL4NKKPyy3IW61DhDk
	 jz9XXezocHHT2qCmgfnY7RU95+o1odWuGhylIAjdleprIHEupbua1B3AKkjIfsD9mf
	 6w3lhbLPiNwSHNpD9DCbXtHpXIVlL3RuMw2eT6etFZwnYpiaLE1utuBGobcqJfsC3Q
	 fnv6rG9CPiZfw==
Content-Type: multipart/mixed; boundary="===============8511337753608120594=="
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
Message-Id: <f99f99be312bfe17d6421c7b2ec14306d859f36825d653d9a6736ca1887a39de@mail.kernel.org>
In-Reply-To: <20260517214043.12975-3-adubey@linux.ibm.com>
References: <20260517214043.12975-3-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:30:23 +0000 (UTC)

--===============8511337753608120594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c1b9d3c3e6cf6547bc01395bd0576b1ea8dbd1d2
> Author: Abhishek Dubey <adubey@linux.ibm.com>
> Date:   Sun May 17 17:40:40 2026 -0400
>
>     powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
>
>     Move the long branch address space to the bottom of the long
>     branch stub. This allows uninterrupted disassembly until the
>     last 8 bytes. Exclude these last bytes from the overall
>     program length to prevent failure in assembly generation.
>     Also, align dummy_tramp_addr field with 8-byte boundary.
>
>     Following is disassembler output for test program with moved down
>     dummy_tramp_addr field:
>     .....
>     .....
>     pc:68    left:44     a6 03 08 7c  :  mtlr 0
>     pc:72    left:40     bc ff ff 4b  :  b .-68
>     pc:76    left:36     a6 02 68 7d  :  mflr 11
>     pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
>     pc:84    left:28     a6 02 88 7d  :  mflr 12
>     pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
>     pc:92    left:20     a6 03 89 7d  :  mtctr 12
>     pc:96    left:16     a6 03 68 7d  :  mtlr 11
>     pc:100   left:12     20 04 80 4e  :  bctr
>     pc:104   left:8      c0 34 1d 00  :
>
>     Failure log:
>     Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
>     Disassembly logic can truncate at 104, ignoring last 8 bytes.
>
>     Update the dummy_tramp_addr field offset calculation from the end
>     of the program to reflect its new location, for bpf_arch_text_poke()
>     to update the actual trampoline's address in this field.
>
>     All BPF trampoline selftests continue to pass with this patch applied.
>
>     Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

This looks like a bug fix for the alignment issue introduced in the
previous commit. Should this include:

  Fixes: 1fac3cfb82ab ("powerpc/bpf: fix alignment of long branch trampoline address")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============8511337753608120594==--

