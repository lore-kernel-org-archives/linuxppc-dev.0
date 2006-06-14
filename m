Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 529FA67B7B
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 17:23:31 +1000 (EST)
Date: Wed, 14 Jun 2006 17:23:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: Re: [PATCH] powerpc: Use soft irq-disable on all 64-bit machines
Message-Id: <20060614172309.59d7b76e.sfr@canb.auug.org.au>
In-Reply-To: <20060614170840.3686cbad.sfr@canb.auug.org.au>
References: <17551.33574.27019.305680@cargo.ozlabs.ibm.com>
	<20060614170840.3686cbad.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Jun 2006 17:08:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Looks good.  A couple of small fixes below.

Plus we want the below as well ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
index db0ce76..dc5f1ec 100644
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -8,6 +8,7 @@ #ifdef __KERNEL__
 
 #include <linux/config.h>
 #include <linux/errno.h>
+#include <linux/compiler.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
@@ -25,6 +26,7 @@ static inline unsigned long local_irq_di
 {
 	unsigned long flag = get_paca()->proc_enabled;
 	get_paca()->proc_enabled = 0;
+	barrier();
 	return flag;
 }
 
