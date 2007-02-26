Return-Path: <hugh_dickins@symantec.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 812EBDDE2E
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 23:04:35 +1100 (EST)
Date: Mon, 26 Feb 2007 11:34:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] include stddef.h in asm-powerpc/current.h to get
	definition of offsetof
In-Reply-To: <20070225190418.GA11805@aepfle.de>
Message-ID: <Pine.LNX.4.64.0702261124040.28415@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
	<20070225190418.GA11805@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luc Saillard <luc@saillard.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, stable@kernel.org,
	Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 25 Feb 2007, Olaf Hering wrote:
> On Tue, Oct 31, Hugh Dickins wrote:
> 
> > +++ linux/include/asm-powerpc/current.h	2006-10-30 19:27:05.000000000 +0000
> 
> > +static inline struct task_struct *get_current(void)
> > +{
> > +	struct task_struct *task;
> > +
> > +	__asm__ __volatile__("ld %0,%1(13)"
> > +	: "=r" (task)
> > +	: "i" (offsetof(struct paca_struct, __current)));
> 
> This breaks compile of 2.6.18.8:
> 
>   CC [M]  drivers/media/video/pwc/pwc-uncompress.o
> In file included from /home/olaf/kernel/linux-2.6.18.8/drivers/media/video/pwc/pwc-uncompress.c:29:
> include2/asm/current.h: In function 'get_current':
> include2/asm/current.h:23: warning: implicit declaration of function 'offsetof'
> include2/asm/current.h:23: error: expected expression before 'struct'
> make[5]: *** [drivers/media/video/pwc/pwc-uncompress.o] Error 1

Ow!  I'm very sorry for that.  My fault.

(I wonder what changed between 2.6.18 and 2.6.19,
to make 2.6.19 and 2.6.20 okay, yet this error in 2.6.18.8?)

Your patch is clearly correct, and satisfies the "any header should
include whatever it needs" rule; though my own preference (desperate
attempt to fool people into thinking my blame lies elsewhere?) would
be for the patch at the bottom - it seems that pwc-uncompress.c's
inclusion of asm/current.h is just bogus, probably a leftover of
some private debugging session around 2.6.8.

Hugh

> 
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  include/asm-powerpc/current.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6.18.8/include/asm-powerpc/current.h
> ===================================================================
> --- linux-2.6.18.8.orig/include/asm-powerpc/current.h
> +++ linux-2.6.18.8/include/asm-powerpc/current.h
> @@ -12,6 +12,7 @@
>  struct task_struct;
>  
>  #ifdef __powerpc64__
> +#include <linux/stddef.h>
>  #include <asm/paca.h>
>  
>  static inline struct task_struct *get_current(void)

--- 2.6.18.8/drivers/media/video/pwc/pwc-uncompress.c	2006-09-20 04:42:06.000000000 +0100
+++ 2.6.18.9/drivers/media/video/pwc/pwc-uncompress.c	2007-02-26 10:59:40.000000000 +0000
@@ -26,7 +26,6 @@
    vim: set ts=8:
 */
 
-#include <asm/current.h>
 #include <asm/types.h>
 
 #include "pwc.h"
