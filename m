Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41961Z2hZMzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 21:58:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: stacktrace.c:(.text+0x1b0): undefined reference to
 `.smp_send_safe_nmi_ipi'
In-Reply-To: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
References: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
Date: Tue, 19 Jun 2018 21:58:40 +1000
Message-ID: <87lgbbxa1b.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> See http://kisskb.ellerman.id.au/kisskb/buildresult/13395345/ for details
>
> Seems like that function only exists when CONFIG_NMI_IPI is defined.
>
> Problem introduced by commit 5cc05910f26e6fd6da15f052f86f6150e4b91664 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/kernel/stacktrace.c?h=next-20180614&id=5cc05910f26e6fd6da15f052f86f6150e4b91664
>
>
> What do you recommend to fix that ?

It should just use CONFIG_NMI_IPI instead of CONFIG_PPC_BOOK3S_64 I
think.

I'll do a patch.

cheers
