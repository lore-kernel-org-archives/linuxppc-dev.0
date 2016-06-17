Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW89j1qSxzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 15:35:53 +1000 (AEST)
Message-ID: <1466141752.22370.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for
 REG_BYTE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net
Date: Fri, 17 Jun 2016 15:35:52 +1000
In-Reply-To: <6933845.bk2S1M4pvP@wuerfel>
References: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
 <6933845.bk2S1M4pvP@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-16 at 15:05 +0200, Arnd Bergmann wrote:
> On Thursday, June 16, 2016 10:33:41 PM CEST Michael Ellerman wrote:
> > From: Daniel Axtens <dja@axtens.net>
> > 
> > Sparse complains that it doesn't know what REG_BYTE is:
> > 
> >   arch/powerpc/kernel/align.c:313:29: error: undefined identifier 'REG_BYTE'
> > 
> > REG_BYTE is defined differently based on whether we're compiling for
> > LE, BE32 or BE64. Sparse apparently doesn't provide __BIG_ENDIAN__ or
> > __LITTLE_ENDIAN__, which means we get no definition.
> > 
> > Rather than check for __BIG_ENDIAN__ and then separately for
> > __LITTLE_ENDIAN__, just switch the #ifdef to check for __BIG_ENDIAN__
> > and then #else we define the little endian version. Technically that's
> > dicey because PDP_ENDIAN is also a possibility, but we already do it in
> > a lot of places so one more hardly matters.
> > 
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> That makes the code less robust for the cases that accidentally we
> have neither or both of __LITTLE_ENDIAN__/__BIG_ENDIAN__ set during
> an actual compilation.
 
True, but I already count ~30 locations where we do the #if/else check. So any
compiler that defines both or neither has zero chance of building the kernel
already, and is clearly broken IMHO.

> It would be better to fix the sparse compilation so the same endianess
> is set that you get when calling gcc.

Agree, but I don't want us to get road-blocked on that.

cheers
