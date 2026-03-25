Return-Path: <linuxppc-dev+bounces-18763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4667FFEA82E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 08:30:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgg8d6N2lz2xMt;
	Wed, 25 Mar 2026 19:30:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774427441;
	cv=none; b=BewrXIHqsZzKs6v0kCdK9ZrziDq1wgiRdhvjAbjYwK6rt9mrRNOrhCsoDGY7vYrNJq9sbBhRatoY8CJr+rsvZBuTFjMuEYRUVLd6il8m4SwD0g0r08fHTAzI20PmmHR4sgb5yVmCQRT5aqyerwmg7XbrJXQ3PSgIQuyccTI2fyr8jv3KdUP3py7Ez6Ku5kN9XSVRLmvHVBf1TcTbxvdvd0us8hsFTy15ifSEBRZ+NKQ1HSXgPk61jaXVWSw5jNiRdrZlxJLE6YHYoF4sjDkvhOakIgb1tertBbjHinV+NyNzlGKbR5jHlS5Hb5FJUS5BjRt+2WwZIN8EjYwGOacYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774427441; c=relaxed/relaxed;
	bh=3VVDtEETY7KfkG+CO4MxjYVFgUcOQBgmEvlZEgP0fJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwOnqbPiXXwwLN8ImvczPKpM5hno53sY8gkrIHPBiapgl4z8ezzCL4Wd1/vuvIYuqinKiO7xQGyj5hLPM1BVy3XTi7oPYeh6iwFHi8RaXJ92K4IyvlzA5mr/dESrXyi+BargNyjNK59Q3UMaZbv1omje0ZWtoPUE/T8bx7x4OsSPqGsaW8oC+mECO8WL49uSzHJVKmMiilyy0OKRx91YcWx+UIjGNqBblG20BP8VFVuT8clH4zWUDB76yYFApzakdR1tqAvD7W2DjOGvEYN5AS24SUcZsroQBuvq+CdtK8fIJ3gkZZzRgMGIwMgskR6xiE7lGTptuQJpWAV8T1mHHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eLqVVxuy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eLqVVxuy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgg8c1zdvz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 19:30:39 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P6mOGk3909095;
	Wed, 25 Mar 2026 08:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3VVDtE
	ETY7KfkG+CO4MxjYVFgUcOQBgmEvlZEgP0fJ0=; b=eLqVVxuymeqMuefaRDAqy/
	YgQhr+xmy4lAPk7FHHMMdgKQeBVIoWO+USRdM1oztNAnob42KjoFT58Jl7qNlWgO
	hmhcs+DSrQfp156058SbKGr5Rjwv2ovRwNYKmu6hXyDadH88XWB/ezVyElC9D0yd
	DpU3No3dKc20XDclDLI+ABRscc5zHPgOA3sdeoZQwTlRptQIgi1827NDlmv7JR2F
	z9bMn/x5Vs108eR1Jv1kH88ncZSHZm03mo8GR2CB/D1wEDtJYsadUtosKApJz6v4
	UvlOfc7iKH+iSFakmHNCb3cdO+DGOzu20OvsZWOjPOJadvjwg5tS/sGZcyJmbMng
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9yg7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 08:30:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P75Nh1011788;
	Wed, 25 Mar 2026 08:30:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk5gm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 08:30:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P8U4H441222770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 08:30:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 815BD58068;
	Wed, 25 Mar 2026 08:30:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB63858050;
	Wed, 25 Mar 2026 08:29:56 +0000 (GMT)
