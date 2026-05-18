Return-Path: <linuxppc-dev+bounces-21111-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C12CD4F52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 11:45:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJwvv57Jsz2xpn;
	Mon, 18 May 2026 21:44:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779104699;
	cv=none; b=f1U6WdhqaKwauoDsfZ6sb9JYZeGMe7ujwSxr0cU6N9EkQRsmlovHR5pUWqppLuNLwYAOzbYk2iDKD8lr/6pZY3ZYNZ2w7BmiNoTFusE0NTV6mGiLafOZjMXTjG/lThVKrrizuxAygHAb+/I6uZ+Kugb3pNoY0q0RMEJoShsSruqouiLFyZDmvCHh0G202eIYsGPpFCj9fhlovpvQI0y0peeCIOatDY47nMjkasVFA0z6VxZD9QSOipSxkC90QoqfjIXB5O/3MvdDiTMrltOWgjlbPxwlgrHBrzokAz2lWXsNZ30bAQD3hjYC9tk8lNn9TGSR35Nigoyt2BB9dSVKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779104699; c=relaxed/relaxed;
	bh=ikxoR7bGVMktp4Ss01Hx+U4hpUBN8ks+LFbzNHdDd0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNRdeO8ysM+5cslwVkF27UyWgueNBIjlAi2LHTigFsXUFAzsdYca1XoSHI47IMcgSf8WnoUH8T0PoaDwEIw/oWzdj6X2y11i96tvSs6N93Lt9l4Eipcamac7anlzltoJazs9vaIKmidktfT2HzpjQI/tAznmyzWCGa9axzA4bWnyAkvMztl23YzlS2n0LkSEAQdMtjhz05mQDXG1/V6keiS+sI84FiJHjs/kLLZUznYO4Qysa8O7oT2Pjb0lZY80AYKkqf1OZmO9RpoQbKazG+mAaE3szhFA9veMCbqrDpkB37SlpvLmjUCnyvYO6OwIWVL2zUtDs3IxDG21AhOEzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=duQFcPqh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=duQFcPqh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJwvt2gcfz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 21:44:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 39C6C601E5;
	Mon, 18 May 2026 11:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55099C2BCB8;
	Mon, 18 May 2026 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104695;
	bh=pWq9XAxTuPdgs7tFtyzqEWZA5ZkN0qS2ybq5p8QU1aQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=duQFcPqh2MyBKNEEOMjP5JnEJXjkvYJoZxmfuqnTmcSSYq0SCw9FFzbjdcZrD/5gi
	 /c+se/kTKLdoe636uKqraiRM5/WAv/Tp7sR+6UMijcK/4X3zLrDSqbuRi66eX28QSl
	 u3XjE1CZRq8PXnA+PMKmXtu91Hvu/PoKC/C39HmM6jZcro5P+OKEZZPeZFzD6RSp0X
	 HdjoG81cZYjtGVNbJV8yxRk/Atj2ZuAHzL0sBg4YXkDgOQmPkJX8652QOqOVqIoeeU
	 ZQ7OpukpwEzBlF10kMpynqpvX+EwSTSkVGVZi/C/BHv0szJb9kFS0ecv2rW3H0uFce
	 Om6Y1Ru0qg2hg==
Message-ID: <cf5f932b-6586-4f64-ad2f-c9a6ff81affe@kernel.org>
Date: Mon, 18 May 2026 13:44:50 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] powerpc/bpf: Add support for verifier selftest
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517214043.12975-1-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260517214043.12975-1-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/05/2026 à 23:40, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The verifier selftest validates JITed instructions by matching expected
> disassembly output. The first two patches fix issues in powerpc instruction
> disassembly that were causing test flow failures. The fix is common for
> 64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
> architecture tag in the third patch, enabling proper test filtering in
> verifier test files. Introduce verifier testcases for tailcalls on powerpc64
> in the final patch.

Build fails:

   DESCEND objtool
   INSTALL libsubcmd_headers
   CC      arch/powerpc/net/bpf_jit_comp32.o
arch/powerpc/net/bpf_jit_comp32.c:232:6: error: conflicting types for 
'bpf_jit_build_epilogue'; have 'void(u32 *, struct codegen_context *)' 
{aka 'void(unsigned int *, struct codegen_context *)'}
   232 | void bpf_jit_build_epilogue(u32 *image, struct codegen_context 
*ctx)
       |      ^~~~~~~~~~~~~~~~~~~~~~
In file included from arch/powerpc/net/bpf_jit_comp32.c:19:
arch/powerpc/net/bpf_jit.h:217:6: note: previous declaration of 
'bpf_jit_build_epilogue' with type 'void(u32 *, u32 *, struct 
codegen_context *)' {aka 'void(unsigned int *, unsigned int *, struct 
codegen_context *)'}
   217 | void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct 
codegen_context *ctx);
       |      ^~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/net/bpf_jit_comp32.c: In function 'bpf_jit_build_epilogue':
arch/powerpc/net/bpf_jit_comp32.c:240:43: error: passing argument 2 of 
'bpf_jit_build_fentry_stubs' from incompatible pointer type 
[-Wincompatible-pointer-types]
   240 |         bpf_jit_build_fentry_stubs(image, ctx);
       |                                           ^~~
       |                                           |
       |                                           struct codegen_context *
arch/powerpc/net/bpf_jit.h:218:50: note: expected 'u32 *' {aka 'unsigned 
int *'} but argument is of type 'struct codegen_context *'
   218 | void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
codegen_context *ctx);
       |                                             ~~~~~^~~~~~
arch/powerpc/net/bpf_jit_comp32.c:240:9: error: too few arguments to 
function 'bpf_jit_build_fentry_stubs'; expected 3, have 2
   240 |         bpf_jit_build_fentry_stubs(image, ctx);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/net/bpf_jit.h:218:6: note: declared here
   218 | void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
codegen_context *ctx);
       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:289: 
arch/powerpc/net/bpf_jit_comp32.o] Error 1
make[3]: *** [scripts/Makefile.build:548: arch/powerpc/net] Error 2
make[2]: *** [scripts/Makefile.build:548: arch/powerpc] Error 2
make[1]: *** [/home/chleroy/linux-powerpc/Makefile:2143: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


Christophe


