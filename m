Return-Path: <linuxppc-dev+bounces-22720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC3FCD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:55:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpRC0c9yz3c5q;
	Tue, 16 Jun 2026 23:55:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618135;
	cv=none; b=b1pbGoH8YaQSTgvJhFG60EsoGKJHduULHWZY0zAsFLNnJ/4nifWB561ezF11v8OB2pdETiVuPbRh+FCDUSzHh+jHJNkddD584I6nogV0C4Y7JkC6Iv/cHz/+VMXLQJ5ejAcg5xKLKO2cSljBO2llDFrpD6bS+HxdcxcirvJ1USbG4OBOUJgG+Zu6aZlaYdkFNXpf+hvtcRh8VdRG4gjoRdJDLt3Hx50EKHVpPxuaPIzhm+TKkg1XtuGsFdSN4oSQtDehDLdguYEvm6/IRNShKfx7aALnqQ6hG/cJZonCEG3vJpjZo/ie4XnJbVuHoEH05wm+lMf8x395DNCe+h5+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618135; c=relaxed/relaxed;
	bh=9FZF+OBjyzpGj+hdKvuHfcoi32RqLii3MBniBKQPKKA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bI0p6GKOesikBUttwkd5NnwCBe+zRY2XkZKfeEnerkvrFmqG6Nokm6jA961DQQfdxOBBtV4YTzGPOZICgUSaJDviDFCJ+RU/0Raj1SUcL5jIwpp9xhGFhtEgzJ44X2HRw9LCtJ8z4/sZXfFKyszEYaS5D6JuDSws2VFanBusdI5wSoBAucZxgsIUeaxy3o13FiKV8jbrpEvqOzPfFpxwKKBbxPp90Gu9Zg/E4A4Tk2NBzuH8pwo2rkn4NUzBF6iVBqzvBVgPQAUb9DFWrNz5P4tF/x9Z19oowC7yGoxsoCQD2+BmU2rqzbsf07GtGbNWIhRsDSK17WibXioy/doGjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0N/mgrc; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0N/mgrc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpRB2wYjz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 23:55:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 83C176012B;
	Tue, 16 Jun 2026 13:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6941F000E9;
	Tue, 16 Jun 2026 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618132;
	bh=9FZF+OBjyzpGj+hdKvuHfcoi32RqLii3MBniBKQPKKA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n0N/mgrc1nl08aCs0wGBfW/iYLg6F85xZY1u3eykhGHPr+KaJulr0Cdosq2jQ10uE
	 36BJpjIc/vzwTTEdPSEpl4fjpnN/0qXcWT6F9N2KZKqQ7dbolhyvCja+SZYaQQfLZ0
	 9FvtsLk4H16AyzAg4HB/tYnN1kUt1I+4A2xdSnfj6LTuJLF0MCthM00GkBkp2uRwsm
	 dSzfgFFdNs8Vqw8FLlk0dmhCAmCW+RdbBikcMUGqgpKighT8f7UqzB2TeuxISaI1bt
	 lHtgulvNwmukuQ8iVzXn8gd6z0+HQfvyscDnZ3UT7YUmVm66Z9Ie9JSzCSJCMXtNnD
	 pUKgZ7T9QJj9w==
Content-Type: multipart/mixed; boundary="===============8096130991037514973=="
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
Message-Id: <dddff13192a99e8ccc1a3453daf7c5a28e656622d5a013dc51769471c430b2fe@mail.kernel.org>
In-Reply-To: <20260616164741.32252-4-adubey@linux.ibm.com>
References: <20260616164741.32252-4-adubey@linux.ibm.com>
Subject: Re: [bpf v8 3/7] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:31 +0000 (UTC)

--===============8096130991037514973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftest/bpf: Fixing powerpc JIT disassembly failure
>
>     Ensure that the trampoline stubs JITed at the tail of the
>     epilogue do not expose the dummy trampoline address stored
>     in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
>     to the disassembly flow. Prevent the disassembler from
>     ingesting this memory address, as it may occasionally decode
>     into a seemingly valid but incorrect instruction. Fix this
>     issue by truncating the last 8/4 bytes from JITed buffers
>     before supplying them for disassembly.
>
>     Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

This looks like a bug fix, but there's no Fixes: tag.  The code being
corrected is the disasm_one_func(text_out, image + pc, func_lens[i]) call
in get_jited_program_text(), which feeds the full JITed function length
(including the trampoline tail holding the dummy trampoline address) to
the disassembler.  That helper and call site were added by commit
b991fc520700.

Should this include:

  Fixes: b991fc520700 ("selftests/bpf: utility function to get program disassembly after jit")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============8096130991037514973==--

