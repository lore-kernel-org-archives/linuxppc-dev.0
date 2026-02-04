Return-Path: <linuxppc-dev+bounces-16601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531B6EA7944
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 19:43:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5rPD42Xpz2xm3;
	Thu, 05 Feb 2026 06:43:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770234192;
	cv=none; b=SsiToHzRVM0Fy4hqcO9nipnNzA58C0pMAnwbuH+1GaqeB5MSG4xZwNmfNyA4F6vQMvexjKdGh4Lqpsyt4AYgcaqe6KCPEQKmuD/WKtDg9LGgckYwD/LO3yhwEkkIObr6tdjDy+MnD7zKEmiYPI/vopc/0K6tq6WxUFYjnhSfTDX6VFyeR63zmfUDkgth7t6aHSI7yPDFIvCw2Eicx9oP61PJyr/mq2YMecGbtBQ3f+P2k/axTdOmNP553IF+58jyMJz5WE5giQqTQuPBHmeqKzYovXdJyuiAXXNYlmQo/wh+rn4qs8eZy2ehVThtf7rwfDkp37L/soTz2D+Epn36BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770234192; c=relaxed/relaxed;
	bh=oTx1Wv1rnyMmhoPSFL6Vou1DUALgAtGwKrg7q/8IfW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbm7x/vW9lpRbuOr+TMdhVFoWfGTQ3TIWVbOz3iRuzhbHpiIn1juGDPRtkkb67w+VNXWzhLNukq1VKyYanPGUCI1iaT3Ivouc7qLUlivmV99YNZlLvUxHIVZgMzwf9fH6fVd8rqMyYzdewXniOtbSA3rmT8J8BzxPuyHB5V+0vqw5sulcWYVVORUu7diX44CLQl5BzDjR5F4iPIPaJZD5BYVhB2FHUNvkGfHk2GC+hDYzKInDV8pLOcFYnumBCV/bs1cgrOAbGIyYgtkNsqv5IxUztpd06u+KuUj+FzAuix2tYOmzcFhH4wTZ6iuBRL2oCC8Qo+d0qElCgZ5ioQQrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dSv2Kga3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dSv2Kga3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5rPC3gkNz2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 06:43:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EAF9A600AA;
	Wed,  4 Feb 2026 19:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF5C4CEF7;
	Wed,  4 Feb 2026 19:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770234187;
	bh=klGJQDFpIQV+UTYw0N8RiEabthirIWJ6NTj5RFvTcAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dSv2Kga3O5StdZaXYpy2wAMTZiJBJ3cW9BJK4ndKqLIqWHqoJ0bKfqIrtKnWBOgdZ
	 m6KUDkvDpUOj+mkMDvJ6+6Arvhir5KGds+Y2fyo+wVh6+xLsRPd+ogy4Lx5eldR1F5
	 ap0uKDG+QAYSfBNoPZI1WljOT83dFUVtqNg8BN22967y03IlbKfyV0hJtSSFFVrM/J
	 bJTd/foYa83vign1Sa2VxF8JC/nMywQRzoZTIeMraB6pEKnSfTVr8RiC+pT61FP92F
	 19FzydgB6gcx2yhQqapE5v/e+lKSI2SM0/iA86zs6JUUbbo6Pr6CjZMGsoRJZ1XOq3
	 pnfo6+HEqtzVw==
Message-ID: <58845ef3-e781-42d1-bb7e-199b421ff476@kernel.org>
Date: Wed, 4 Feb 2026 20:42:58 +0100
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
Subject: Re: [PATCH] rust: Add PowerPC support
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Link Mauve <linkmauve@linkmauve.fr>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
 officialTechflashYT@gmail.com, Ash Logan <ash@heyquark.com>,
 Roberto Van Eeden <rw-r-r-0644@protonmail.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
References: <20260204030507.8203-1-linkmauve@linkmauve.fr>
 <aYOCWHF4CwzDVPuA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <aYOCWHF4CwzDVPuA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/02/2026 à 18:33, Mukesh Kumar Chaurasiya a écrit :
