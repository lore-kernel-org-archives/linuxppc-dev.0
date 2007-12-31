Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18296.18584.806777.211368@cargo.ozlabs.ibm.com>
Date: Mon, 31 Dec 2007 12:40:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <47757040.4020508@am.sony.com>
References: <18292.49574.906807.484581@cargo.ozlabs.ibm.com>
	<47757040.4020508@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, rrnelson@linux.vnet.ibm.com, jk@ozlabs.org,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> This broke Cell builds.
> 
> arch/powerpc/platforms/cell/spufs/sched.c:200: multiple definition of `.notify_spus_active'
> arch/powerpc/platforms/cell/spu_syscalls.c:149: first defined here
> 
> 
> commit aed3a8c9bb1a8623a618232087c5ff62718e3b9a
> Author: Bob Nelson <rrnelson@linux.vnet.ibm.com>
> Date:   Sat Dec 15 01:27:30 2007 +1100
> 
>     [POWERPC] Oprofile: Remove dependency on spufs module
> 
> 
> Looking at the code, it seems just when CONFIG_SPU_FS=y, not when =m.

Indeed.  Clearly, several people have failed to review this patch
properly. :(

It looks to me that the definition of notify_spus_active under #ifndef
MODULE in spufs/sched.c is bogus and should just be removed
completely.  Also, I don't see any need for do_notify_spus_active to
be exported.

I propose the patch below.  Arnd, Jeremy, Bob, any opinions?

Paul.
---

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 6e2a45e..9ad53e6 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -192,15 +192,6 @@ void do_notify_spus_active(void)
 		mutex_unlock(&cbe_spu_info[node].list_mutex);
 	}
 }
-EXPORT_SYMBOL_GPL(do_notify_spus_active);
-
-#ifndef MODULE
-void notify_spus_active(void)
-{
-	do_notify_spus_active();
-}
-EXPORT_SYMBOL_GPL(notify_spus_active);
-#endif
 
 /**
  * spu_bind_context - bind spu context to physical spu
