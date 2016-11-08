Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCglV4TH3zDvTG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 18:23:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/64: Fix checksum folding in
 csum_tcpudp_nofold and ip_fast_csum_nofold
In-Reply-To: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
References: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
Date: Tue, 08 Nov 2016 18:23:30 +1100
Message-ID: <878tsul9jh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> These functions compute an IP checksum by computing a 64-bit sum and
> folding it to 32 bits (the "nofold" in their names refers to folding
> down to 16 bits).  However, doing (u32) (s + (s >> 32)) is not
> sufficient to fold a 64-bit sum to 32 bits correctly.  The addition
> can produce a carry out from bit 31, which needs to be added in to
> the sum to produce the correct result.
>
> To fix this, we copy the from64to32() function from lib/checksum.c
> and use that.

This seems to have been broken since ~forever. Do we just not hit that
case very often, or do we just incorrectly report checksum failures?

Should it go to stable?

cheers
