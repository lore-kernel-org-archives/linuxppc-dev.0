Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 62064DDEA2
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 06:03:43 +1100 (EST)
Date: Sun, 25 Feb 2007 20:04:18 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Hugh Dickins <hugh@veritas.com>, stable@kernel.org
Subject: [PATCH] include stddef.h in asm-powerpc/current.h to get definition
	of offsetof
Message-ID: <20070225190418.GA11805@aepfle.de>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 31, Hugh Dickins wrote:

> +++ linux/include/asm-powerpc/current.h	2006-10-30 19:27:05.000000000 +0000

> +static inline struct task_struct *get_current(void)
> +{
> +	struct task_struct *task;
> +
> +	__asm__ __volatile__("ld %0,%1(13)"
> +	: "=r" (task)
> +	: "i" (offsetof(struct paca_struct, __current)));

This breaks compile of 2.6.18.8:

  CC [M]  drivers/media/video/pwc/pwc-uncompress.o
In file included from /home/olaf/kernel/linux-2.6.18.8/drivers/media/video/pwc/pwc-uncompress.c:29:
include2/asm/current.h: In function 'get_current':
include2/asm/current.h:23: warning: implicit declaration of function 'offsetof'
include2/asm/current.h:23: error: expected expression before 'struct'
make[5]: *** [drivers/media/video/pwc/pwc-uncompress.o] Error 1


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 include/asm-powerpc/current.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18.8/include/asm-powerpc/current.h
===================================================================
--- linux-2.6.18.8.orig/include/asm-powerpc/current.h
+++ linux-2.6.18.8/include/asm-powerpc/current.h
@@ -12,6 +12,7 @@
 struct task_struct;
 
 #ifdef __powerpc64__
+#include <linux/stddef.h>
 #include <asm/paca.h>
 
 static inline struct task_struct *get_current(void)
