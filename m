Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id C17D6DDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 21:42:41 +1000 (EST)
Date: Wed, 25 Jul 2007 13:43:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: "do section mismatch check on full vmlinux" breaks powerpc build
Message-ID: <20070725114356.GB25580@uranus.ravnborg.org>
References: <20070724224105.GG951@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070724224105.GG951@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 24, 2007 at 05:41:05PM -0500, Nathan Lynch wrote:
> Hello-
> 
> 2.6.23-rc1 breaks the build for 64-bit powerpc for me (using
> maple_defconfig):
> 
>   LD      vmlinux.o
> powerpc64-unknown-linux-gnu-ld: dynreloc miscount for
> kernel/built-in.o, section .opd
> powerpc64-unknown-linux-gnu-ld: can not edit opd Bad value
> make: *** [vmlinux.o] Error 1
> 
> This is on a i386 host with:
> powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.2
> GNU ld version 2.16.1
> 
> Reverting the following commit fixes it:
> 
> commit 741f98fe298a73c9d47ed53703c1279a29718581
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Tue Jul 17 10:54:06 2007 +0200
> 
>     kbuild: do section mismatch check on full vmlinux
> 
> 
> However, I see a possibly related binutils patch:
> http://article.gmane.org/gmane.comp.gnu.binutils/33650
> 
> Will there be a kbuild fix for this or should I update my binutils?


I tried searching a bit more to find the culprint.
I narrowed it down to the following change to avoid the breakage:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c456c3a..2ea222f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1246,7 +1246,7 @@ void drop_slab(void);
 extern int randomize_va_space;
 #endif
 
-__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma);
+//__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */

So seems that something goes a bit fishy when using weak symbols and this trigges 
a binutils bug.

The above line was introdused in the following commit:

commit f269fdd1829acc5e53bf57b145003e5733133f2b
Author: David Howells <dhowells@redhat.com>
Date:   Wed Sep 27 01:50:23 2006 -0700

    [PATCH] NOMMU: move the fallback arch_vma_name() to a sensible place
    
    Move the fallback arch_vma_name() to a sensible place (kernel/signal.c).
    
    Currently it's in fs/proc/task_mmu.c, a file that is dependent on both
    CONFIG_PROC_FS and CONFIG_MMU being enabled, but it's used from
    kernel/signal.c from where it is called unconditionally.
    
    [akpm@osdl.org: build fix]
    Signed-off-by: David Howells <dhowells@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


	Sam
