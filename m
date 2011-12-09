Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 1EAC11007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 08:48:55 +1100 (EST)
Date: Fri, 9 Dec 2011 13:48:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH v2] ipc: provide generic compat versions of IPC syscalls
Message-Id: <20111209134852.f5b5bcbc.akpm@linux-foundation.org>
In-Reply-To: <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com>
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com>
 <201112091602.31325.arnd@arndb.de>
 <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, NeilBrown <neilb@suse.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 "J. Bruce Fields" <bfields@redhat.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 9 Dec 2011 10:29:07 -0500
Chris Metcalf <cmetcalf@tilera.com> wrote:

> When using the "compat" APIs, architectures will generally want to
> be able to make direct syscalls to msgsnd(), shmctl(), etc., and
> in the kernel we would want them to be handled directly by
> compat_sys_xxx() functions, as is true for other compat syscalls.
> 
> However, for historical reasons, several of the existing compat IPC
> syscalls do not do this.  semctl() expects a pointer to the fourth
> argument, instead of the fourth argument itself.  msgsnd(), msgrcv()
> and shmat() expect arguments in different order.
> 
> This change adds an __ARCH_WANT_OLD_COMPAT_IPC define that can be
> set in <asm/compat.h> to preserve this behavior for ports that use it
> (x86, sparc, powerpc, s390, and mips).  No actual semantics are changed
> for those architectures, and there is only a minimal amount of code
> refactoring in ipc/compat.c.
> 
> Newer architectures like tile (and perhaps future architectures such
> as arm64 and unicore64) should not supply this define, and thus can
> avoid having any IPC-specific code at all in their architecture-specific
> compat layer.  In the same vein, if this define is omitted, IPC_64 mode
> is assumed, since that's what the <asm-generic> headers expect.
> 
> The workaround code in "tile" for msgsnd() and msgrcv() is removed
> with this change; it also fixes the bug that shmat() and semctl() were
> not being properly handled.

What would we need to do to get all architectures using the new
interfaces, and remove __ARCH_WANT_OLD_COMPAT_IPC?

Regarding the implementation: rather than patching the header
files, it would be more conventional (and arguably better) to add

	select ARCH_WANT_OLD_COMPAT_IPC

to arch/*/Kconfig, then use CONFIG_ARCH_WANT_OLD_COMPAT_IPC.
