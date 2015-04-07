Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 621FA1A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 07:20:07 +1000 (AEST)
Message-ID: <1428441592.22867.466.camel@freescale.com>
Subject: Re: powerpc32: fix warning from include/linux/mm.h
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Tue, 7 Apr 2015 16:19:52 -0500
In-Reply-To: <5523905E.6050007@c-s.fr>
References: <20141205112020.640FA1A5D4F@localhost.localdomain>
 <20150320235213.GA1233@home.buserror.net> <5523905E.6050007@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 10:07 +0200, leroy christophe wrote:
> Le 21/03/2015 00:52, Scott Wood a écrit :
> > On Fri, Dec 05, 2014 at 12:20:20PM +0100, LEROY Christophe wrote:
> >> include/linux/mm.h: In function 'is_vmalloc_addr':
> >> include/linux/mm.h:367:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
> >>    return addr >= VMALLOC_START && addr < VMALLOC_END;
> >>                ^
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   arch/powerpc/include/asm/pgtable-ppc32.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > That warning doesn't appear to be enabled.  What config are you seeing
> > this with?
> I'm used to adding EXTRA_CFLAGS=-Wextra  when checking my own drivers, 
> as it helps finding additional bugs.

It also produces a lot of noise, which is why Linux doesn't enable it.
E.g. it enables useless "unused parameter" warnings all over the place.

> When doing that, the only warnings I get outside of my own code are this 
> one, and the other one in my proposed patch identified "powerpc32: fix 
> warning from include/asm-generic/termios-base.h"
> 
> I though it would be worth fixing those two warnings in order to get a 
> perfectly clean code.

In general I don't think we should clutter up the code with suppression
for warnings we don't enable, but in this case we do end up with a value
that would be negative if considered as signed.  Instead of changing
VMALLOC_OFFSET, though, I'd address it where the problem is actually
introduced -- which is casting high_memory to (long) rather than
(unsigned long) or (uintptr_t).

-Scott
