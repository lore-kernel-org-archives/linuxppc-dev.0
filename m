Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbvFZ0T1FzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 19:10:26 +1100 (AEDT)
Received: from villa.puc.rediris.es (villa.puc.rediris.es [130.206.18.23])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qbvFY4WPlz9s9G
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2016 19:10:25 +1100 (AEDT)
Date: Fri, 1 Apr 2016 08:37:43 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] ppc64/book3s: fix branching to out of line handlers
 in relocation kernel
Message-ID: <20160401063743.GA24955@visitor2.iram.es>
References: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
 <1459491275.10334.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459491275.10334.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    Hi Michael,

On Fri, Apr 01, 2016 at 05:14:35PM +1100, Michael Ellerman wrote:
> On Wed, 2016-03-30 at 23:49 +0530, Hari Bathini wrote:
> > Some of the interrupt vectors on 64-bit POWER server processors  are
> > only 32 bytes long (8 instructions), which is not enough for the full
> ...
> > Let us fix this undependable code path by moving these OOL handlers below
> > __end_interrupts marker to make sure we also copy these handlers to real
> > address 0x100 when running a relocatable kernel. Because the interrupt
> > vectors branching to these OOL handlers are not long enough to use
> > LOAD_HANDLER() for branching as discussed above.
> > 
> ...
> > changes from v2:
> > 2. Move the OOL handlers before __end_interrupts marker instead of moving the __end_interrupts marker
> > 3. Leave __end_handlers marker as is.
> 
> Hi Hari,
> 
> Thanks for trying this. In the end I've decided it's not a good option.
> 
> If you build an allmodconfig, and turn on CONFIG_RELOCATABLE, and then look at
> the disassembly, you see this:
> 
>   c000000000006ffc:       48 00 29 04     b       c000000000009900 <.ret_from_except>
>   
>   c000000000007000 <__end_handlers>:
> 
> At 0x7000 we have the FWNMI area, which is fixed and can't move. As you see
> above we end up with only 4 bytes of space between the end of the handlers and
> the FWNMI area.

Nitpicking a bit, if I correctly read the above disassembly and there is an instuction
at 0x6ffc, the free space is exactly 0! 

> 
> So any tiny change that adds two more instructions prior to 0x7000 will then
> fail to build.

Even one instruction provided I still know how to count.

> 
> None of that's your fault, it's just the nature of the code in there, it's very
> space constrained.

Calling it space very constrained makes you win the understatement of the month 
award, on April fool's day :-)

    Regards,
    Gabriel
