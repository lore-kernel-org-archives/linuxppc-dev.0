Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNmx5PK5zDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:06:09 +1000 (AEST)
In-Reply-To: <20180717005038.32352-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: malat@debian.org
Subject: Re: powerpc/xmon: Fix disassembly since printf changes
Message-Id: <41WNmx3qS6z9s4r@ozlabs.org>
Date: Thu, 19 Jul 2018 16:06:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-17 at 00:50:38 UTC, Michael Ellerman wrote:
> The recent change to add printf annotations to xmon inadvertently made
> the disassembly output ugly, eg:
> 
>   c00000002001e058  7ee00026      mfcr    r23
>   c00000002001e05c  fffffffffae101a0      std     r23,416(r1)
>   c00000002001e060  fffffffff8230000      std     r1,0(r3)
> 
> The problem being that negative 32-bit values are being displayed in
> full 64-bits.
> 
> The printf conversion was actually correct, we are passing unsigned
> long so it should use "lx". But powerpc instructions are only 4 bytes
> and the code only reads 4 bytes, so inst should really just be
> unsigned int, and that also fixes the printing to look the way we
> want:
> 
>   c00000002001e058  7ee00026      mfcr    r23
>   c00000002001e05c  fae101a0      std     r23,416(r1)
>   c00000002001e060  f8230000      std     r1,0(r3)
> 
> Fixes: e70d8f55268b ("powerpc/xmon: Add __printf annotation to xmon_printf()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/941d810725ad48cc21948f4cff8cf7

cheers
