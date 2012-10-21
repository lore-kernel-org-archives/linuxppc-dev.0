Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail4-relais-sop.national.inria.fr
 (mail4-relais-sop.national.inria.fr [192.134.164.105])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.inria.fr", Issuer "TERENA SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 220262C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2012 22:03:18 +1100 (EST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] arch/powerpc/kernel/rtas_flash.c: eliminate possible
 double free
Date: Sun, 21 Oct 2012 12:52:05 +0200
Message-Id: <1350816727-1381-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1350816727-1381-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1350816727-1381-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <Julia.Lawall@lip6.fr>

The function initialize_flash_pde_data is only called four times.  All four
calls are in the function rtas_flash_init, and on the failure of any of the
calls, remove_flash_pde is called on the third argument of each of the
calls.  There is thus no need for initialize_flash_pde_data to call
remove_flash_pde on the same argument.  remove_flash_pde kfrees the data
field of its argument, and does not clear that field, so this amounts ot a
possible double free.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier f,free,a;
parameter list[n] ps;
type T;
expression e;
@@

f(ps,T a,...) {
  ... when any
      when != a = e
  if(...) { ... free(a); ... return ...; }
  ... when any
}

@@
identifier r.f,r.free;
expression x,a;
expression list[r.n] xs;
@@

* x = f(xs,a,...);
  if (...) { ... free(a); ... return ...; }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 arch/powerpc/kernel/rtas_flash.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 20b0120..8329190 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -650,10 +650,8 @@ static int initialize_flash_pde_data(const char *rtas_call_name,
 	int token;
 
 	dp->data = kzalloc(buf_size, GFP_KERNEL);
-	if (dp->data == NULL) {
-		remove_flash_pde(dp);
+	if (dp->data == NULL)
 		return -ENOMEM;
-	}
 
 	/*
 	 * This code assumes that the status int is the first member of the
