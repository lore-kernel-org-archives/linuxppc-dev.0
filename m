Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41JR8C2KTBzF1Gt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jul 2018 20:14:51 +1000 (AEST)
Subject: Patch "powerpc/e500mc: Set assembler machine type to e500mc" has been
 added to the 4.17-stable tree
To: benh@kernel.crashing.org, galak@kernel.crashing.org,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 mathieu.desnoyers@efficios.com, mjeanson@efficios.com, mpe@ellerman.id.au,
 paulus@samba.org, swood@redhat.com, vakul.garg@nxp.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 01 Jul 2018 12:09:25 +0200
Message-ID: <15304397655494@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    powerpc/e500mc: Set assembler machine type to e500mc

to the 4.17-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-e500mc-set-assembler-machine-type-to-e500mc.patch
and it can be found in the queue-4.17 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 69a8405999aa1c489de4b8d349468f0c2b83f093 Mon Sep 17 00:00:00 2001
From: Michael Jeanson <mjeanson@efficios.com>
Date: Thu, 14 Jun 2018 11:27:42 -0400
Subject: powerpc/e500mc: Set assembler machine type to e500mc

From: Michael Jeanson <mjeanson@efficios.com>

commit 69a8405999aa1c489de4b8d349468f0c2b83f093 upstream.

In binutils 2.26 a new opcode for the "wait" instruction was added for the
POWER9 and has precedence over the one specific to the e500mc. Commit
ebf714ff3756 ("powerpc/e500mc: Add support for the wait instruction in
e500_idle") uses this instruction specifically on the e500mc to work around
an erratum.

This results in an invalid instruction in idle_e500 when we build for the
e500mc on bintutils >= 2.26 with the default assembler machine type.

Since multiplatform between e500 and non-e500 is not supported, set the
assembler machine type globaly when CONFIG_PPC_E500MC=y.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Vakul Garg <vakul.garg@nxp.com>
CC: Scott Wood <swood@redhat.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
CC: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -251,6 +251,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)


Patches currently in stable-queue which might be from mjeanson@efficios.com are

queue-4.17/powerpc-e500mc-set-assembler-machine-type-to-e500mc.patch
