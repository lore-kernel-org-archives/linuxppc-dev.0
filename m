Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYt8Q1zKMzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 00:15:01 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id m124so5312956oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 05:15:01 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170302002253.GC27132@altlinux.org>
References: <CAK8P3a3Ptm68i43BT5+kWptDw1koPwexpuFwH3-1naj_xi+arQ@mail.gmail.com>
 <20170302002253.GC27132@altlinux.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Mar 2017 14:14:59 +0100
Message-ID: <CAK8P3a1_QLguZ6XEGC9TdGUmF0R3bKaU2EiJ6m+Gf=KpYnmqqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] uapi: fix asm/shmbuf.h userspace compilation errors
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-arch <linux-arch@vger.kernel.org>, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 2, 2017 at 1:22 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Include <asm/ipcbuf.h> to fix asm/shmbuf.h userspace compilation errors
> like this:
>
> /usr/include/asm-generic/shmbuf.h:26:20: error: field 'shm_perm' has incomplete type
>   struct ipc64_perm shm_perm; /* operation perms */
> /usr/include/asm-generic/shmbuf.h:28:2: error: unknown type name '__kernel_time_t'
>   __kernel_time_t  shm_atime; /* last attach time */
> /usr/include/asm-generic/shmbuf.h:32:2: error: unknown type name '__kernel_time_t'
>   __kernel_time_t  shm_dtime; /* last detach time */
> /usr/include/asm-generic/shmbuf.h:36:2: error: unknown type name '__kernel_time_t'
>   __kernel_time_t  shm_ctime; /* last change time */
> /usr/include/asm-generic/shmbuf.h:40:2: error: unknown type name '__kernel_pid_t'
>   __kernel_pid_t  shm_cpid; /* pid of creator */
> /usr/include/asm-generic/shmbuf.h:41:2: error: unknown type name '__kernel_pid_t'
>   __kernel_pid_t  shm_lpid; /* pid of last operator */
> /usr/include/asm-generic/shmbuf.h:42:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shm_nattch; /* no. of current attaches */
> /usr/include/asm-generic/shmbuf.h:43:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused4;
> /usr/include/asm-generic/shmbuf.h:44:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused5;
> /usr/include/asm-generic/shmbuf.h:48:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmmax;
> /usr/include/asm-generic/shmbuf.h:49:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmmin;
> /usr/include/asm-generic/shmbuf.h:50:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmmni;
> /usr/include/asm-generic/shmbuf.h:51:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmseg;
> /usr/include/asm-generic/shmbuf.h:52:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t shmall;
> /usr/include/asm-generic/shmbuf.h:53:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused1;
> /usr/include/asm-generic/shmbuf.h:54:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused2;
> /usr/include/asm-generic/shmbuf.h:55:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused3;
> /usr/include/asm-generic/shmbuf.h:56:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused4;
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
