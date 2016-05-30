Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ2WS4T2PzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 13:42:44 +1000 (AEST)
Message-ID: <1464579764.31883.2.camel@ellerman.id.au>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for
 book3s 64
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 30 May 2016 13:42:44 +1000
In-Reply-To: <20160530090833.4400ac83@kryten>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
 <1464557231.3078.185.camel@kernel.crashing.org>
 <20160530090833.4400ac83@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-30 at 09:08 +1000, Anton Blanchard via Linuxppc-dev wrote:
> > That is surprising, do we have any idea what specifically increases
> > the overhead so significantly ? Does gcc know about ldbrx/stdbrx ? I
> > notice in our io.h for example we still do manual ld/std + swap
> > because old processors didn't know these, we should fix that for
> > CONFIG_POWER8 (or is it POWER7 that brought these ?).
> 
> The futex issue seems to be __get_user_pages_fast():
> 
>         ld      r11,0(r6)
>         ...
>         rldicl  r8,r11,32,32
>         rotlwi  r28,r11,24
>         rlwimi  r28,r11,8,8,15
>         rotlwi  r6,r8,24
>         rlwimi  r28,r11,8,24,31
>         rlwimi  r6,r8,8,8,15
>         rlwimi  r6,r8,8,24,31
>         rldicr  r28,r28,32,31
>         or      r28,r28,r6
>         cmpdi   cr7,r28,0
>         beq     cr7,2428
> 
> That's a whole lot of work just to check if a pte is zero. I assume
> the reason gcc can't replace this with a byte reversed load is that
> we access the pte via the READ_ONCE() macro.

Did I mention we need a bswap instruction?

We can possibly improve some of them by doing the comparison on the raw value,
eg. see hash__pte_same().

The above is from pgd_none() ?

cheers
