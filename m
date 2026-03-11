Return-Path: <linuxppc-dev+bounces-18044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618B6FD065A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 08:32:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW3sT5Lcyz3f1p;
	Wed, 11 Mar 2026 19:32:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773217965;
	cv=none; b=OeTo0pofu271z6Yda6V/+OYgCdRXFPmaNgfztJ5A7ouNKmNe+nctK1sliTe8KJuS2/3/J+rg/cfCdmRCAL66KqURvlpJ6oNLbtgHdC5uvkpSSjzL4MXf5tA+h8m6iw8dlGNfQiFb03F9547kswPS579fuP49QG/rLGjdCiSuFOuHtWqTMxt1PN5ZUY3lxoJtgDNcDczdIEBrAQWrUCD/uPLkyjWADrIUdHW7peg5vIt5h+N9kl3CbAhZJSesKFTkLjPVVHfa323PJUIT9NmMXz1ItLW5Xxz5TJZ6bE7H7o1tqMMAThc7kqubbeAJUt8KtFu4sF0W/TFA7i5ZXXsW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773217965; c=relaxed/relaxed;
	bh=lWh3I1BJesXJ03ee9rt4h78hZaVgU22THcNWmWBoOOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2U0EJE1XMVLD2fpdLNfJBnN8dhUtCQhJt+6ec7ipJNNNNV41yqt7Bj20Kbm4cJUTuCX50gi4Bukin+mtSGoPkli1/gmnWw6A1pTk+8n8SMIkx9raUsE18g7M7DAdvh1RLkSHi4BKgHJuM2HTta4h0kXsZ3XHX0gT4DnOSuK7WemEjSHYD+CIkpMgV7r6QYQGXut8nyz9ZmSW7KTEDm/7qb0ED108+Ga6pWec827n18beGYnX7obu/8PM7HUJ7hzePsIVpPpZpnBL8oS1z1UnoAnGOyfJfPpsYGDmEtVwscInGnwr6+534BJ7RgCYR+4sAsu6IjXxQ1ugA4Oepo07w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW3sS3Jl9z3f1n
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 19:32:42 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25D5B20E3;
	Wed, 11 Mar 2026 01:32:04 -0700 (PDT)
