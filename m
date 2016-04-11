Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fV2YsYzDqBR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:14 +1000 (AEST)
In-Reply-To: <1456899165-21624-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/swsusp: Only use tlbie in POWER4 mode
Message-Id: <3qk8fV0pgyz9t5h@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-03 at 06:12:45 UTC, Russell Currey wrote:
> If CONFIG_HIBERNATION and CONFIG_PPC_BOOK3S_64 are set, code in
> arch/powerpc/kernel/swsusp_amd64.S which uses the tlbia macro is enabled.
> tlbia in turn uses tlbie, an instruction which takes more than one
> operand in newer versions of POWER.  As such, the kernel fails to build
> due to the assembler complaining about missing operands.
> 
> This can be worked around by assembling the instruction as in POWER4.
> This fixes the build breakage caused by enabling CONFIG_HIBERNATION.
> Hibernation is currently only tested on G5 PowerMacs, which should be
> unaffected by this change.  For other platforms it may now build,
> whether or not it works is a different story.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e3824e4281b8e31d55c08a06b2

cheers
