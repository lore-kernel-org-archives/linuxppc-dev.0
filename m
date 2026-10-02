Return-Path: <linuxppc-dev+bounces-28738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C39CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:49:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx3sl33Fjz2yNj;
	Fri, 02 Oct 2026 19:49:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790934587;
	cv=none; b=QL+k4vS4gTM/JetRPCKEVNsx681XBopGDhC52Q0IxZ32LKkHCb1hCinVTGM4qK2ogq8ObIYUQ+CKPUrYFRr1CzDnnRHKjEtZVdok6A+WXkQzXZrImkBnCg8B5/i5Y7aqNGoUnygIWUwQk5ugWr3BTKRgcYMITvbwD5IB4cdJbfbBxBmUPjtPSYXexRGf7Xqu3G045yCr+cR5x2SDN780sNCs4aNFVRbOAPvDMJ5cxO6jTz2G8WF12SlkB863/HtkYp3xzaPPLdxKCLz06n+XM0TF9AVCOhrMEpxxygJq1Ji1vqmXEKH360JfBrL2sOnbxjhR/JthwAcwVtcODwzKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790934587; c=relaxed/relaxed;
	bh=O1NvwTXORD+Bb07RA52Wu5WZWJqKJmdYmCUZOMWRc5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv4HrJCBOxEEatq6GNRK/Ltxn3bjEsAZuEpA9U3sp7yrZjWpWbdYlfN3mZ2h7VXwuTFQjNKv5K9yMcTPGj/+m195/vTrfCEJFkT5LpDHxbD/N4y3ZBR84gNbqoa0M2VRJgcBQDdp+m6+rRBt3etJ5r61HK8jYAayls/k5RGbIVHKabBe7uwT2rqsIdSWEdBRX5e3+ywlYgI6ywpR7pKXXURExuMc7mu4rQO+oWBaDCVGb9TfsrfNODuxqgmqMnbS4NV9BO6V2NawS6FiYE0hm+ecUuVmUzQPTM2ieCNSdoZ9VrI/i8v27BaeiHBzWWafi3lPlCq2Ix6HN2BC80FMNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOMAm0+c; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOMAm0+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3sk0Jzsz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:49:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F6F060A70;
	Fri,  2 Oct 2026 09:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C201F00898;
	Fri,  2 Oct 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934582;
	bh=O1NvwTXORD+Bb07RA52Wu5WZWJqKJmdYmCUZOMWRc5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOMAm0+cj8fILcHV8Uj0RSZsjvcpY1RGYRxgNmibtLJucq4PJOFYlIeiGQVMfrMtH
	 DuOOY8IKcr5yOnM73cxavmFw/nMHIjF2qDFrl5uDmTm4oMLgD066mfJFMfXw9Bc49t
	 csqzp1wUBMrdSv3SghZJ/e5GLtijiu6xy2aZ5PO4v+0coTfSNOC/XZkaenDtUej0CP
	 i/q/JrIeY1TU8Nol9o5vJO8rP4m5pAttrz6dh8syfIsV6x0pir8FExIzAdOKEXHnA9
	 Cm8d729oJ1G8qj87sC00EzJFfXA+tDEZru+V9USQSA1Xg//ndb/O3J7bRLVs8z/I4V
	 zfigDTcHw5t/g==
Date: Fri, 2 Oct 2026 11:49:32 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20261002094932.GA3435055@ax162>
References: <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
 <20261001110310.GA138012@ax162>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001110310.GA138012@ax162>

On Thu, Oct 01, 2026 at 01:03:10PM +0200, Nathan Chancellor wrote:
> On Thu, Oct 01, 2026 at 12:48:10PM +0200, Jason A. Donenfeld wrote:
> > Does this commit seem okay with you? I used the diff you sent below and
> > adjusted the commit message: https://git.zx2c4.com/linux-rng/commit/?id=56ff95ee85715047eb5b5220243778af657778c8
> 
> Yeah, that seems fine to me, thanks for taking care of it!

Can you adjust the LLVM value by one from 4294967295 to 4294967294? ~0U
is actually a special value, so we hit an assertion in the SystemZ
backend.

  https://github.com/llvm/llvm-project/blob/3f48e22a1f321d5d3341bd812803694cea588785/llvm/lib/CodeGen/SelectionDAG/SelectionDAG.cpp#L9547
  https://github.com/llvm/llvm-project/blob/3f48e22a1f321d5d3341bd812803694cea588785/llvm/lib/Target/SystemZ/SystemZISelLowering.cpp#L1470-L1471

clang: llvm/lib/Target/SystemZ/SystemZISelLowering.cpp:1471: virtual bool llvm::SystemZTargetLowering::findOptimalMemOpLowering(LLVMContext &, std::vector<EVT> &, unsigned int, const MemOp &, unsigned int, unsigned int, const AttributeList &, EVT *) const: Assertion `Limit != ~0U && "Expected EmitTargetCodeForMemXXX() to handle AlwaysInline cases."' failed.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and dumped files.
Stack dump:
0.      Program arguments: ...
1.      <eof> parser at end of file
2.      Code generation
3.      Running pass 'Function Pass Manager' on module 'arch/s390/kernel/vdso/vgetrandom.c'.
4.      Running pass 'SystemZ DAG->DAG Pattern Instruction Selection' on function '@__kernel_getrandom'
...

-- 
Cheers,
Nathan

