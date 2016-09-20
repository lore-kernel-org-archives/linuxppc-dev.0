Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhs17vjzDsgC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:25 +1000 (AEST)
In-Reply-To: <1473900020-3281-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc: Don't change the section in _GLOBAL()
Message-Id: <3sdjhr3bcRz9t0q@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-15-09 at 00:40:20 UTC, Michael Ellerman wrote:
> Currently the _GLOBAL() macro unilaterally sets the assembler section to
> ".text" at the start of the macro. This is rude as the caller may be
> using a different section.
> 
> So let the caller decide which section to emit the code into. On big
> endian we do need to switch to the ".opd" section to emit the OPD, but
> do that with pushsection/popsection, thereby leaving the original
> section intact.
> 
> The only place I could find where this requires changes to the code is
> in misc_32.S, where we need to switch back to ".text" after
> flush_icache_range() which is in ".kprobes.text".
> 
> I verified that the order of all entries in System.map is unchanged
> after this patch. The actual addresses shift around slightly so you
> can't just diff the System.map.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/bea2dccccfd47ef3f8612f1265

cheers
