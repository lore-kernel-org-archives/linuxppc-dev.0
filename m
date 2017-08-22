Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcS1C4qCkzDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 09:48:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xcS1C2rD5z9s9Y
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2017 09:48:15 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 0/7] powerpc: Beef up single-stepping/instruction
 emulation infrastructure
Date: Wed, 23 Aug 2017 09:47:56 +1000
Message-Id: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series extends the code in arch/powerpc/lib/sstep.c so that
it handles almost all load and store instructions -- all except the
atomic memory operations (lwat, stwat, etc.).  It also makes sure that
we use the largest possible aligned accesses to access memory and that
we don't access the CPU FP/VMX/VSX registers when they don't contain
user data.

With this, it should be possible to replace the body of the alignment
interrupt handler with a call to emulate_step() or something quite
similar.

Paul.

 arch/powerpc/include/asm/sstep.h |   73 +-
 arch/powerpc/lib/Makefile        |    2 +-
 arch/powerpc/lib/ldstfp.S        |  305 ++-----
 arch/powerpc/lib/quad.S          |   62 ++
 arch/powerpc/lib/sstep.c         | 1773 +++++++++++++++++++++++++++++---------
 5 files changed, 1564 insertions(+), 651 deletions(-)
