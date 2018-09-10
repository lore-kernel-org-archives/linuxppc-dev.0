Return-Path: <lucien.xin@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4289Py22nNzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 00:28:21 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id c22-v6so800611iob.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 07:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
In-Reply-To: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Sep 2018 22:28:08 +0800
Message-ID: <CADvbK_c+VVoC=tcX4z-NbX6xGHfkzzNuBXoMHFJfZdiBMzX3+w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix csum_ipv6_magic() on little endian platforms
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 Michael Ellerman <mpe@ellerman.id.au>, jishi@redhat.com,
 LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 2:09 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On little endian platforms, csum_ipv6_magic() keeps len and proto in
> CPU byte order. This generates a bad results leading to ICMPv6 packets
> from other hosts being dropped by powerpc64le platforms.
>
> In order to fix this, len and proto should be converted to network
> byte order ie bigendian byte order. However checksumming 0x12345678
> and 0x56341278 provide the exact same result so it is enough to
> rotate the sum of len and proto by 1 byte.
>
> PPC32 only support bigendian so the fix is needed for PPC64 only
>
> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Reported-by: Xin Long <lucien.xin@gmail.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/lib/checksum_64.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
> index 886ed94b9c13..2a68c43e13f5 100644
> --- a/arch/powerpc/lib/checksum_64.S
> +++ b/arch/powerpc/lib/checksum_64.S
> @@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
>         addc    r0, r8, r9
>         ld      r10, 0(r4)
>         ld      r11, 8(r4)
> +#ifndef CONFIG_CPU_BIG_ENDIAN
> +       rotldi  r5, r5, 8
> +#endif
>         adde    r0, r0, r10
>         add     r5, r5, r7
>         adde    r0, r0, r11
> --
> 2.13.3
>
Tested-by: Xin Long <lucien.xin@gmail.com>
