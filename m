Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd1TK4zX2zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 16:55:49 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 3wd1T06T7Pz9ttBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 08:55:32 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vsHhwR4Qszup for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 31 May 2017 08:55:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 3wd1T05z6Jz9ttBn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 08:55:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AC4128B78F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 08:55:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qVl9YdmG9_i1 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 31 May 2017 08:55:45 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.23])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C16C8B89E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 08:55:45 +0200 (CEST)
Subject: Re: usercopy in PPC64
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <d25be832-2030-4bc8-dbc5-4baebb759279@c-s.fr>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <21ab485d-84f9-6803-a2b9-65d3a5928e59@c-s.fr>
Date: Wed, 31 May 2017 08:55:30 +0200
MIME-Version: 1.0
In-Reply-To: <d25be832-2030-4bc8-dbc5-4baebb759279@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 30/05/2017 à 14:36, Christophe LEROY a écrit :
> Hi all powerpc64 experts,
> 
> While looking at the usercopy efficiency for PPC32, I noticed something 
> which looks strange.
> 
> In asm/uaccess.h, raw_copy_from_user() and raw_copy_to_user() implements 
> a fast path using get_user() and put_user() for copies of constant size 
> < 8.
> 
> But INLINE_COPY_FROM_USER and INLINE_COPY_TO_USER are only defined for 
> PPC32, so PPC64 will call __copy_tofrom_user() even for small constant 
> size copies. Is that wanted ?
> 

I tried and built ppc64_defconfig with and without INLINE_COPY_xxx_USER, 
I got the following result:

Without INLINE_COPY_xxx_USER:
System.map:c0000000009b2000 A _etext

With INLINE_COPY_xxx_USER:
System.map:c0000000009c1000 A _etext

So the size increase with inlining is only 0,6%
Wouldn't it be worth it ?

Christophe
