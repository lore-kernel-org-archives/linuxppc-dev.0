Date: Wed, 19 Sep 2001 16:01:01 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: building multiple kernels under linuxppc_2_4_devel
Message-ID: <Pine.LNX.4.30.0109191555210.12262-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We're trying to build for i386 and PPC machines under the same tree, but
one section of code is causing us some problems...

linuxppc_2_4_devel/include/linux/highmem.h

-----------------

/*
#ifndef __HAVE_ARCH_USER_PAGE
static inline void clear_user_page(struct page *page, unsigned long vaddr)
{
        void *addr = kmap_atomic(page, KM_USER0);
        clear_page(addr, vaddr);
        kunmap_atomic(addr, KM_USER0);
}

static inline void copy_user_page(struct page *to, struct page *from,
unsigned long vaddr)
{
        char *vfrom, *vto;

        vfrom = kmap_atomic(from, KM_USER0);
        vto = kmap_atomic(to, KM_USER1);
        copy_user_page(vto, vfrom, vaddr);
        kunmap_atomic(vfrom, KM_USER0);
        kunmap_atomic(vto, KM_USER1);
}
#endif
*/

------------------

As you can see, we've commented it out, which causes the kernel to build
correctly for both arch's, but the clear_page macro only takes one
parameter from what I can see and we get _all_ kinds of parse errors
starting with the line immediately following the #ifndef.

Any ideas?

--
John Tyner
jtyner@cs.ucr.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
