Return-Path: <linuxppc-dev+bounces-22719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E99CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:55:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpRB38TVz3c58;
	Tue, 16 Jun 2026 23:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618134;
	cv=none; b=ayVYytujtaOVbJSJRtQeCIaznpDuyUV+2LQHHFPndY2JPO5Xoue0OeihiPL1aph0ovfuwcPwdp9I4Bn4Bt9lCu+m/T2VR+5GI28AJlnnXvN1qSi7M6lPw4NI0jjFYWQmg75GPqVmU0uJVTPySIR+A+NQvZlg2l9Y/ElaY3uOhl8gVhBcrHwgYMIlHqq6Oh/5pxGlrPCO/MmZ7ytN+uK/rrb4tIgZh8dMrKfbHnwH0E1ftrfK2D2rSTGRWfETPBF0pwF2GgocFNQa0UeDImtgwskbmJLqHvVC/+ZEmeKTIrOFtuy69YVRjqgzlNR++WIaXTOTw5cKbeKyo2orpa4Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618134; c=relaxed/relaxed;
	bh=386TELQbEHxweuigB9LLOnXetjMUnGIUnGTjr3fVOKs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=A/RkubXbw7x4BITsuBhO4Q05z8v66fFwEmzK+cm0KHk5fQWhzaWyZj3TM1k473h3JQb6h2DWwErFmQ4tRukO39E5RgjpwNH7PjnnhUEvEo4chMvAwDRWOo1EunbNNn1scAtV8lvU97sbjzBVqDT2kkF2bGKLphiplDZAiqqQGyoPdP3BWcPGqlNdrHQxw//+d9Dz3HnC5tm70hm5heit2uspSSpTxvdhhYGNtFThssyPE/LFVrthv0d8B5VPfOglC4ZcdgR0dMp8WzwweLVAwhrJYKwLtlkk6aLo2T8aDiLfyXNexIFV9UNQ5pARFoZw3UF8ClrsGy6TWzm3ad5IsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Izsrh6J7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Izsrh6J7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpR953X5z3c4l
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 23:55:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E85C41868;
	Tue, 16 Jun 2026 13:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D431F00A3A;
	Tue, 16 Jun 2026 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618130;
	bh=386TELQbEHxweuigB9LLOnXetjMUnGIUnGTjr3fVOKs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Izsrh6J79mj4NNjgJRzsUchOsOD02IXpx7Wb4ZNbQQt2pyIOembAqm52TFNOlTS7D
	 fxm91gfw7l/V3mrNrONfp6spjYuaFEbDUO9KSSOJf6R3ovS+qrFVyjoOlymE4mpmK/
	 GnjolHe1kLCD3h+8A4mZc/rfsKagWzsdtmmzrFjJ1adTHqeO9AhR/Q7oow0ezE465q
	 rf4YIFx0KQFUqCfuVq4WlACpPiSbblyOoCJr4smFXYpXpCmTTC0L2qAmWZmv/0muvL
	 SL/LTbgPZ6mSsMHysts47x9yA4zDondsZd5RVDkEdG6/KRj/1ttagN/djdQfjcI3P/
	 GbM/c3Ikq5fUw==
Content-Type: multipart/mixed; boundary="===============7481909573851222579=="
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
Message-Id: <c3c63feba5e72738b34d50b2c614e309f0ce6a2a11ba70bae9197996a3e58020@mail.kernel.org>
In-Reply-To: <20260616164741.32252-7-adubey@linux.ibm.com>
References: <20260616164741.32252-7-adubey@linux.ibm.com>
Subject: Re: [bpf v8 6/7] selftest/bpf: Add tailcall verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 13:55:29 +0000 (UTC)

--===============7481909573851222579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: Add tailcall verifier selftest for powerpc64
>
> Verifier testcase result for tailcalls:
>
> # ./test_progs -t verifier_tailcall
> #618/1   verifier_tailcall/invalid map type for tail call:OK
> #618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK
> #618     verifier_tailcall:OK
> #619/1   verifier_tailcall_jit/main:OK
> #619     verifier_tailcall_jit:OK
> Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

The test output lines in the commit message could benefit from indentation
to more clearly differentiate them as command output. Consider adding a space
or two before each of the test result lines for improved readability.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27620315552
--===============7481909573851222579==--

