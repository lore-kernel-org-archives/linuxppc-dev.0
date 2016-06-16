Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVlN10X08zDqpJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 23:58:24 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 dja@axtens.net
Subject: Re: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for
 REG_BYTE
Date: Thu, 16 Jun 2016 15:05:31 +0200
Message-ID: <6933845.bk2S1M4pvP@wuerfel>
In-Reply-To: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
References: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, June 16, 2016 10:33:41 PM CEST Michael Ellerman wrote:
> From: Daniel Axtens <dja@axtens.net>
> 
> Sparse complains that it doesn't know what REG_BYTE is:
> 
>   arch/powerpc/kernel/align.c:313:29: error: undefined identifier 'REG_BYTE'
> 
> REG_BYTE is defined differently based on whether we're compiling for
> LE, BE32 or BE64. Sparse apparently doesn't provide __BIG_ENDIAN__ or
> __LITTLE_ENDIAN__, which means we get no definition.
> 
> Rather than check for __BIG_ENDIAN__ and then separately for
> __LITTLE_ENDIAN__, just switch the #ifdef to check for __BIG_ENDIAN__
> and then #else we define the little endian version. Technically that's
> dicey because PDP_ENDIAN is also a possibility, but we already do it in
> a lot of places so one more hardly matters.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 

That makes the code less robust for the cases that accidentally we
have neither or both of __LITTLE_ENDIAN__/__BIG_ENDIAN__ set during
an actual compilation.

It would be better to fix the sparse compilation so the same endianess
is set that you get when calling gcc.

	Arnd
