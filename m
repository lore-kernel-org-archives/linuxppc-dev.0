Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409ZWv5PmfzF2Dg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:22:51 +1100 (AEDT)
Date: Tue, 27 Mar 2018 17:22:32 +0200
Message-ID: <20180327172232.Horde.q3HjdRzVlIYmg2LP87jw8A1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Shile Zhang <shile.zhang@nokia.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: Fix checksum folding in csum_add
In-Reply-To: <1486199020-59977-1-git-send-email-shile.zhang@nokia.com>
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

Shile Zhang <shile.zhang@nokia.com> a =C3=A9crit=C2=A0:

> fix the missed point in Paul's patch:
> "powerpc/64: Fix checksum folding in csum_tcpudp_nofold and
> ip_fast_csum_nofold"
>
> Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
> ---
>  arch/powerpc/include/asm/checksum.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/checksum.h=20=20
>=20b/arch/powerpc/include/asm/checksum.h
> index 5b1a6e3..430d038 100644
> --- a/arch/powerpc/include/asm/checksum.h
> +++ b/arch/powerpc/include/asm/checksum.h
> @@ -108,7 +108,7 @@ static inline __wsum csum_add(__wsum csum, __wsum add=
end)
>
>  #ifdef __powerpc64__
>  	res +=3D (__force u64)addend;
> -	return (__force __wsum)((u32)res + (res >> 32));
> +	return (__force __wsum) from64to32(res);

Did you encounter a bug due to that ?
As far as i understand, csum and addend are 32 bits so can't exceed 0xfffff=
fff
Then their sum won't exceed 0x1fffffffe. So the sum of upper and lower=20=
=20
part=20won't carry

Christophe

>  #else
>  	asm("addc %0,%0,%1;"
>  	    "addze %0,%0;"
> --
> 2.6.2
