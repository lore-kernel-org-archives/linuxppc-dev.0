Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdrDV3hLRzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 16:02:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xdrDV1wlrz9sR9
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2017 16:02:50 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/10] powerpc: Beef up single-stepping/instruction
 emulation infrastructure
Date: Fri, 25 Aug 2017 15:41:52 +1000
Message-Id: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
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
user data.  With this, it should be possible to replace the body of
the alignment interrupt handler with a call to emulate_step() or
something quite similar.

This version is based on the powerpc tree next branch as of a day or
two ago, and includes code to emulate addpcis, a fix for the isel
emulation, code to handle the multi-register loads and stores in
little-endian mode, and a fix for the wrong behaviour in updating RA
for load/store with update instructions in 32-bit mode.

Paul.

 arch/powerpc/include/asm/sstep.h |   77 +-
 arch/powerpc/lib/Makefile        |    2 +-
 arch/powerpc/lib/ldstfp.S        |  307 ++----
 arch/powerpc/lib/quad.S          |   62 ++
 arch/powerpc/lib/sstep.c         | 1929 ++++++++++++++++++++++++++++----------
 5 files changed, 1654 insertions(+), 723 deletions(-)