Received: from [9.123.105.69] (unknown [9.123.105.69])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 08:29:56 +0000 (GMT)
Message-ID: <51269463-8538-4149-a3f3-156a5c4d49b4@linux.ibm.com>
Date: Wed, 25 Mar 2026 13:59:55 +0530
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
Subject: Re: [PATCH V6 0/3] Rust support for powerpc
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
        dakr@kernel.org, corbet@lwn.net, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260210090023.2587534-1-mkchauras@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260210090023.2587534-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DuxC49ffXeDzMh9GcJ8zPKcvw_fFlPsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1OCBTYWx0ZWRfXzWwf8HbM6TEi
 6pNuduYVzOl8gVy1k36TvoNLj6PBeQ+LSmH+ko794D8vLH5fL6d/XSk9VH0Q0STYtkqE80clRJS
 cJ/21n+9L58qv8PkawTu7RKxOWHLWq+GQ28EUydsnf1nAZsOSMpFsPPzE51i5XO+Xd0a4U0RBQB
 sDNzAERyrVLg4hqnNYBk0dR16ngicwov2gZqCo9R/MljDS4+qwwBTqaGMuhZdoVHxoYOKwFZ+fD
 8oUifAb+5WRw3IMgTxtyEmxHeB4fu8A+4wqEhsKS5n8OigTDESwFmVzJFyn9DVHuzPkyPaIgFWb
 dg0Isnq0TLj801ne23e8yC/7AimXar3zZac4Fr5zagV9dgaZtyTGnrA3dFn/ZJrctKAzL6q1GK/
 0bAmtBX3ZYxR+fopBrVlxPnE907b1ri4Vl2c+siPBpsk+VqUAjSU58Gz4LNhLk46jQht8H0+Su0
 wqhnu5BjNdTEbh2wTxQ==
X-Proofpoint-GUID: 82ooPIboFTQ48VRuaoPs4kN_IPrHg4aB
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c39d0e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=9aSCi7NS6l8dOKvLHDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250058


