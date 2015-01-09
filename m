Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D5C11A0F48
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 22:01:40 +1100 (AEDT)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Fri, 9 Jan 2015 09:01:34 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 334A91DC0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 06:00:36 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t09B1djg4460626
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jan 2015 09:01:40 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t09B1Uu1011314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jan 2015 09:01:30 -0200
Received: from [9.18.199.103] (acfaria.br.ibm.com [9.18.199.103] (may be
 forged))
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t09B1UQf011287
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jan 2015 09:01:30 -0200
Message-ID: <54AFB509.8060808@linux.vnet.ibm.com>
Date: Fri, 09 Jan 2015 09:01:29 -0200
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
References: <1420768591-6831-1-git-send-email-anton@samba.org>
In-Reply-To: <1420768591-6831-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08-01-2015 23:56, Anton Blanchard wrote:
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
> Signed-off-by: Anton Blanchard <anton@samba.org>
>
Why not use glibc implementations instead? All of them (ppc64, power4, and
power7) avoids use byte at time compares for unaligned cases inputs; while
showing the same performance for aligned one than this new implementation.
To give you an example, a 8192 bytes compare with input alignment of 63/18
shows:

__memcmp_power7:  320 cycles
__memcmp_power4:  320 cycles
__memcmp_ppc64:   340 cycles
this memcmp:     3185 cycles
