Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f9P11XDjzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 16:57:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Spirkov <AlexeiS@astrosoft.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "trivial\@kernel.org" <trivial@kernel.org>,
 "andrew\@ncrmnt.org" <andrew@ncrmnt.org>
Subject: RE: [PATCH] Adds __init annotation at mmu_init_secondary func
In-Reply-To: <AM5PR03MB28496A9D6FD7B175312E48F6C92A0@AM5PR03MB2849.eurprd03.prod.outlook.com>
References: <AM5PR03MB28499BE4A0B6200F7DA83835C92B0@AM5PR03MB2849.eurprd03.prod.outlook.com>
 <87tvolrm43.fsf@concordia.ellerman.id.au>
 <AM5PR03MB28496A9D6FD7B175312E48F6C92A0@AM5PR03MB2849.eurprd03.prod.outlook.com>
Date: Mon, 30 Jul 2018 16:57:22 +1000
Message-ID: <87r2jli52l.fsf@concordia.ellerman.id.au>
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

Alexey Spirkov <AlexeiS@astrosoft.ru> writes:

> Without any additional option 
>
> WARNING: modpost: Found 1 section mismatch(es).
>
> If detailed debug is switched on than:
>
> WARNING: vmlinux.o(.text+0x142ac): Section mismatch in reference from the function mmu_init_secondary() to the function .init.text:ppc44x_pin_tlb()
> The function mmu_init_secondary() references
> the function __init ppc44x_pin_tlb().
> This is often because mmu_init_secondary lacks a __init 
> annotation or the annotation of ppc44x_pin_tlb is wrong.

Ah right, thanks.

I checked ppc47x_pin_tlb() but didn't spot the call to ppc44x_pin_tlb().

cheers
