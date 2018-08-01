Return-Path: <srs0=qdnh=kq=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gGzg3gJtzF1Pr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 12:12:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41gGzg2zDNz8t9y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 12:12:47 +1000 (AEST)
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41gGzg0BYVz9s0R
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2018 12:12:46 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id m16-v6so7998996pls.11
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 19:12:46 -0700 (PDT)
Date: Wed, 1 Aug 2018 12:12:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, paulus@samba.org
Subject: Re: [PATCH 00/16] Finally remove PSERIES from exception naming
Message-ID: <20180801121239.55b2d93d@roar.ozlabs.ibm.com>
In-Reply-To: <20180726130717.18761-1-mpe@ellerman.id.au>
References: <20180726130717.18761-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Jul 2018 23:07:01 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> This finally annoyed me enough to do something about it, I foolishly started
> pulling the string and now here I am.
> 
> I think the end result is sufficiently more readable to justify the churn. I
> particularly like that we now have EXCEPTION_PROLOG_0/1/2.
> 
> It will cause some pain for backports, but Nick plans to rewrite the exception
> vectors entirely at some point so this will be trivial in comparison.

Yeah I have no problem with this series. I'll get onto that rewrite
again soon.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> 
> cheers
> 
> 
> Michael Ellerman (16):
>   powerpc/64s: Move SET_SCRATCH0() into EXCEPTION_PROLOG_PSERIES()
>   powerpc/64s: Move SET_SCRATCH0() into EXCEPTION_RELON_PROLOG_PSERIES()
>   powerpc/64s: Rename STD_EXCEPTION_PSERIES to STD_EXCEPTION
>   powerpc/64s: Rename STD_EXCEPTION_PSERIES_OOL to STD_EXCEPTION_OOL
>   powerpc/64s: Rename STD_RELON_EXCEPTION_PSERIES to STD_RELON_EXCEPTION
>   powerpc/64s: Rename STD_RELON_EXCEPTION_PSERIES_OOL to
>     STD_RELON_EXCEPTION_OOL
>   powerpc/64s: Rename EXCEPTION_PROLOG_PSERIES_1 to EXCEPTION_PROLOG_2
>   powerpc/64s: Remove PSERIES from the NORI macros
>   powerpc/64s: Rename EXCEPTION_RELON_PROLOG_PSERIES_1
>   powerpc/64s: Rename EXCEPTION_RELON_PROLOG_PSERIES
>   powerpc/64s: Rename EXCEPTION_PROLOG_PSERIES to EXCEPTION_PROLOG
>   powerpc/64s: Drop _MASKABLE_EXCEPTION_PSERIES()
>   powerpc/64s: Drop _MASKABLE_RELON_EXCEPTION_PSERIES()
>   powerpc/64s: Remove PSERIES naming from the MASKABLE macros
>   powerpc/64s: Drop unused loc parameter to MASKABLE_EXCEPTION macros
>   powerpc/64s: Don't use __MASKABLE_EXCEPTION unnecessarily
> 
>  arch/powerpc/include/asm/exception-64s.h | 117 ++++++++++++++-----------------
>  arch/powerpc/include/asm/head-64.h       |  16 ++---
>  arch/powerpc/kernel/exceptions-64s.S     |  32 ++++-----
>  3 files changed, 72 insertions(+), 93 deletions(-)
> 
