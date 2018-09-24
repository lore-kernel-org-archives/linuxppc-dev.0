Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JjhV3LhLzF1Rl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 22:10:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-kbuild@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to define some additional KBUILD_CFLAGS after building
 include/generated/asm-offsets.h ?
In-Reply-To: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
References: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
Date: Mon, 24 Sep 2018 22:10:29 +1000
Message-ID: <87mus75c5m.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> I'm trying to implement TLS based stack protector in the Linux Kernel.
> For that I need to give to GCC the offset at which it will find the 
> canary (register r2 is pointing to the current task struct).
>
> I have been able to do it with the below patch, but it only works when 
> include/generated/asm-offsets.h already exists from the start of the build.
>
> Is there a way to evaluate CANARY_OFFSET and add the stack-protector 
> flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is built ?
>
> Or another way of add -mstack-protector-guard-offset=offsetof(struct 
> task_struct, stack_canary) ?

This seems to work, at least I see the value in CFLAGS:

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 07d9dce..39ee113 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -404,6 +394,11 @@ archclean:
 
 archprepare: checkbin
 
+prepare: stack_protector_prepare
+
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' include/generated/asm-offsets.h))
+
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check


cheers