On 2/10/26 2:30 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enable experimental rust support for ppc64le and ppc32be. The patch for
> ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> `rust: Add PowerPC support` and the discussion for that is done here[1].
>
> This has been tested on powernv9 hardware and power10 pseries qemu. I
> I request Link to test the ppc32 part as i don't have a hardware to test
> it out.
>
> [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
> [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com

Could see these build issues with the Rust patchset in the compilation 
of powerpc-next-test
This happens when compilation happens only with few threads

# rustc --version
rustc 1.94.0 (4a4ef493e 2026-03-02)

....
   EXPORTS rust/exports_core_generated.h
   BINDGEN rust/bindings/bindings_generated.rs
   BINDGEN rust/bindings/bindings_helpers_generated.rs
   CC      rust/helpers/helpers.o
   EXPORTS rust/exports_helpers_generated.h
   RUSTC L rust/compiler_builtins.o
   RUSTC L rust/ffi.o
   RUSTC PL rust/libproc_macro2.rlib
error[E0464]: multiple candidates for `rmeta` dependency `core` found
  --> rust/proc-macro2/marker.rs:4:5
   |
4 | use core::marker::PhantomData;
   |     ^^^^
   |
   = note: candidate #1: 
/root/.rustup/toolchains/nightly-powerpc64le-unknown-linux-gnu/lib/rustlib/powerpc64le-unknown-linux-gnu/lib/libcore-951759db375eea0c.rmeta
   = note: candidate #2: ./rust/libcore.rmeta

error[E0119]: conflicting implementations of trait `PartialEq` for type 
`fallback::Ident`
    --> rust/proc-macro2/fallback.rs:875:1
     |
869 |   impl PartialEq for Ident {
     |   ------------------------ first implementation here
...
875 | / impl<T> PartialEq<T> for Ident
876 | | where
877 | |     T: ?Sized + AsRef<str>,
     | |___________________________^ conflicting implementation for 
`fallback::Ident`

error[E0277]: `LexError` doesn't implement `std::fmt::Display`
    --> rust/proc-macro2/lib.rs:347:16
     |
347 | impl Error for LexError {}
     |                ^^^^^^^^ unsatisfied trait bound
     |
help: the trait `std::fmt::Display` is not implemented for `LexError`
    --> rust/proc-macro2/lib.rs:204:1
     |
204 | pub struct LexError {
     | ^^^^^^^^^^^^^^^^^^^
note: required by a bound in `std::error::Error`
    --> 
/root/.rustup/toolchains/nightly-powerpc64le-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/error.rs:59:26
     |
  59 | pub trait Error: Debug + Display {
     |                          ^^^^^^^ required by this bound in `Error`

error[E0277]: `LexError` doesn't implement `Debug`
    --> rust/proc-macro2/lib.rs:347:16
     |
347 | impl Error for LexError {}
     |                ^^^^^^^^ unsatisfied trait bound
     |
help: the trait `Debug` is not implemented for `LexError`
    --> rust/proc-macro2/lib.rs:204:1
     |
204 | pub struct LexError {
     | ^^^^^^^^^^^^^^^^^^^
     = note: add `#[derive(Debug)]` to `LexError` or manually `impl 
Debug for LexError`
note: required by a bound in `std::error::Error`
    --> 
/root/.rustup/toolchains/nightly-powerpc64le-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/error.rs:59:18
     |
  59 | pub trait Error: Debug + Display {
     |                  ^^^^^ required by this bound in `Error`

error: aborting due to 4 previous errors

......
But when parallelized with more threads (-j 128) compilation passes with 
out any error
There is some ordering of libcore is messing up I guess (I could be wrong)
(I have removed the warning of unstable features messages here for 
cleaner output)

....
   VDSO64SYM include/generated/vdso64-offsets.h
   RUSTC L rust/core.o
   BINDGEN rust/bindings/bindings_generated.rs
   BINDGEN rust/bindings/bindings_helpers_generated.rs
   CC      rust/helpers/helpers.o
   RUSTC PL rust/libproc_macro2.rlib
   BINDGEN rust/uapi/uapi_generated.rs
   RSCPP     rust/kernel/generated_arch_static_branch_asm.rs
   RSCPP     rust/kernel/generated_arch_warn_asm.rs
   RSCPP     rust/kernel/generated_arch_reachable_asm.rs
clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:5:9: warning: 
'_IOC_SIZEBITS' macro redefined [-Wmacro-redefined]
clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:6:9: warning: 
'_IOC_DIRBITS' macro redefined [-Wmacro-redefined]
clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:8:9: warning: 
'_IOC_NONE' macro redefined [-Wmacro-redefined]
clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:10:9: warning: 
'_IOC_WRITE' macro redefined [-Wmacro-redefined]
   EXPORTS rust/exports_helpers_generated.h
   RUSTC PL rust/libquote.rlib
   RUSTC PL rust/libsyn.rlib
   RUSTC P rust/libpin_init_internal.so
   RUSTC P rust/libmacros.so
   EXPORTS rust/exports_core_generated.h
   RUSTC L rust/compiler_builtins.o
   RUSTC L rust/ffi.o
   RUSTC L rust/pin_init.o
   RUSTC L rust/build_error.o
   RUSTC L rust/bindings.o
   RUSTC L rust/uapi.o
   EXPORTS rust/exports_bindings_generated.h
   RUSTC L rust/kernel.o
   EXPORTS rust/exports_kernel_generated.h
   LDS     scripts/module.lds
   HOSTCC  usr/gen_init_cpio
   CC      init/main.o
....

Also I see some errors when compiling modules. I am looking at these and 
any help is welcome.
I will pull out Rust patches for now from powerpc-linux next-test branch 
and once this is
restored I will add these patches back to branch for the merge.

Maddy

> Changelog:
> V5 -> V6:
> - Added a missing Tested by from Venkat which got missed since V3
> - Support is marked as Maintained instead of experimental
> V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com
>
> V4 -> V5:
> - Removed a nested ifdef from PPC64 for Little endian toolchain
> V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com
>
> V3 -> V4:
> - Co-developed-by header added in patch 1
> V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com
>
> V2 -> V3:
> - Splited HAVE_RUST in 2 lines
> - BINDGEN_TARGET_powerpc initialized before assigning the same to
>    BINDGEN_TARGET
> V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com
>
> V1 -> V2:
> - jump label fix for rust has been moved to a separate patch
> - PPC32 support has been taken
> - rust support has been marked experimental
> - target.json dependency has been removed
> - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
>
>
> Link Mauve (1):
>    rust: Add PowerPC support
>
> Mukesh Kumar Chaurasiya (IBM) (2):
>    powerpc/jump_label: adjust inline asm to be consistent
>    powerpc: Enable Rust for ppc64le
>
>   Documentation/rust/arch-support.rst   |  1 +
>   arch/powerpc/Kconfig                  |  2 ++
>   arch/powerpc/Makefile                 |  7 +++++++
>   arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
>   rust/Makefile                         | 10 +++++++++-
>   5 files changed, 32 insertions(+), 11 deletions(-)
>

