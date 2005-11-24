Return-Path: <SRS0+1a4aa88343b650159535+823+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6212687E7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2005 04:36:27 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
In-Reply-To: <1132836700.11921.58.camel@baythorne.infradead.org>
References: <1132836700.11921.58.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 17:36:20 +0000
Message-Id: <1132853780.11921.95.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Save NVGPRS in 32-bit signal frame
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-11-24 at 12:51 +0000, David Woodhouse wrote:
> Somehow this one slipped through the cracks; when we ended up in
> do_signal() on a 32-bit kernel but without having the caller-saved
> registers into the regs, we didn't set the TIF_SAVE_NVGPRS flag to
> ensure they got saved later.

Oh, and if we actually set the flag, then we fairly quickly find out
that I was a bit overzealous in copying code from entry_64.S ... :)

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8fed953..036b71d 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -368,7 +368,7 @@ save_user_nvgprs_cont:
 	b	6b
 
 save_user_nvgprs:
-	ld	r8,TI_SIGFRAME(r12)
+	lwz	r8,TI_SIGFRAME(r12)
 
 .macro savewords start, end
   1:	stw \start,4*(\start)(r8)
@@ -386,11 +386,11 @@ save_user_nvgprs:
 	
 save_user_nvgprs_fault:
 	li	r3,11		/* SIGSEGV */
-	ld	r4,TI_TASK(r12)
+	lwz	r4,TI_TASK(r12)
 	bl	force_sigsegv
 
 	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
-	ld	r9,TI_FLAGS(r12)
+	lwz	r9,TI_FLAGS(r12)
 	b	save_user_nvgprs_cont
 	
 #ifdef SHOW_SYSCALLS

-- 
dwmw2
