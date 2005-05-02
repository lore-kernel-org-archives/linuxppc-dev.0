Return-Path: <hugh@veritas.com>
Received: from MTVMIME01.enterprise.veritas.com (bay-bridge.veritas.com
	[143.127.3.10]) by ozlabs.org (Postfix) with ESMTP id F411E67B46
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 20:25:09 +1000 (EST)
Date: Mon, 2 May 2005 11:14:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050501154654.2bf7606d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505021110450.6198@goblin.wat.veritas.com>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<6uu0lnf0gm.fsf@zork.zork.net>
	<Pine.LNX.4.62.0505011749280.2488@dragon.hyggekrogen.localhost>
	<20050501154654.2bf7606d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: rbrito@ime.usp.br, linuxppc-dev@ozlabs.org, Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel@vger.kernel.org
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

Almost.  Should be

	pte_unmap(ptep - 1);
