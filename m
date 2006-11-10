Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2453F67DA6
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:23:08 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAAIN5e7009812
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 13:23:05 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAAIN5Wm149832
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 13:23:05 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAAIMuTb009819
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 13:22:56 -0500
Date: Fri, 10 Nov 2006 12:22:53 -0600
To: paulus@samba.org
Subject: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061110182253.GV30625@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Paul,

I presume this looks reasonable, please apply.

--linas


There are a variety of code paths that lead to rtas_stop_self()
being called, primarily through cpu_die(). However, rtas_stop_self() 
has a BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE); in it, and
this rtas token is only set up if CONFIG_HOTPLUG_CPU is defined.

Rather than wrapping all of the callers of rtas_stop_self()
with CONFIG_HOTPLUG_CPU, it seems wiser to just unwrap the token
definition.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/kernel/rtas.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6.19-rc4-git3/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/arch/powerpc/kernel/rtas.c	2006-11-10 12:13:17.000000000 -0600
+++ linux-2.6.19-rc4-git3/arch/powerpc/kernel/rtas.c	2006-11-10 12:13:40.000000000 -0600
@@ -879,9 +879,7 @@ void __init rtas_initialize(void)
 #endif
 	rtas_rmo_buf = lmb_alloc_base(RTAS_RMOBUF_MAX, PAGE_SIZE, rtas_region);
 
-#ifdef CONFIG_HOTPLUG_CPU
 	rtas_stop_self_args.token = rtas_token("stop-self");
-#endif
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
