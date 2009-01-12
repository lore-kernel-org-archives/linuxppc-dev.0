Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 4BC31DDFF4
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 11:53:57 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so3282869yxg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 16:53:55 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Sun, 11 Jan 2009 19:53:42 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH][v3] powerpc 44x: support for 256KB PAGE_SIZE
Message-ID: <20090112005342.GB21457@zod.rchland.ibm.com>
References: <200901112142.31003.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901112142.31003.yur@emcraft.com>
Cc: wd@denx.de, yanok@emcraft.com, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 11, 2009 at 09:42:30PM +0300, Yuri Tikhonov wrote:
>
>This patch adds support for 256KB pages on ppc44x-based boards.
>
>For simplification of implementation with 256KB pages we still assume
>2-level paging. As a side effect this leads to wasting extra memory space
>reserved for PTE tables: only 1/4 of pages allocated for PTEs are
>actually used. But this may be an acceptable trade-off to achieve the
>high performance we have with big PAGE_SIZEs in some applications (e.g.
>RAID).
>
>Also with 256KB PAGE_SIZE we increase THREAD_SIZE up to 32KB to minimize
>the risk of stack overflows in the cases of on-stack arrays, which size
>depends on the page size (e.g. multipage BIOs, NTFS, etc.).
>
>With 256KB PAGE_SIZE we need to decrease the PKMAP_ORDER at least down
>to 9, otherwise all high memory (2 ^ 10 * PAGE_SIZE == 256MB) we'll be
>occupied by PKMAP addresses leaving no place for vmalloc. We do not
>separate PKMAP_ORDER for 256K from 16K/64K PAGE_SIZE here; actually that
>value of 10 in support for 16K/64K had been selected rather intuitively.
>Thus now for all cases of PAGE_SIZE on ppc44x (including the default, 4KB,
>one) we have 512 pages for PKMAP.
>
>Because ELF standard supports only page sizes up to 64K, then you should
>use binutils later than 2.17.50.0.3 with '-zmax-page-size' set to 256K
>for building applications, which are to be run with the 256KB-page sized
>kernel. If using the older binutils, then you should patch them like follows:
>
>--- binutils/bfd/elf32-ppc.c.orig
>+++ binutils/bfd/elf32-ppc.c
>
>-#define ELF_MAXPAGESIZE		0x10000
>+#define ELF_MAXPAGESIZE		0x40000
>
>Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Thanks.  I particularly like the additional option you have to disable
before 256K pages is an option.  I'll do a bit of testing, and barring
any unforeseen problems, I'll queue this up for 2.6.30.

josh
