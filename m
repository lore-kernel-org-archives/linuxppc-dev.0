Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCc66HBZzDqqT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:45:58 +1100 (AEDT)
In-Reply-To: <20170307003931.20568-1-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: selftests/powerpc: Replace stxvx and lxvx with their equivalent
 instruction
Message-Id: <3vjCc614RJz9s4s@ozlabs.org>
Date: Tue, 14 Mar 2017 22:45:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-07 at 00:39:31 UTC, Cyril Bur wrote:
> On POWER8 (ISA 2.07) lxvx and stxvx are defined to be extended mnemonics
> of lxvd2x and stxvd2x. For POWER9 (ISA 3.0) the HW architects in their
> infinite wisdom made lxvx and stxvx instructions in their own right.
> 
> POWER9 aware GCC will use the POWER9 instruction for lxvx and stxvx
> causing these selftests to fail on POWER8. Further compounding the
> issue, because of the way -mvsx works it will cause the power9
> instructions to be used regardless of -mcpu=power8 to GCC or -mpower8 to
> AS.
> 
> The safest way to address the problem for now is to not use the extended
> mnemonic. These tests only perform register comparisons the big endian
> only byte ordering for stxvd2x and lxvd2x does not impact the test.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Acked-by: Balbir Singh<bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/605df8d674ac65e044a0bf4998b28c

cheers
