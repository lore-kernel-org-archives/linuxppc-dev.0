Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbfH00McwzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 21:26:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
In-Reply-To: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
Date: Sun, 05 Mar 2017 21:26:47 +1100
Message-ID: <87pohw3tp4.fsf@concordia.ellerman.id.au>
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
> I see a panic in early boot when building with a recent gcc toolchain.
> The issue is a divide by zero, which is undefined. Older toolchains
> let us get away with it:
>
> int foo(int a) { return a / 0; }
>
> foo:
> 	li 9,0
> 	divw 3,3,9
> 	extsw 3,3
> 	blr
>
> But newer ones catch it:
>
> foo:
> 	trap
>
> Add a check to avoid the divide by zero.

Erk sorry. One of the static checkers spotted it, but I hadn't got
around to fixing it because it seemed to not actually blow up, guess
not.

cheers
