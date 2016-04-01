Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbrgw1z1LzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 17:14:36 +1100 (AEDT)
Message-ID: <1459491275.10334.6.camel@ellerman.id.au>
Subject: Re: [PATCH v3] ppc64/book3s: fix branching to out of line handlers
 in relocation kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Fri, 01 Apr 2016 17:14:35 +1100
In-Reply-To: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
References: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
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

On Wed, 2016-03-30 at 23:49 +0530, Hari Bathini wrote:
> Some of the interrupt vectors on 64-bit POWER server processors  are
> only 32 bytes long (8 instructions), which is not enough for the full
...
> Let us fix this undependable code path by moving these OOL handlers below
> __end_interrupts marker to make sure we also copy these handlers to real
> address 0x100 when running a relocatable kernel. Because the interrupt
> vectors branching to these OOL handlers are not long enough to use
> LOAD_HANDLER() for branching as discussed above.
> 
...
> changes from v2:
> 2. Move the OOL handlers before __end_interrupts marker instead of moving the __end_interrupts marker
> 3. Leave __end_handlers marker as is.

Hi Hari,

Thanks for trying this. In the end I've decided it's not a good option.

If you build an allmodconfig, and turn on CONFIG_RELOCATABLE, and then look at
the disassembly, you see this:

  c000000000006ffc:       48 00 29 04     b       c000000000009900 <.ret_from_except>
  
  c000000000007000 <__end_handlers>:

At 0x7000 we have the FWNMI area, which is fixed and can't move. As you see
above we end up with only 4 bytes of space between the end of the handlers and
the FWNMI area.

So any tiny change that adds two more instructions prior to 0x7000 will then
fail to build.

None of that's your fault, it's just the nature of the code in there, it's very
space constrained.

For now I'll take your v2, but I'll edit the comment and drop the removal of
__end_handlers.

cheers
