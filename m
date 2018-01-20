Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zP54y6mdJzF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jan 2018 04:57:38 +1100 (AEDT)
Date: Sat, 20 Jan 2018 11:56:55 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/mm: Enhance 'slice' for supporting PPC32
Message-ID: <20180120175655.GY21977@gate.crashing.org>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <87vafyz265.fsf@linux.vnet.ibm.com>
 <84dc1df4-db2f-be11-c1f3-5dddd1e44983@c-s.fr>
 <b4d8f01b-9ee1-ec34-aa0d-5a353064438c@linux.vnet.ibm.com>
 <28c3ba39-ef31-5ff3-7672-3e9d1942be94@c-s.fr>
 <c9ab9a1b-4c77-fdfc-50d1-974388cc3b10@linux.vnet.ibm.com>
 <e2f36c99-1b5d-acf5-12c8-b2b48701011a@c-s.fr>
 <36e8d873-4021-4266-bf5f-287f396ba9e1@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36e8d873-4021-4266-bf5f-287f396ba9e1@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Sat, Jan 20, 2018 at 09:22:50AM +0100, christophe leroy wrote:
> >>>>>>>On PPC32, the address space is limited to 4Gbytes, hence only the 
> >>>>>>>low
> >>>>>>>slices will be used. As of today, the code uses
> >>>>>>>SLICE_LOW_TOP (0x100000000ul) and compares it with addr to determine
> >>>>>>>if addr refers to low or high space.
> >>>>>>>On PPC32, such a (addr < SLICE_LOW_TOP) test is always false because
> >>>>>>>0x100000000ul degrades to 0. Therefore, the patch modifies
> >>>>>>>SLICE_LOW_TOP to (0xfffffffful) and modifies the tests to
> >>>>>>>(addr <= SLICE_LOW_TOP) which will then always be true on PPC32
> >>>>>>>as addr has type 'unsigned long' while not modifying the PPC64
> >>>>>>>behaviour.

It should work to define SLICE_LOW_TOP as 0x100000000ull and keep
everything else the same, no?

> >I don't think so. When I had the missing prototype, the compilation goes 
> >ok, including the final link. Which means at the end the code is not 
> >included since radix_enabled() evaluates to 0.
> >
> >Many many parts of the kernel are based on this assumption.
> 
> Segher, what is your opinion on the above ? Can we consider that a ' if 
> (nbits)' will always be compiled out when nbits is a #define constant, 
> or should we duplicate the macros as suggested in order to avoid 
> unneccessary 'if' test on platforms where 'nbits' is always not null by 
> definition ?

Doing things like

	if (nbits)
		some_undeclared_function();

will likely work in practice if the condition evaluates to false at
compile time, but a) it will warn; b) it is just yuck; and c) it will
not always work (for example, you get the wrong prototype in this case,
not lethal here with most ABIs, but ugh).

Just make sure to declare all functions, or define it to some empty
thing, or #ifdeffery if you have to.  There are many options, it is
not hard, and if it means you have to pull code further apart that is
not so bad: you get cleaner, clearer code.


Segher