> [Vous ne recevez pas souvent de courriers de mkchauras@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Wed, Feb 04, 2026 at 04:05:04AM +0100, Link Mauve wrote:
>> For now only Big Endian 32-bit PowerPC is supported, as that is the only
>> hardware I have.  This has been tested on the Nintendo Wii so far, but I
>> plan on also using it on the GameCube, Wii U and Apple G4.
>>
>> These changes aren’t the only ones required to get the kernel to compile
>> and link on PowerPC, libcore will also have to be changed to not use
>> integer division to format u64, u128 and core::time::Duration, otherwise
>> __udivdi3() and __umoddi3() will have to be added.  I have tested this
>> change by replacing the three implementations with unimplemented!() and
>> it linked just fine.
>>
> Hey Link,
> I sent a patch with ppc64le support.
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260204042417.83903-1-mkchauras%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C9033c0c08e1142c26cc408de6420675d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639058287509811601%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=LglEn8yJoYUcsXoENa8HO4SsOW4kKU397kDNVyfBilg%3D&reserved=0
> 
> Can i take this patch and put ppc64le support over it and send it out?

Could also one of you feed https://github.com/linuxppc/issues/issues/451 ?

Thanks
Christophe

> 
> Regards,
> Mukesh
>> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
>> ---
>>   Documentation/rust/arch-support.rst   |  1 +
>>   arch/powerpc/Kconfig                  |  1 +
>>   arch/powerpc/Makefile                 |  2 ++
>>   arch/powerpc/include/asm/jump_label.h | 16 ++++++++++------
>>   rust/Makefile                         |  4 +++-
>>   scripts/generate_rust_target.rs       | 10 ++++++++++
>>   6 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
>> index 6e6a515d0899..70b9e192a7a0 100644
>> --- a/Documentation/rust/arch-support.rst
>> +++ b/Documentation/rust/arch-support.rst
>> @@ -18,6 +18,7 @@ Architecture   Level of support  Constraints
>>   ``arm``        Maintained        ARMv7 Little Endian only.
>>   ``arm64``      Maintained        Little Endian only.
>>   ``loongarch``  Maintained        \-
>> +``powerpc``    Maintained        32-bit Big Endian only.
>>   ``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
>>   ``um``         Maintained        \-
>>   ``x86``        Maintained        ``x86_64`` only.
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 9537a61ebae0..17db23b82e91 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -283,6 +283,7 @@ config PPC
>>        select HAVE_REGS_AND_STACK_ACCESS_API
>>        select HAVE_RELIABLE_STACKTRACE
>>        select HAVE_RSEQ
>> +     select HAVE_RUST                        if PPC32
>>        select HAVE_SAMPLE_FTRACE_DIRECT        if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>        select HAVE_SAMPLE_FTRACE_DIRECT_MULTI  if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>        select HAVE_SETUP_PER_CPU_AREA          if PPC64
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index a58b1029592c..9fd82c75dcbd 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -61,6 +61,8 @@ else
>>   KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
>>   endif
>>
>> +KBUILD_RUSTFLAGS += --target=powerpc-unknown-linux-gnu
>> +
>>   ifdef CONFIG_CPU_LITTLE_ENDIAN
>>   KBUILD_CPPFLAGS      += -mlittle-endian
>>   KBUILD_LDFLAGS       += -EL
>> diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
>> index d4eaba459a0e..238f0f625a36 100644
>> --- a/arch/powerpc/include/asm/jump_label.h
>> +++ b/arch/powerpc/include/asm/jump_label.h
>> @@ -15,14 +15,18 @@
>>   #define JUMP_ENTRY_TYPE              stringify_in_c(FTR_ENTRY_LONG)
>>   #define JUMP_LABEL_NOP_SIZE  4
>>
>> +/* This macro is also expanded on the Rust side. */
>> +#define ARCH_STATIC_BRANCH_ASM(key, label)           \
>> +     "1:\n\t"                                        \
>> +     "nop # arch_static_branch\n\t"                  \
>> +     ".pushsection __jump_table,  \"aw\"\n\t"        \
>> +     ".long 1b - ., " label " - .\n\t"               \
>> +      JUMP_ENTRY_TYPE key " - .\n\t"                 \
>> +      ".popsection \n\t"
>> +
>>   static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>>   {
>> -     asm goto("1:\n\t"
>> -              "nop # arch_static_branch\n\t"
>> -              ".pushsection __jump_table,  \"aw\"\n\t"
>> -              ".long 1b - ., %l[l_yes] - .\n\t"
>> -              JUMP_ENTRY_TYPE "%c0 - .\n\t"
>> -              ".popsection \n\t"
>> +     asm goto(ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
>>                 : :  "i" (&((char *)key)[branch]) : : l_yes);
>>
>>        return false;
>> diff --git a/rust/Makefile b/rust/Makefile
>> index 5c0155b83454..377e6fd68524 100644
>> --- a/rust/Makefile
>> +++ b/rust/Makefile
>> @@ -400,13 +400,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
>>        -fno-inline-functions-called-once -fsanitize=bounds-strict \
>>        -fstrict-flex-arrays=% -fmin-function-alignment=% \
>>        -fzero-init-padding-bits=% -mno-fdpic \
>> -     --param=% --param asan-% -fno-isolate-erroneous-paths-dereference
>> +     --param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
>> +     -ffixed-r2 -mmultiple -mno-readonly-in-sdata
>>
>>   # Derived from `scripts/Makefile.clang`.
>>   BINDGEN_TARGET_x86   := x86_64-linux-gnu
>>   BINDGEN_TARGET_arm64 := aarch64-linux-gnu
>>   BINDGEN_TARGET_arm   := arm-linux-gnueabi
>>   BINDGEN_TARGET_loongarch     := loongarch64-linux-gnusf
>> +BINDGEN_TARGET_powerpc       := powerpc-linux-gnu
>>   BINDGEN_TARGET_um    := $(BINDGEN_TARGET_$(SUBARCH))
>>   BINDGEN_TARGET               := $(BINDGEN_TARGET_$(SRCARCH))
>>
>> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
>> index 38b3416bb979..0054880ba0ea 100644
>> --- a/scripts/generate_rust_target.rs
>> +++ b/scripts/generate_rust_target.rs
>> @@ -188,6 +188,16 @@ fn main() {
>>           panic!("arm uses the builtin rustc target");
>>       } else if cfg.has("ARM64") {
>>           panic!("arm64 uses the builtin rustc aarch64-unknown-none target");
>> +    } else if cfg.has("PPC32") {
>> +        ts.push("arch", "powerpc");
>> +        ts.push("data-layout", "E-m:e-p:32:32-Fn32-i64:64-n32");
>> +        ts.push("features", "+soft-float");
>> +        ts.push("llvm-target", "powerpc-unknown-eabi");
>> +        if cfg.rustc_version_atleast(1, 91, 0) {
>> +            ts.push("target-pointer-width", 32);
>> +        } else {
>> +            ts.push("target-pointer-width", "32");
>> +        }
>>       } else if cfg.has("RISCV") {
>>           if cfg.has("64BIT") {
>>               panic!("64-bit RISC-V uses the builtin rustc riscv64-unknown-none-elf target");
>> --
>> 2.52.0
>>
> 


