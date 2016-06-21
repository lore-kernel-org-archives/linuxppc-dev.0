Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRX6fpWzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:56 +1000 (AEST)
In-Reply-To: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: dja@axtens.net
Subject: Re: powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for REG_BYTE
Message-Id: <3rYTRX1Xsxz9t1f@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-16-06 at 12:33:41 UTC, Michael Ellerman wrote:
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

Applied to powerpc next.

https://git.kernel.org/powerpc/c/a9650e9bc53239c30c39f77d9d

cheers
