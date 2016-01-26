Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5981F1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:13:51 +1100 (AEDT)
Message-ID: <1453778024.24248.4.camel@ellerman.id.au>
Subject: Re: [RFC PATCH] PPC32: Fix build failure caused by missing dirty
 pte handlers
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Date: Tue, 26 Jan 2016 14:13:44 +1100
In-Reply-To: <1453731778-18464-1-git-send-email-bobby.prani@gmail.com>
References: <1453731778-18464-1-git-send-email-bobby.prani@gmail.com>
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

On Mon, 2016-01-25 at 09:22 -0500, Pranith Kumar wrote:

> In 4.5-rc1, I am getting a build failure as follows:
> 
> mm/memory.c: In function ‘do_swap_page’:
> mm/memory.c:2573:9: error: implicit declaration of function ‘pte_mksoft_dirty’
> [-Werror=implicit-function-declaration]
>    pte = pte_mksoft_dirty(pte);
> 
> The soft dirty pte handlers are declared only for PPC64 on PPC_BOOK3S in
> arch/powerpc/include/asm/book3s/64/hash.h and missing in the 32-bit arch.
> 
> Avoid this error by not setting HAVE_ARCH_SOFT_DIRTY for 32-bit system.

It's building for me, what config are you using?

http://kisskb.ellerman.id.au/kisskb/buildresult/12597204/

cheers
