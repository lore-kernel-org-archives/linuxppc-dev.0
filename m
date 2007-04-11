Return-Path: <mita@fixstars.com>
Date: Wed, 11 Apr 2007 12:06:56 +0900
From: Akinobu Mita <mita@fixstars.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
Message-ID: <20070411030656.GA2469@localhost.localdomain>
References: <20070410111508.GA2969@localhost.localdomain>
	<ca57c91a479a78be2f0004a40695f1ba@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca57c91a479a78be2f0004a40695f1ba@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2007 at 02:52:33PM +0200, Segher Boessenkool wrote:
> >An Alignment interrupt occurs when the instruction is lmw, stmw, lswi, 
> >lswx,
> >stswi, or stswx, and the operand is in local store.
> >
> >GCC generated such instructions to handle memcpy() instead of kernel
> >defined memcpy() without -mno-string option.
> 
> >+# An Alignment interrupt occurs when the instruction is lmw, stmw, 
> >lswi, lswx,
> >+# stswi, or stswx, and the operand is in local store.
> >+CFLAGS_run.o := -mno-string
> >+CFLAGS_file.o := -mno-string
> 
> NAK.  Please use memcpy_fromio() and friends instead,
> that's what they're there for.  I believe Arnd was working
> on this?
> 
> Your patch is only a partial solution, you'd need -mno-multiple
> -mno-algebraic -mno-dcbz too (and two of those don't even
> exist).

This is the patch which fix the problem with using memcpy_fromio/toio()
on LS. It seems better than adding many -mno-* options to specific
files.

From: Akinobu Mita <mita@fixstars.com>
Subject: spufs: use memcpy_fromio() to copy from local store

GCC may generates inline copy loop to handle memcpy() function
instead of kernel defined memcpy(). But this inlined version of memcpy()
causes an alignment interrupt when copying from local store.

This patch uses memcpy_fromio() and memcpy_toio to copy local store
to prevent memcpy() being inlined.

Signed-off-by: Akinobu Mita <mita@fixstars.com>

---
 arch/powerpc/platforms/cell/spufs/run.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: 2.6-git-ps3/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- 2.6-git-ps3.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ 2.6-git-ps3/arch/powerpc/platforms/cell/spufs/run.c
@@ -260,10 +260,10 @@ int spu_process_callback(struct spu_cont
 	/* get syscall block from local store */
 	npc = ctx->ops->npc_read(ctx);
 	ls = ctx->ops->get_ls(ctx);
-	ls_pointer = *(u32*)(ls + npc);
+	ls_pointer = *(u32 *)(ls + npc);
 	if (ls_pointer > (LS_SIZE - sizeof(s)))
 		return -EFAULT;
-	memcpy(&s, ls + ls_pointer, sizeof (s));
+	memcpy_fromio(&s, ls + ls_pointer, sizeof(s));
 
 	/* do actual syscall without pinning the spu */
 	ret = 0;
@@ -283,7 +283,7 @@ int spu_process_callback(struct spu_cont
 	}
 
 	/* write result, jump over indirect pointer */
-	memcpy(ls + ls_pointer, &spu_ret, sizeof (spu_ret));
+	memcpy_toio(ls + ls_pointer, &spu_ret, sizeof(spu_ret));
 	ctx->ops->npc_write(ctx, npc);
 	ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
 	return ret;
