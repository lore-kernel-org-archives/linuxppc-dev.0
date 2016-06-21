Return-Path: <dja@axtens.net>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYV6j5GswzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:11:25 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id ts6so107728pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 18:11:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for
 REG_BYTE
In-Reply-To: <7459954.Ax6T6W22CJ@wuerfel>
References: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
 <6933845.bk2S1M4pvP@wuerfel> <8760t8mqrc.fsf@possimpible.ozlabs.ibm.com>
 <7459954.Ax6T6W22CJ@wuerfel>
Date: Tue, 21 Jun 2016 11:11:18 +1000
Message-ID: <871t3rmjm1.fsf@possimpible.ozlabs.ibm.com>
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

Hi Arnd,

> Something like the (untested) patch below, similar to how we
> already handle the word size and how some other architectures
> handle setting __BIG_ENDIAN__.

I tested this by reverting Michael's patch and applying yours.

Not only does it successfully fix the errors that patch fixes, it
manages to clean up the following four errors as well:

+/scratch/dja/linux/arch/powerpc/lib/sstep.c:371:32: error: cast from unknown type
+/scratch/dja/linux/arch/powerpc/lib/sstep.c:371:59: error: using member 'word' in incomplete struct <unnamed>
+/scratch/dja/linux/arch/powerpc/lib/sstep.c:411:32: error: cast from unknown type
+/scratch/dja/linux/arch/powerpc/lib/sstep.c:411:59: error: using member 'word' in incomplete struct <unnamed>

So:
Tested-by: Daniel Axtens <dja@axtens.net>

(I think the patch also needs your sign-off.)

Regards,
Daniel
