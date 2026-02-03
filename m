Return-Path: <linuxppc-dev+bounces-16560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06439E8B36D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 22:29:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5J7D6PH3z2yFQ;
	Wed, 04 Feb 2026 09:29:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770157752;
	cv=none; b=TDxuNi4ovb7JIy+etMta5yOI1kwGCpHjbliRz1awYTicsQQg2qRRy6HRH+43Hl5D3jfjITZFt0K9sxOir1gG1de4wnUFOLhse+ud75IbnRFIzgEGdxVtwO73l9rq8igoi9FLKkmsJfXdNjzXrttM3OypZPPxvguSxgpcV6Eq61D0xcCPJotSWoe/H37Dfgt3gFlD+iC8B0AeSgnK2nKGUOOgJUKlqV9wwlW9cST5vjQtlBcXv2hhTzWX4UwKNFpxdgharvMZb+SyBElMXKo5xuJePj5CBfaRBxNxXbo+FqZEjkktMT+VBHAbV2wqFRhDjwIUW5tGaE7pVZIH4LY6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770157752; c=relaxed/relaxed;
	bh=Mcn9IlcZ31nIdqD6XJ39e/F8iEV1JgZ372/KWmM9QS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps3I0Oe77kmL8l1RZ51JME2ctMNpKuuc5BUjnKYkGrAakJY1Px456nFs1ZBvbBlqYvuu7sZigU3wBNpvyTXMHiDhJXBVV0lGqM2MKmBAYgiNWfTqWNoDRm6cJomSDMM8ScMUKmjfzbKTZ+HL7PSc9Th2p99PLl8CY1vF4BBGYp3TN/j5FOpHQqtxVrEcbjGIP7I/7MCsi1zXTwrVF5uZrq7RqPgBb+c9PrQrp1/C+Z54LgwtOeqKyszr0b7eWCYdREEFsA5bvWiGsTfrbvW/0F1FcH8n1j1Zl2z8Ry67+lfRGsJQ0wreuZ+p+SZD69eORJBRfYoubscqEmkdxPKHkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5J7C3fw4z2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 09:29:10 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 613MSbKs3677924;
	Tue, 3 Feb 2026 16:28:37 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 613MSauR3677923;
	Tue, 3 Feb 2026 16:28:36 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 3 Feb 2026 16:28:36 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc/uaccess: Fix inline assembly for clang build on
 PPC32
Message-ID: <aYJ2lGdDd041F2SY@gate>
References: <8ca3a657a650e497a96bfe7acde2f637dadab344.1770103646.git.chleroy@kernel.org>
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
In-Reply-To: <8ca3a657a650e497a96bfe7acde2f637dadab344.1770103646.git.chleroy@kernel.org>

Hi!

On Tue, Feb 03, 2026 at 08:30:41AM +0100, Christophe Leroy (CS GROUP) wrote:
> Test robot reports the following error with clang-16.0.6:
> 
>    In file included from kernel/rseq.c:75:
>    include/linux/rseq_entry.h:141:3: error: invalid operand for instruction
>                    unsafe_get_user(offset, &ucs->post_commit_offset, efault);
>                    ^
>    include/linux/uaccess.h:608:2: note: expanded from macro 'unsafe_get_user'
>            arch_unsafe_get_user(x, ptr, local_label);      \
>            ^
>    arch/powerpc/include/asm/uaccess.h:518:2: note: expanded from macro 'arch_unsafe_get_user'
>            __get_user_size_goto(__gu_val, __gu_addr, sizeof(*(p)), e); \
>            ^
>    arch/powerpc/include/asm/uaccess.h:284:2: note: expanded from macro '__get_user_size_goto'
>            __get_user_size_allowed(x, ptr, size, __gus_retval);    \
>            ^
>    arch/powerpc/include/asm/uaccess.h:275:10: note: expanded from macro '__get_user_size_allowed'
>            case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;  \
>                    ^
>    arch/powerpc/include/asm/uaccess.h:258:4: note: expanded from macro '__get_user_asm2'
>                    "       li %1+1,0\n"                    \
>                     ^
>    <inline asm>:7:5: note: instantiated into assembly here
>            li 31+1,0
>               ^
>    1 error generated.
> 
> On PPC32, for 64 bits vars a pair of registers is used. Usually the
> lower register in the pair is the high part and the higher register is
> the low part. GCC uses r3/r4 ... r11/r12 ... r14/r15 ... r30/r31
> 
> In older kernel code inline assembly was using %1 and %1+1 to represent
> 64 bits values. However here it looks like clang uses r31 as high part,
> allthough r32 doesn't exist hence the error.
> 
> Allthoug %1+1 should work, most places now use %L1 instead of %1+1, so
> let's do the same here.
> 
> With that change, the build doesn't fail anymore and a disassembly shows
> clang uses r17/r18 and r31/r14 pair when GCC would have used r16/r17 and
> r30/r31:

This does not fix the problem that somehow LLVM thinks that GPR31/FPR0
is a valid pair for two-register integer things (well, 31+1 in
assembler is not actually valid at all).  Quite worrying.

Maybe you can fix this in a more fundamental way?  In LLVM itself?

(The kernel patch of course is a nice workaround, if it in fact works
reliably, but a big fat comment here would be useful.  Pointing to the
LLVM problem report where this is tracked, etc.)


Segher

