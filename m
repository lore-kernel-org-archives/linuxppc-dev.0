Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWH2S5yBfzDqrW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 20:45:04 +1000 (AEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rWH2R42Pjz9t2F
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 20:45:02 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for
 REG_BYTE
Date: Fri, 17 Jun 2016 12:46:44 +0200
Message-ID: <7459954.Ax6T6W22CJ@wuerfel>
In-Reply-To: <8760t8mqrc.fsf@possimpible.ozlabs.ibm.com>
References: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
 <6933845.bk2S1M4pvP@wuerfel> <8760t8mqrc.fsf@possimpible.ozlabs.ibm.com>
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

On Friday, June 17, 2016 1:35:35 PM CEST Daniel Axtens wrote:
> > It would be better to fix the sparse compilation so the same endianess
> > is set that you get when calling gcc.
> 
> I will definitely work on a patch to sparse! I'd still like this or
> something like it to go in though, so we can keep working on reducing
> the sparse warning count while the sparse patch is in the works.

I think you just need to fix the Makefile so it sets the right
arguments when calling sparse.

Something like the (untested) patch below, similar to how we
already handle the word size and how some other architectures
handle setting __BIG_ENDIAN__.

	Arnd

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 709a22a3e824..8617c71c3bdb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -181,6 +181,11 @@ KBUILD_CFLAGS	+= -pipe -Iarch/$(ARCH) $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
+ifdef CONFIG_CPU_BIG_ENDIAN
+CHECKFLAGS	+= -D__BIG_ENDIAN__
+else
+CHECKFLAGS	+= -D__LITTLE_ENDIAN__
+endif
 
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 
