Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17530.10536.360165.757328@cargo.ozlabs.ibm.com>
Date: Mon, 29 May 2006 08:50:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch again
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do another pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Guennadi Liakhovetski pointed out a typo in arch/ppc/kernel/asm-offsets.c
that really should be fixed for 2.6.17, so here is a commit to fix
it.  The patch and commit message are below.

Thanks,
Paul.

commit b82e8005af14b51600714971e0c6420c4e334a50
Author: Paul Mackerras <paulus@samba.org>
Date:   Mon May 29 08:42:34 2006 +1000

    ppc: Fix typo in TI_LOCAL_FLAGS definition
    
    A typo crept in with commit ea1e847cc202e805769c3c46ba5e5c53714068a1
    which defined TI_LOCAL_FLAGS to be the offset of the `flags' field
    of struct thread_info, rather than the `local_flags' field.  This
    fixes it.  The typo was pointed out by Guennadi Liakhovetski.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/ppc/kernel/asm-offsets.c b/arch/ppc/kernel/asm-offsets.c
index cc7c4ae..2f5c5e1 100644
--- a/arch/ppc/kernel/asm-offsets.c
+++ b/arch/ppc/kernel/asm-offsets.c
@@ -134,7 +134,7 @@ #endif /* CONFIG_SPE */
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 
