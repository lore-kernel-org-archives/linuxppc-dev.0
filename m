Return-Path: <linuxppc-dev+bounces-21192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0654ECD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 20:27:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKmRn5Vldz2yD6;
	Wed, 20 May 2026 06:27:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779222421;
	cv=none; b=TCOVzzj1gKckcIilQuv1yg9Nq4WOEnU5/JzcsMr+4ashFu4HdB/1xKSeVdxsIw9E36h9x5gz6Ezszu1c4oYxZtLCQ0Sh2HdziMe+8Gyx9eTZnGtpReDpdbZbtztFChNglKkGNuvJCRJRksomm/EX8rPjEXnGYqVAKOEP+9u2mspn4c9PMqH3vVwVKC9xhiCSBDLbK2DpedJM3TzAicUnvG1ARTP4eC4vRIhLO7CYaqKJ2e+T+7Ckq6oc3lNFuyQ4Kb7uzf29Vz2u3AcbJmoHVPrgsgEd2q71uk/vdAdJNfEQCt6NcsL68QSR/0EqHKpTr2aLd6hAOzMHUCT/I428Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779222421; c=relaxed/relaxed;
	bh=12aBSvojo05afpnBg6VM7sWoJBKuZQ5iYoXpWWaZoTw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZB7+ebwNohjHdYUwsDKmjdW1OWH20/jMc6ku7I8sQRASloYpCjnbcxXza3zYKw4eL0v3qcbQgOg7zlBizXEg/la/ZosKlOQeeAN5XxshX/shdC2BZn8/zOtJjK2sAiWwf5FsdkE+K6iOcyvq2m3Ra+fw2kto725pXTjgVt8SWL6Tt4gvNSKEkKnHatYCLEiIiREWGF7yw9UYyP5fBIv1PRvIeKJMUXMRW/9b/9ekMdWbNPXW0ljTtqrritp6gOd9I5S24amG3R6UP6HLxTLk4DXpTDb8MRHl+0Bts18B8V3bXy6XFluBOpFC4v8a93HpRrB5KOZiH8Tw0LnRvasxgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSCezyE6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSCezyE6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKmRm6mhlz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 06:27:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D301060233;
	Tue, 19 May 2026 20:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427231F000E9;
	Tue, 19 May 2026 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222418;
	bh=12aBSvojo05afpnBg6VM7sWoJBKuZQ5iYoXpWWaZoTw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZSCezyE6OE5QP9x1+Mrz//sLQUIRHpRMeoSCruEB2NB+dygaVzEjm6gMSZcA4QjZ7
	 pZeOhxu87Z46oi4MJMIiwY9ZVEdHw9Z29iG1/fy14DVTkukKsaiRAYZAzawUqysAlL
	 ngJipQtN0jVENoG65wMyi/uM0N/pIiZ9Hkdyc9NBDUxKVi7BR87omtGJ0YUd0KqPcw
	 Q3cFXLa8AjPqA2R+nX37kTTo3Xfb582dM0AynrWfQdmVt9GpAKABrqsasmrr92AHLc
	 2NOMHcrqmQfW51ZSXC6v1a2maJG1HcjR57zekGYXx9nTb7K3Y8iKHkdrqmI9p6Jd1n
	 7epqQHlY2C7XQ==
Content-Type: multipart/mixed; boundary="===============1006306579911665399=="
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
Message-Id: <8038d2d4d6cbe44e018d1d2201fc10bc550994d05be6aeee83f6baed0964bac8@mail.kernel.org>
In-Reply-To: <20260519233812.18787-3-adubey@linux.ibm.com>
References: <20260519233812.18787-3-adubey@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 20:26:58 +0000 (UTC)

--===============1006306579911665399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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

This looks like a bug fix for the bpf trampoline implementation on
powerpc64. Should this include a Fixes tag?

The bug was introduced in commit d243b62b7bd3 which added support for bpf
trampolines on powerpc64. That commit placed the dummy_tramp_addr field at
the beginning of the long branch stub, causing the disassembly failures and
incorrect offset calculations that this patch fixes.

Suggested:

  Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26121409898
--===============1006306579911665399==--

