Return-Path: <geoff@infradead.org>
Message-ID: <1360740779.28936.20.camel@clam>
Subject: Re: PS3 platform is broken on Linux 3.7.0
From: Geoff Levand <geoff@infradead.org>
To: Phileas Fogg <phileas-fogg@mail.ru>, Michael Ellerman
 <michael@ellerman.id.au>
Date: Tue, 12 Feb 2013 23:32:59 -0800
In-Reply-To: <1355488506.55692113@f147.mail.ru>
References: <1355488506.55692113@f147.mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 2012-12-14 at 16:35 +0400, Phileas Fogg wrote:
> I wanted to bring to your attention the fact that the PS3 platform is broken on Linux 3.7.0.

> So i cloned the Linux powerpc GIT repository and tried to find out which commits broke the PS3 platform.

> ---------------------------------------------------------------------------------------------
> 
> commit 407821a34fce89b4f0b031dbab5cec7d059f46bc
> Author: Michael Ellerman <michael@ellerman.id.au>
> Date:   Fri Sep 7 15:31:44 2012 +0000
> 
>     powerpc: Initialise paca.data_offset with poison

I did a little more work on this, and it seems the change below
will fix the problem introduced by Michael's change.  I can only
guess we need to use udbg_printf() here.  I'll look at it some more
as I have time.

-Geoff

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 5c56834..6b4f613 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -184,8 +185,8 @@ void __init allocate_pacas(void)
 	paca = __va(memblock_alloc_base(paca_size, PAGE_SIZE, limit));
 	memset(paca, 0, paca_size);
 
-	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
-		paca_size, nr_cpu_ids, paca);
+//	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
+//		paca_size, nr_cpu_ids, paca);
 
 	allocate_lppacas(nr_cpu_ids, limit);
 

> 
