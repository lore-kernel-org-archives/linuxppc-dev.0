Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72BD01A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 20:26:40 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Date: Wed, 21 Jan 2015 10:26:15 +0100
Message-ID: <3008920.kfIvkVJRyU@wuerfel>
In-Reply-To: <1421803659-10678-1-git-send-email-anton@samba.org>
References: <1421803659-10678-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: paulus@samba.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 21 January 2015 12:27:38 Anton Blanchard wrote:
> I noticed ksm spending quite a lot of time in memcmp on a large
> KVM box. The current memcmp loop is very unoptimised - byte at a
> time compares with no loop unrolling. We can do much much better.
> 
> Optimise the loop in a few ways:
> 
> - Unroll the byte at a time loop
> 
> - For large (at least 32 byte) comparisons that are also 8 byte
>   aligned, use an unrolled modulo scheduled loop using 8 byte
>   loads. This is similar to our glibc memcmp.
> 
> A simple microbenchmark testing 10000000 iterations of an 8192 byte
> memcmp was used to measure the performance:
> 
> baseline:	29.93 s
> 
> modified:	 1.70 s
> 
> Just over 17x faster.
> 
> v2: Incorporated some suggestions from Segher:
> 
> - Use andi. instead of rdlicl.
> 
> - Convert bdnzt eq, to bdnz. It's just duplicating the earlier compare
>   and was a relic from a previous version.
> 
> - Don't use cr5, we have plans to use that CR field for fast local
>   atomics.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Would it help to also add a way for an architecture to override
memcmp_pages() with its own implementation? That way you could
skip the unaligned part, hardcode the loop counter and avoid the
preempt_disable() in kmap_atomic().

	Arnd
