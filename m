Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqs3j3byxzDqxw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 20:13:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Enable VMX crypto
In-Reply-To: <1468280637-11013-1-git-send-email-anton@ozlabs.org>
References: <1468280637-11013-1-git-send-email-anton@ozlabs.org>
Date: Thu, 14 Jul 2016 20:13:36 +1000
Message-ID: <87h9bsa5nz.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@ozlabs.org> writes:

> From: Anton Blanchard <anton@samba.org>
>
> We see big improvements with the VMX crypto functions (often 10x or more),
> so enable it as a module.

I can't build pseries_defconfig with this applied:

  /tmp/ccsjEdNB.s: Assembler messages:
  /tmp/ccsjEdNB.s: Error: .size expression for aes_p8_set_encrypt_key does not evaluate to a constant
  /tmp/ccsjEdNB.s: Error: .size expression for aes_p8_set_decrypt_key does not evaluate to a constant
  /tmp/ccsjEdNB.s: Error: .size expression for aes_p8_encrypt does not evaluate to a constant
  /tmp/ccsjEdNB.s: Error: .size expression for aes_p8_decrypt does not evaluate to a constant
  /tmp/ccsjEdNB.s: Error: .size expression for aes_p8_cbc_encrypt does not evaluate to a constant
  /tmp/ccsjEdNB.s: Error: .size expression for aes_p8_ctr32_encrypt_blocks does not evaluate to a constant

That's with GCC 6.1.0 / binutils 2.26.

Haven't debugged it any further.

cheers
