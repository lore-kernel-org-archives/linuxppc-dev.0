Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BWJx6Jj5zF3V4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 20:02:09 +1000 (AEST)
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so8137583qto.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 03:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Sep 2018 12:01:51 +0200
Message-ID: <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com, leitao@debian.org,
 Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> ---
>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++

I think you should only need a single .tbl  input file here.


> +
> +systbl_abi_syscall_table_32 := 32
> +$(out)/syscall_table_32.h: $(syscall32) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_64 := 64
> +$(out)/syscall_table_64.h: $(syscall64) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_c32 := c32
> +$(out)/syscall_table_c32.h: $(syscall32) $(systbl)
> +       $(call if_changed,systbl)

And here you need a fourth output file for the SPU table on ppc64.

> +383     common  statx                           sys_statx
> +384     common  pkey_alloc                      sys_pkey_alloc
> +385     common  pkey_free                       sys_pkey_free
> +386     common  pkey_mprotect                   sys_pkey_mprotect

This also misses rseq and io_pgetevents.

       Arnd
