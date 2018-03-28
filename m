Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BKWz6KWNzF22G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 07:40:31 +1100 (AEDT)
Date: Thu, 29 Mar 2018 07:40:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: Shile Zhang <shile.zhang@nokia.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: Fix checksum folding in csum_add
Message-ID: <20180328204027.GA2069@fergus.ozlabs.ibm.com>
References: <1486199020-59977-1-git-send-email-shile.zhang@nokia.com>
 <20180327172232.Horde.q3HjdRzVlIYmg2LP87jw8A1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180327172232.Horde.q3HjdRzVlIYmg2LP87jw8A1@messagerie.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 05:22:32PM +0200, LEROY Christophe wrote:
> Shile Zhang <shile.zhang@nokia.com> a écrit :
> 
> >fix the missed point in Paul's patch:
> >"powerpc/64: Fix checksum folding in csum_tcpudp_nofold and
> >ip_fast_csum_nofold"
> >
> >Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
> >---
> > arch/powerpc/include/asm/checksum.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/powerpc/include/asm/checksum.h
> >b/arch/powerpc/include/asm/checksum.h
> >index 5b1a6e3..430d038 100644
> >--- a/arch/powerpc/include/asm/checksum.h
> >+++ b/arch/powerpc/include/asm/checksum.h
> >@@ -108,7 +108,7 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
> >
> > #ifdef __powerpc64__
> > 	res += (__force u64)addend;
> >-	return (__force __wsum)((u32)res + (res >> 32));
> >+	return (__force __wsum) from64to32(res);
> 
> Did you encounter a bug due to that ?
> As far as i understand, csum and addend are 32 bits so can't exceed 0xffffffff
> Then their sum won't exceed 0x1fffffffe. So the sum of upper and lower part
> won't carry

If the sum of the two halves was 0x1fffffffe, then that previously got
truncated to 32 bits and returned as 0xfffffffe, which is wrong - the
result should be 0xffffffff.

Paul.
