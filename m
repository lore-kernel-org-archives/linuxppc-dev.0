Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA6BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:15:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45A1207D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45A1207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Rqsh0xf0zDqS6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 21:15:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RqXJ0WvqzDqdq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 21:00:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49RqXH579jz9sV2; Wed, 20 May 2020 20:59:59 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Jordan Niethe <jniethe5@gmail.com>
In-Reply-To: <20200506034050.24806-1-jniethe5@gmail.com>
References: <20200506034050.24806-1-jniethe5@gmail.com>
Subject: Re: [PATCH v8 00/30] Initial Prefixed Instruction support
Message-Id: <158997213694.943180.2832723032553427374.b4-ty@ellerman.id.au>
Date: Wed, 20 May 2020 20:59:59 +1000 (AEST)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alistair@popple.id.au, naveen.n.rao@linux.vnet.ibm.com, dja@axtens.net,
 npiggin@gmail.com, bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 6 May 2020 13:40:20 +1000, Jordan Niethe wrote:
> A future revision of the ISA will introduce prefixed instructions. A
> prefixed instruction is composed of a 4-byte prefix followed by a
> 4-byte suffix.
> 
> All prefixes have the major opcode 1. A prefix will never be a valid
> word instruction. A suffix may be an existing word instruction or a
> new instruction.
> 
> [...]

Applied to powerpc/next.

[01/30] powerpc/xmon: Remove store_inst() for patch_instruction()
        https://git.kernel.org/powerpc/c/802268fd82676ffce432776f60b93a0b15e58e0c
[02/30] powerpc/xmon: Move breakpoint instructions to own array
        https://git.kernel.org/powerpc/c/51c9ba11f17f25ace1ea6bbfd4586c59105432de
[03/30] powerpc/xmon: Move breakpoints to text section
        https://git.kernel.org/powerpc/c/4eff2b4f32a309e2171bfe53db3e93b5614f77cb
[04/30] powerpc/xmon: Use bitwise calculations in_breakpoint_table()
        https://git.kernel.org/powerpc/c/5a7fdcab54ef17c395fc47e73c828a1432e51683
[05/30] powerpc: Change calling convention for create_branch() et. al.
        https://git.kernel.org/powerpc/c/7c95d8893fb55869882c9f68f4c94840dc43f18f
[06/30] powerpc: Use a macro for creating instructions from u32s
        https://git.kernel.org/powerpc/c/753462512868674a788ecc77bb96752efb818785
[07/30] powerpc: Use an accessor for instructions
        https://git.kernel.org/powerpc/c/777e26f0edf8dab58b8dd474d35d83bde0ac6d76
[08/30] powerpc: Use a function for getting the instruction op code
        https://git.kernel.org/powerpc/c/8094892d1aff14269d3b7bfcd8b941217eecd81f
[09/30] powerpc: Use a function for byte swapping instructions
        https://git.kernel.org/powerpc/c/aabd2233b6aefeee6d7a2f667076d8346be1d30a
[10/30] powerpc: Introduce functions for instruction equality
        https://git.kernel.org/powerpc/c/217862d9b98bf08958d57fd7b31b9de0f1a9477d
[11/30] powerpc: Use a datatype for instructions
        https://git.kernel.org/powerpc/c/94afd069d937d84fb4f696eb9a78db4084e43d21
[12/30] powerpc: Use a function for reading instructions
        https://git.kernel.org/powerpc/c/f8faaffaa7d99028e457ef2d1dcb43a98f736938
[13/30] powerpc: Add a probe_user_read_inst() function
        https://git.kernel.org/powerpc/c/7ba68b2172c19031fdc2a2caf37328edd146e299
[14/30] powerpc: Add a probe_kernel_read_inst() function
        https://git.kernel.org/powerpc/c/95b980a00d1220ca67550a933166704db8bc5c14
[15/30] powerpc/kprobes: Use patch_instruction()
        https://git.kernel.org/powerpc/c/a8646f43ba5046e7f5c4396125d5136bfcb17b49
[16/30] powerpc: Define and use get_user_instr() et. al.
        https://git.kernel.org/powerpc/c/5249385ad7f0ac178433f0ae9cc5b64612c8ff77
[17/30] powerpc: Introduce a function for reporting instruction length
        https://git.kernel.org/powerpc/c/622cf6f436a12338bbcfbb3474629755547fd112
[18/30] powerpc/xmon: Use a function for reading instructions
        https://git.kernel.org/powerpc/c/6c7a4f0a9f66fc7fdc6e208559e5d562f53e0991
[19/30] powerpc/xmon: Move insertion of breakpoint for xol'ing
        https://git.kernel.org/powerpc/c/7fccfcfba04f9cb46438f368755d368f6c57f3a0
[20/30] powerpc: Make test_translate_branch() independent of instruction length
        https://git.kernel.org/powerpc/c/0b582db5490a1f250ef63337dd46d5c7599dae80
[21/30] powerpc: Enable Prefixed Instructions
        https://git.kernel.org/powerpc/c/2aa6195e43b3740258ead93aee42ac719dd4c4b0
[22/30] powerpc: Define new SRR1 bits for a ISA v3.1
        https://git.kernel.org/powerpc/c/b691505ef9232a6e82f1c160911afcb4cb20487b
[23/30] powerpc: Add prefixed instructions to instruction data type
        https://git.kernel.org/powerpc/c/650b55b707fdfa764e9f2b81314d3eb4216fb962
[24/30] powerpc: Test prefixed code patching
        https://git.kernel.org/powerpc/c/f77f8ff7f13e6411c2e0ba25bb7e012a5ae6c927
[25/30] powerpc: Test prefixed instructions in feature fixups
        https://git.kernel.org/powerpc/c/785b79d1e02873c2088ee1301154c66dace66ce5
[26/30] powerpc/xmon: Don't allow breakpoints on suffixes
        https://git.kernel.org/powerpc/c/c9c831aebd8663d0129bbcee4d76be889f0627fe
[27/30] powerpc/kprobes: Don't allow breakpoints on suffixes
        https://git.kernel.org/powerpc/c/b4657f7650babc9bfb41ce875abe41b18604a105
[28/30] powerpc: Support prefixed instructions in alignment handler
        https://git.kernel.org/powerpc/c/9409d2f9dad2f0679d67dc24d8116dd3e837b035
[29/30] powerpc sstep: Add support for prefixed load/stores
        https://git.kernel.org/powerpc/c/50b80a12e4ccff46d53b93754d817acd98bc9ae0
[30/30] powerpc sstep: Add support for prefixed fixed-point arithmetic
        https://git.kernel.org/powerpc/c/3920742b92f5ea19a220edb947b6f33c99f501da

cheers
