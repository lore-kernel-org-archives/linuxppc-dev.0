Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4270HK2qRxzF3Sf
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2018 02:33:32 +1000 (AEST)
Date: Sat, 08 Sep 2018 18:33:27 +0200
Message-ID: <20180908183327.Horde.z6jJloy6XgHTgH9gNgohmQ1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Xin Long <lucien.xin@gmail.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, network dev
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net] powerpc: use big endian to hash len and proto in
 csum_ipv6_magic
In-Reply-To: <9183876a4a8ff0099686521d60f395a5230b67ed.1536401712.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xin Long <lucien.xin@gmail.com> a =C3=A9crit=C2=A0:

> The function csum_ipv6_magic doesn't convert len and proto to big
> endian before doing ipv6 csum hash, which is not consistent with
> RFC and other arches.
>
> Jianlin found it when ICMPv6 packets from other hosts were dropped
> in the powerpc64 system.
>
> This patch is to fix it by using instruction 'lwbrx' to do this
> conversion in powerpc32/64 csum_ipv6_magic.
>
> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  arch/powerpc/lib/checksum_32.S | 4 ++++
>  arch/powerpc/lib/checksum_64.S | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_3=
2.S
> index aa22406..7d3446e 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -325,6 +325,10 @@ _GLOBAL(csum_ipv6_magic)
>  	adde	r0, r0, r9
>  	lwz	r11, 12(r4)
>  	adde	r0, r0, r10
> +	STWX_BE	r5, 0, r1
> +	lwz	r5, 0(r1)
> +	STWX_BE	r6, 0, r1
> +	lwz	r6, 0(r1)

PPC32 doesn't support little endian, so nothing to do here.

>  	add	r5, r5, r6	/* assumption: len + proto doesn't carry */
>  	adde	r0, r0, r11
>  	adde	r0, r0, r5
> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_6=
4.S
> index 886ed94..302e732 100644
> --- a/arch/powerpc/lib/checksum_64.S
> +++ b/arch/powerpc/lib/checksum_64.S
> @@ -439,6 +439,10 @@ EXPORT_SYMBOL(csum_partial_copy_generic)
>  _GLOBAL(csum_ipv6_magic)
>  	ld	r8, 0(r3)
>  	ld	r9, 8(r3)
> +	STWX_BE	r5, 0, r1
> +	lwz	r5, 0(r1)
> +	STWX_BE	r6, 0, r1
> +	lwz	r6, 0(r1)
>  	add	r5, r5, r6

This is overkill. For LE it should be enough to rotate r5 by 8 bits=20=20
after=20the sum. Best place to do it would be after ld r11 I think.

Christophe

>  	addc	r0, r8, r9
>  	ld	r10, 0(r4)
> --
> 2.1.0
