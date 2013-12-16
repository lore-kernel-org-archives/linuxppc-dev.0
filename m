Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix bad stack check in exception entry
Date: Mon, 16 Dec 2013 15:12:43 +1100
Message-ID: <15350.1387167163@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In EXCEPTION_PROLOG_COMMON() we check to see if the stack pointer (r1)
is valid when coming from the kernel.  If it's not valid, we die but
with a nice oops message.

Currently we allocate a stack frame (subtract INT_FRAME_SIZE) before we
check to see if the stack pointer is negative.  Unfortunately, this
won't detect a bad stack where r1 is less than INT_FRAME_SIZE.

This patch fixes the check to compare the modified r1 with
-INT_FRAME_SIZE.  With this, bad kernel stack pointers (including NULL
pointers) are correctly detected again.

Kudos to Paulus for finding this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@vger.kernel.org

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 894662a..243ce69 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -284,7 +284,7 @@ do_kvm_##n:								\
 	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack	*/ \
 	beq-	1f;							   \
 	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
-1:	cmpdi	cr1,r1,0;		/* check if r1 is in userspace	*/ \
+1:	cmpdi	cr1,r1,-INT_FRAME_SIZE;	/* check if r1 is in userspace	*/ \
 	blt+	cr1,3f;			/* abort if it is		*/ \
 	li	r1,(n);			/* will be reloaded later	*/ \
 	sth	r1,PACA_TRAP_SAVE(r13);					   \
