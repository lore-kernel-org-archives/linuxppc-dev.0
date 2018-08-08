Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltKH5sfXzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 23:58:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>, paulus@ozlabs.org
Subject: Re: is there still any need PPC checking for "chosen@0"?
In-Reply-To: <alpine.LFD.2.21.1808061234580.25636@localhost.localdomain>
References: <alpine.LFD.2.21.1808061234580.25636@localhost.localdomain>
Date: Wed, 08 Aug 2018 23:58:57 +1000
Message-ID: <8736vparj2.fsf@concordia.ellerman.id.au>
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

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>   given that there are no .dts files in the current kernel code base
> that define the node name "/chosen@0" instead of the proper "/chosen",

A good portion of PPC machines get their device tree from firmware, not
from a dts that's in the kernel tree, so that's not a good indication.

> is there any need for arch/powerpc/boot/oflib.c to still make this
> test:
>
>         chosen = of_finddevice("/chosen");
>         if (chosen == (phandle) -1) {
>                 chosen = of_finddevice("/chosen@0");   <--- this
>                 if (chosen == (phandle) -1) {
>                         printf("no chosen\n");
>                         return 0;
>                 }
>         }
>
> are there still PPC machines that require the recognition of
> "/chosen@0"?

It was added by Paul in:

66a45dd3620e ("powerpc: Make COFF zImages for old 32-bit powermacs")

So presumably there's an old powermac somewhere that needs it.

Given it's basically 2 extra lines of code I'd be inclined to leave it
alone.

cheers
