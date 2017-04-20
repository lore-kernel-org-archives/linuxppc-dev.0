Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7xPS6g0KzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 21:25:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>,
 'Christophe Leroy' <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/32: Move entry_32 functions just after HEAD
 functions.
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFD56A5@AcuExch.aculab.com>
References: <20170418070126.A18EF67952@localhost.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD56A5@AcuExch.aculab.com>
Date: Thu, 20 Apr 2017 21:25:32 +1000
Message-ID: <878tmv48yb.fsf@concordia.ellerman.id.au>
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

David Laight <David.Laight@ACULAB.COM> writes:

> From: Christophe Leroy
>> By default, PPC8xx PINs an ITLB on the first 8M of memory in order
>> to avoid any ITLB miss on kernel code.
>> However, with some debug functions like DEBUG_PAGEALLOC and
>> (soon to come) DEBUG_RODATA, the PINned TLB is invalidated soon
>> after startup so ITLB missed start to happen also on the kernel code.
>> 
>> In order to avoid any ITLB miss in a critical section, we have to
>> ensure that their is no page boundary crossed between the setup of
>> a new value in SRR0/SRR1 and the associated RFI. This cannot be done
>> easily if entry_32 functions sits in the middle of other .text
>> functions. By placing entry_32 just after the .head section (as already
>> done for entry_64 on PPC64), we can more easily ensure the issue
>> doesn't happen.
>
> Shouldn't this be done by putting all the functions that 'matter'
> into a named section instead of relying on the order of the input files?
> (Which is what I think this is doing.)

Yeah that is fragile if there's nothing more to it.

I'm not sure if we need a special section. If the functions that must
not cross a page boundary are aligned to a page boundary (with .align)
then that would also work wouldn't it?

cheers