Received: from [10.57.83.155] (unknown [10.57.83.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D80843F836;
	Wed, 11 Mar 2026 01:32:05 -0700 (PDT)
Message-ID: <7687ded7-ecb1-45fe-bfa6-37d1a04355c8@arm.com>
Date: Wed, 11 Mar 2026 08:32:04 +0000
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
Subject: Re: [PATCH v5 0/2] Fix bugs and performance of kstack offset
 randomisation
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260303150840.3789438-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260303150840.3789438-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees,

I'm keen to get some testing in linux-next and hopefully get this upstream for
v7.1 as we previously discussed. Are you willing/able to take this via your tree?

Thanks,
Ryan



On 03/03/2026 15:08, Ryan Roberts wrote:
> [Kees; I'm hoping this is now good-to-go via your hardening tree? It would be
> good to get some linux-next testing.]
> 
> Hi All,
> 
> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> and, on arm64 at least, the performance is poor. This series attempts to fix
> both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
> proposes a performance improvement approach.
> 
> I've looked at a few different options but ultimately decided that Jeremy's
> original prng approach is the fastest. I made the argument that this approach is
> secure "enough" in the RFC [2] and the responses indicated agreement.
> 
> More details in the commit logs.
> 
> 
> Performance
> ===========
> 
> Mean and tail performance of 3 "small" syscalls was measured. syscall was made
> 10 million times and each individually measured and binned. These results have
> low noise so I'm confident that they are trustworthy.
> 
> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
> performance cost of turning it on without any changes to the implementation,
> then the reduced performance cost of turning it on with my changes applied.
> 
> **NOTE**: The below results were generated using the RFC patches but there is no
> meaningful change, so the numbers are still valid. I've also rerun the tests
> with this version on top of v7.0-rc2 on arm64 and confirmed simialr results.
> 
> arm64 (AWS Graviton3):
> +-----------------+--------------+-------------+---------------+
> | Benchmark       | Result Class |   v6.18-rc5 |  per-cpu-prng |
> |                 |              | rndstack-on |               |
> |                 |              |             |               |
> +=================+==============+=============+===============+
> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |
> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |
> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |
> +-----------------+--------------+-------------+---------------+
> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |
> |                 | p99 (ns)     | (R) 152.81% |         1.55% |
> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |
> +-----------------+--------------+-------------+---------------+
> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |
> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |
> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |
> +-----------------+--------------+-------------+---------------+
> 
> Because arm64 was previously using get_random_u16(), it was expensive when it
> didn't have any buffered bits and had to call into the crng. That's what caused
> the enormous tail latency.
> 
> 
> x86 (AWS Sapphire Rapids):
> +-----------------+--------------+-------------+---------------+
> | Benchmark       | Result Class |   v6.18-rc5 |  per-cpu-prng |
> |                 |              | rndstack-on |               |
> |                 |              |             |               |
> +=================+==============+=============+===============+
> | syscall/getpid  | mean (ns)    |  (R) 13.32% |     (R) 4.60% |
> |                 | p99 (ns)     |  (R) 13.38% |    (R) 18.08% |
> |                 | p99.9 (ns)   |      16.26% |    (R) 19.38% |
> +-----------------+--------------+-------------+---------------+
> | syscall/getppid | mean (ns)    |  (R) 11.96% |     (R) 5.26% |
> |                 | p99 (ns)     |  (R) 11.83% |     (R) 8.35% |
> |                 | p99.9 (ns)   |  (R) 11.42% |    (R) 22.37% |
> +-----------------+--------------+-------------+---------------+
> | syscall/invalid | mean (ns)    |  (R) 10.58% |     (R) 2.91% |
> |                 | p99 (ns)     |  (R) 10.51% |     (R) 4.36% |
> |                 | p99.9 (ns)   |  (R) 10.35% |    (R) 21.97% |
> +-----------------+--------------+-------------+---------------+
> 
> I was surprised to see that the baseline cost on x86 is 10-12% since it is just
> using rdtsc. But as I say, I believe the results are accurate.
> 
> 
> Changes since v4 [5]
> ====================
> 
> - Moved add_random_kstack_offset() later in syscall entry code for powerpc, s390
>   and x86. On these platforms it was previously within noinstr sections but for
>   some exotic Kconfigs, [get|put]_cpu_var() was calling out to instrumentable
>   code. (reported by kernel test robot)
> - Removed what was previously patch 2 (inline version of prandom_u32_state()).
>   With the above change, there is no longer an issue with calling the
>   out-of-line version.
> 
> Changes since v3 [4]
> ====================
> 
> - Patch 1: Fixed typo in commit log (per David L)
> - Patch 2: Reinstated prandom_u32_state() as out-of-line function, which
>   forwards to inline version (per David L)
> - Patch 3: Added supplementary info about benefits of removing
>   choose_random_kstack_offset() (per Mark R)
> 
> Changes since v2 [3]
> ====================
> 
> - Moved late_initcall() to initialize kstack_rnd_state out of
>   randomize_kstack.h and into main.c. (issue noticed by kernel test robot)
> 
> Changes since v1 (RFC) [2]
> ==========================
> 
> - Introduced patch 2 to make prandom_u32_state() __always_inline (needed since
>   its called from noinstr code)
> - In patch 3, prng is now per-cpu instead of per-task (per Ard)
> 
> 
> [1] https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
> [2] https://lore.kernel.org/all/20251127105958.2427758-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/all/20251215163520.1144179-1-ryan.roberts@arm.com/
> [4] https://lore.kernel.org/all/20260102131156.3265118-1-ryan.roberts@arm.com/
> [5] https://lore.kernel.org/all/20260119130122.1283821-1-ryan.roberts@arm.com
> 
> Thanks,
> Ryan
> 
> 
> Ryan Roberts (2):
>   randomize_kstack: Maintain kstack_offset per task
>   randomize_kstack: Unify random source across arches
> 
>  arch/Kconfig                         |  5 ++-
>  arch/arm64/kernel/syscall.c          | 11 ------
>  arch/loongarch/kernel/syscall.c      | 11 ------
>  arch/powerpc/kernel/syscall.c        | 16 ++-------
>  arch/riscv/kernel/traps.c            | 12 -------
>  arch/s390/include/asm/entry-common.h |  8 -----
>  arch/s390/kernel/syscall.c           |  2 +-
>  arch/x86/entry/syscall_32.c          |  4 +--
>  arch/x86/entry/syscall_64.c          |  2 +-
>  arch/x86/include/asm/entry-common.h  | 12 -------
>  include/linux/randomize_kstack.h     | 54 +++++++++++-----------------
>  init/main.c                          |  9 ++++-
>  kernel/fork.c                        |  1 +
>  13 files changed, 37 insertions(+), 110 deletions(-)
> 
> --
> 2.43.0
> 


