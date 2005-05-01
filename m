Return-Path: <juhl-lkml@dif.dk>
Received: from saerimmer.dif.dk (mail.dif.dk [193.138.115.101])
	by ozlabs.org (Postfix) with ESMTP id 0E3B167A6F
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 08:57:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by saerimmer.dif.dk (Postfix) with ESMTP id A2EA8FFC6E
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 01:09:16 +0200 (CEST)
Received: from saerimmer.dif.dk ([127.0.0.1])
	by localhost (saerimmer [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 08898-04 for <linuxppc-dev@ozlabs.org>;
	Mon,  2 May 2005 01:09:16 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk
	[10.227.136.246])
	by saerimmer.dif.dk (Postfix) with ESMTP id 39380FFC70
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 01:09:14 +0200 (CEST)
Date: Mon, 2 May 2005 01:01:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050501154654.2bf7606d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505020054351.2488@dragon.hyggekrogen.localhost>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<6uu0lnf0gm.fsf@zork.zork.net>
	<Pine.LNX.4.62.0505011749280.2488@dragon.hyggekrogen.localhost>
	<20050501154654.2bf7606d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2: ppc pte_offset_map()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 1 May 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > On Sun, 1 May 2005, Sean Neakums wrote:
> > 
> > > On my Mackertosh (PowerBook5.4), build fails with the following:
> > > 
> > >   fs/proc/task_mmu.c: In function `smaps_pte_range':
> > >   fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
> > >   fs/proc/task_mmu.c:177: error: `KM_PTE0' undeclared (first use in this function)
> > >   fs/proc/task_mmu.c:177: error: (Each undeclared identifier is reported only once
> > >   fs/proc/task_mmu.c:177: error: for each function it appears in.)
> > >   fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'
> > > 
> > > With the naive patch below, it builds with this warning and everything works.
> > > 
> > >   fs/proc/task_mmu.c: In function `smaps_pte_range':
> > >   fs/proc/task_mmu.c:208: warning: passing arg 1 of `kunmap_atomic' makes pointer from integer without a cast
> > > 
> > 
> > Try this patch :
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> > --- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
> > +++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 17:49:14.000000000 +0200
> > @@ -2,6 +2,7 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/mount.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/highmem.h>
> >  
> >  #include <asm/elf.h>
> >  #include <asm/uaccess.h>
> > @@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
> >  			}
> >  		}
> >  	} while (address < end);
> > -	pte_unmap(pte);
> > +	pte_unmap((void *)pte);
> >  }
> 
> Should be
> 
> 	pte_unmap(ptep);
> 
Of course, stupid me. I should have seen the 
	[...]
        ptep = pte_offset_map(pmd, address);
	[...]
            pte = *ptep;
            address += PAGE_SIZE;
            ptep++;
	[...]
bit a few lines above. Guess I should have spend more than 2min creating 
the patch.

Thanks.

Here's an updated patch.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
+++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-02 00:59:11.000000000 +0200
@@ -2,6 +2,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>
+#include <linux/highmem.h>
 
 #include <asm/elf.h>
 #include <asm/uaccess.h>
@@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
 			}
 		}
 	} while (address < end);
-	pte_unmap(pte);
+	pte_unmap(ptep);
 }
 
 static void smaps_pmd_range(pud_t *pud,
