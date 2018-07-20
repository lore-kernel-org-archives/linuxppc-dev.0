Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X9001mBQzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 22:18:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, malat@debian.org
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
In-Reply-To: <a41ed163-3db6-f204-4262-d428ec0a8d7a@infradead.org>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <a41ed163-3db6-f204-4262-d428ec0a8d7a@infradead.org>
Date: Fri, 20 Jul 2018 22:18:17 +1000
Message-ID: <87sh4e85iu.fsf@concordia.ellerman.id.au>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> On 07/09/2018 07:24 AM, Michael Ellerman wrote:
>> Because the allmodconfig logic just sets every symbol to M or Y, it
>> has the effect of always generating a 64-bit config, because
>> CONFIG_PPC64 becomes Y.
>> 
>> So to make it easier for folks to test 32-bit code, provide a phony
>> defconfig target that generates a 32-bit allmodconfig.
>> 
>> The 32-bit port has several mutually exclusive CPU types, we choose
>> the Book3S variants as that's what the help text in Kconfig says is
>> most common.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Hi Michael,
>
> ppc32_allmodconfig sets CONFIG_ISA=y (and other related symbols) and
> CONFIG_PPC_CHRP=y.  But my builds are failing because they are missing
> the functions isa_bus_to_virt() and isa_virt_to_bus().
>
> Any ideas?

It's old legacy cruft that we've never implemented :)

I don't know if it's possible to implement it for CHRP, Ben implied it
might be, back in 2009:

  https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073232.html

But of course nothing came of it.


It looks like there's only a handful of drivers left using them, we
should probably just mark them as not buildable on PPC.

Arnd did something similar for ARM in:
  e9b106b8fbdb ("net: lance,ni64: don't build for ARM")


cheers
