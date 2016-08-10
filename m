Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8QvS5SyjzDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:33:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c $SRR1:
 00003030
In-Reply-To: <1470813494.3015.92.camel@kernel.crashing.org>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
 <1470813494.3015.92.camel@kernel.crashing.org>
Date: Wed, 10 Aug 2016 19:33:55 +1000
Message-ID: <87y445rmrg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> It's all the jump label cruft that landed in=C2=A0apply_feature_fixups()
>
> You can't call random call there. On ppc32, it's running in that
> weirdo environment where the kernel isn't running at its linked
> address and we need to manually RELOC() everything.

Crud. My qemu-mac99 boot test should have caught it, but of course
pmac32 defconfig doesn't enable JUMP_LABEL >:E

> I'm moving them to a separate init call, patch on its way...

Thanks.

cheers
