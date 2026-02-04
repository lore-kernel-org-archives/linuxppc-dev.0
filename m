Return-Path: <linuxppc-dev+bounces-16562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE001E8B37E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 00:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5LSH3JWMz2yFd;
	Wed, 04 Feb 2026 11:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770164047;
	cv=none; b=dUDppQiyq+/K7LZ0dxUVfNgzjRytq4/HMwhTmZQJzaETG6lKEqAW5zSf5gtLzGmyCX1RhKJDZtXQ4FS4Dz9URWHiHzrswlVuXIG/p1ayL5Yuveib19gF64uAsSRHYIQMEFfaDVobL3q4ldDvbREPQe74K2fdslZ9sw6g9J+UKwZmnI7r2DI7sVY2wUO+g+LXfcnSB7tkmfRjU0O7NkWY++s+6txFfs8yIAABr5Ib10IkyiR0ZdAETNskfA/+yLmUSgTjghR0LKT6ufO52eKRGIM7hG43dQtdIbKnm6UmL7Y05uzqjq1WU6ERyIau0nOcD+IAW6WxpTbx47x76NYs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770164047; c=relaxed/relaxed;
	bh=PfNOKX1Fk35pkOLEC0awZ9Kx+9oPmVLsG5sCalOXezY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0B/q8e4O9Za1sJD2J4HfwnlB5AnYKTc4uBrxR6a5g/NdZLt1TEDkcrvV9hHzIwIkhNYZdUrZxj9gLJPAPKsxMdjwTFUmyFxe9JzBdt2hOgQRJgd0XlL8MJPqRFU7wNdRf9O/34fd541ej/XcKwGmOmknsHj0WFBdyqWvWNk3Tqsfp4fBpdXw3mQgJYHeMftcEJyQ8zqzA2dSrvtFt2QqB9TIo4BbWHa9QfxDcuTQuCW8fN/6wDVK78En6L1Jldx5szKuzZHEt4UUaskzHbq2/xREY0UIDjBAYiF/7O/8HAH+UYMGHBJY2/aV4+EhM3UQ4FhdCN2VoSdKUDkracc/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5LSF6nwQz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 11:14:05 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6140DeeX3681128;
	Tue, 3 Feb 2026 18:13:40 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 6140DZ1W3681124;
	Tue, 3 Feb 2026 18:13:35 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 3 Feb 2026 18:13:35 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
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
Message-ID: <aYKPL-KME9KnRoA7@gate>
References: <8ca3a657a650e497a96bfe7acde2f637dadab344.1770103646.git.chleroy@kernel.org>
 <20260203221939.059bb903@pumpkin>
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
In-Reply-To: <20260203221939.059bb903@pumpkin>

Hi!

On Tue, Feb 03, 2026 at 10:19:39PM +0000, David Laight wrote:
> On Tue,  3 Feb 2026 08:30:41 +0100
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
> > Test robot reports the following error with clang-16.0.6:
> > 
> >    In file included from kernel/rseq.c:75:
> >    include/linux/rseq_entry.h:141:3: error: invalid operand for instruction
> >                    unsafe_get_user(offset, &ucs->post_commit_offset, efault);
> >                    ^
> >    include/linux/uaccess.h:608:2: note: expanded from macro 'unsafe_get_user'
> >            arch_unsafe_get_user(x, ptr, local_label);      \
> >            ^
> >    arch/powerpc/include/asm/uaccess.h:518:2: note: expanded from macro 'arch_unsafe_get_user'
> >            __get_user_size_goto(__gu_val, __gu_addr, sizeof(*(p)), e); \
> >            ^
> >    arch/powerpc/include/asm/uaccess.h:284:2: note: expanded from macro '__get_user_size_goto'
> >            __get_user_size_allowed(x, ptr, size, __gus_retval);    \
> >            ^
> >    arch/powerpc/include/asm/uaccess.h:275:10: note: expanded from macro '__get_user_size_allowed'
> >            case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;  \
> >                    ^
> >    arch/powerpc/include/asm/uaccess.h:258:4: note: expanded from macro '__get_user_asm2'
> >                    "       li %1+1,0\n"                    \
> >                     ^
> >    <inline asm>:7:5: note: instantiated into assembly here
> >            li 31+1,0
> >               ^
> >    1 error generated.
> > 
> > On PPC32, for 64 bits vars a pair of registers is used. Usually the
> > lower register in the pair is the high part and the higher register is
> > the low part. GCC uses r3/r4 ... r11/r12 ... r14/r15 ... r30/r31
> > 
> > In older kernel code inline assembly was using %1 and %1+1 to represent
> > 64 bits values. However here it looks like clang uses r31 as high part,
> > allthough r32 doesn't exist hence the error.
> > 
> > Allthoug %1+1 should work, most places now use %L1 instead of %1+1, so
> > let's do the same here.
> > 
> > With that change, the build doesn't fail anymore and a disassembly shows
> > clang uses r17/r18 and r31/r14 pair when GCC would have used r16/r17 and
> > r30/r31:
> 
> Isn't it all horribly worse than that?
> It only failed because clang picked r31, but if can pick two non-adjacent
> registers might it not pick any pair.
> In which case there could easily be a 64bit get_user() that reads an incorrect
> value and corrupts another register.
> Find one and you might have a privilege escalation.

I don't think LLVM is that broken, it only has problems for some edge
cases.  Yes, I might expect too much.  But without proof to the contrary
let's assume things are okay :-)

And, worrying.  But what can we do against it!  Other than never ever
use LLVM for anything serious, of course.


Segher

