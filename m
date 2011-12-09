Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 73534B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 10:22:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] ipc: provide generic compat versions of IPC syscalls
Date: Sat, 10 Dec 2011 00:21:35 +0100
Message-ID: <1690400.7yOAjHVqTH@wuerfel>
In-Reply-To: <20111209134852.f5b5bcbc.akpm@linux-foundation.org>
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com>
 <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com>
 <20111209134852.f5b5bcbc.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-mips@linux-mips.org, NeilBrown <neilb@suse.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 "J. Bruce Fields" <bfields@redhat.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Friday 09 December 2011 13:48:52 Andrew Morton wrote:
> What would we need to do to get all architectures using the new
> interfaces, and remove __ARCH_WANT_OLD_COMPAT_IPC?

We would change the various compat_sys_ipc functions (mips, powerpc,
s390, sparc, x86) to call the new functions instead of the existing
ones, and test each architecture. For parisc, we might not
actually need the either version, but I'd have to take a closer look
to be sure.

> Regarding the implementation: rather than patching the header
> files, it would be more conventional (and arguably better) to add
> 
>         select ARCH_WANT_OLD_COMPAT_IPC
> 
> to arch/*/Kconfig, then use CONFIG_ARCH_WANT_OLD_COMPAT_IPC.

Yes.

	Arnd
