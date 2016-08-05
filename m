Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5HXl3BkgzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:51:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: crc32c-vpmsum - Convert to CPU feature based
 module autoloading
In-Reply-To: <20160804202601.12aa879e@kryten>
References: <1470292695-9829-1-git-send-email-anton@ozlabs.org>
 <87lh0dexp3.fsf@concordia.ellerman.id.au> <20160804202601.12aa879e@kryten>
Date: Fri, 05 Aug 2016 16:51:51 +1000
Message-ID: <87y44biu7s.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@samba.org> writes:

> Hi Michael,
>
>> Is VEC_CRYPTO the right feature?
>> 
>> That's new power8 crypto stuff.
>
> The vpmsum* instructions are part of the same pipeline as the vcipher*
> instructions, introduced in POWER8.

OK.

>> I thought this only used VMX? (but I haven't looked closely)
>
> Yes, vcipher* and vpmsum* are VMX instructions.

Right. The confusion is that we have PPC_FEATURE_HAS_ALTIVEC, but that
doesn't mean we have *these* VMX instructions.

This is actually an arch/powerpc patch, so I'll merge it unless Herbert
objects.

cheers
