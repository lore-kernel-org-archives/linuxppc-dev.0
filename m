Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYszb0Q39zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 00:07:22 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id 2so5306345oif.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 05:07:22 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170302004607.GE27132@altlinux.org>
References: <20170302004607.GE27132@altlinux.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Mar 2017 14:07:20 +0100
Message-ID: <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix another asm/shmbuf.h userspace compilation error
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org, linux-am33-list@redhat.com, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 2, 2017 at 1:46 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Replace size_t with __kernel_size_t to fix asm/shmbuf.h userspace
> compilation errors like this:
>
> /usr/include/asm-generic/shmbuf.h:28:2: error: unknown type name 'size_t'
>   size_t   shm_segsz; /* size of segment (bytes) */
>
> x32 is the only architecture where sizeof(size_t) is less than
> sizeof(__kernel_size_t), but as the kernel treats shm_segsz field as
> __kernel_size_t anyway, UAPI should follow.  Thanks to little-endiannes
> of x32 and 64-bit alignment of the field following shm_segsz, this
> change doesn't break ABI, and the difference doesn't manifest itself
> easily.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
