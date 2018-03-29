Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bpl354nhzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 02:36:47 +1100 (AEDT)
Date: Thu, 29 Mar 2018 17:36:25 +0200
Message-ID: <20180329173625.Horde.Tekalg3E6TrriSAxxSaajA1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Shile Zhang
 <shile.zhang@nokia.com>
Subject: Re: [PATCH] powerpc/64: Fix checksum folding in csum_add
References: <1486199020-59977-1-git-send-email-shile.zhang@nokia.com>
 <20180327172232.Horde.q3HjdRzVlIYmg2LP87jw8A1@messagerie.si.c-s.fr>
 <20180328204027.GA2069@fergus.ozlabs.ibm.com>
In-Reply-To: <20180328204027.GA2069@fergus.ozlabs.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> a =C3=A9crit=C2=A0:

> On Tue, Mar 27, 2018 at 05:22:32PM +0200, LEROY Christophe wrote:
>> Shile Zhang <shile.zhang@nokia.com> a =C3=A9crit=C2=A0:
>>
>> >fix the missed point in Paul's patch:
>> >"powerpc/64: Fix checksum folding in csum_tcpudp_nofold and
>> >ip_fast_csum_nofold"
>> >
>> >Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
>> >---
>> > arch/powerpc/include/asm/checksum.h | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/arch/powerpc/include/asm/checksum.h
>> >b/arch/powerpc/include/asm/checksum.h
>> >index 5b1a6e3..430d038 100644
>> >--- a/arch/powerpc/include/asm/checksum.h
>> >+++ b/arch/powerpc/include/asm/checksum.h
>> >@@ -108,7 +108,7 @@ static inline __wsum csum_add(__wsum csum,=20=20
>>=20__wsum addend)
>> >
>> > #ifdef __powerpc64__
>> > 	res +=3D (__force u64)addend;
>> >-	return (__force __wsum)((u32)res + (res >> 32));
>> >+	return (__force __wsum) from64to32(res);
>>
>> Did you encounter a bug due to that ?
>> As far as i understand, csum and addend are 32 bits so can't exceed=20=
=20
>>=200xffffffff
>> Then their sum won't exceed 0x1fffffffe. So the sum of upper and lower p=
art
>> won't carry
>
> If the sum of the two halves was 0x1fffffffe, then that previously got
> truncated to 32 bits and returned as 0xfffffffe, which is wrong - the
> result should be 0xffffffff.
>

It is the sum of the two arguments of csum_add() which can't exceed=20=20
0x1fffffffe
So=20the sum of the two halves will be 0xffffffff which is the expected res=
ult.

The issue would start with res =3D 0x1ffffffff, in that case the sum of=20=
=20
the=20two halves would be 0x100000000 which would have been truncated to=20=
=20
0=20whereas we expect the result to be 1 in that case.
But in order to obtain res =3D 0x1ffffffff or higher, you have to sum at=20=
=20
least=20three 32 bits numbers. You can't obtain such a value with a sum=20=
=20
of=20two 32 bits numbers.

Christophe
