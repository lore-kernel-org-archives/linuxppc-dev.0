Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbyWn00KwzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:37:56 +1100 (AEDT)
Message-ID: <1459507074.10340.3.camel@ellerman.id.au>
Subject: Re: [PATCH v3] ppc64/book3s: fix branching to out of line handlers
 in relocation kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Fri, 01 Apr 2016 21:37:54 +1100
In-Reply-To: <56FE1AD2.5020304@linux.vnet.ibm.com>
References: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
 <1459491275.10334.6.camel@ellerman.id.au>
 <56FE1AD2.5020304@linux.vnet.ibm.com>
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

On Fri, 2016-04-01 at 12:23 +0530, Hari Bathini wrote:
> 
> On 04/01/2016 11:44 AM, Michael Ellerman wrote:
> > On Wed, 2016-03-30 at 23:49 +0530, Hari Bathini wrote:
> > > Some of the interrupt vectors on 64-bit POWER server processors  are
> > > only 32 bytes long (8 instructions), which is not enough for the full
> > ...
> > > Let us fix this undependable code path by moving these OOL handlers below
> > > __end_interrupts marker to make sure we also copy these handlers to real
> > > address 0x100 when running a relocatable kernel. Because the interrupt
> > > vectors branching to these OOL handlers are not long enough to use
> > > LOAD_HANDLER() for branching as discussed above.
> > > 
> > ...
> > > changes from v2:
> > > 2. Move the OOL handlers before __end_interrupts marker instead of moving the __end_interrupts marker
> > > 3. Leave __end_handlers marker as is.
> > Hi Hari,
> > 
> > Thanks for trying this. In the end I've decided it's not a good option.
> > 
> > If you build an allmodconfig, and turn on CONFIG_RELOCATABLE, and then look at
> > the disassembly, you see this:
> > 
> >    c000000000006ffc:       48 00 29 04     b       c000000000009900 <.ret_from_except>
> >    
> >    c000000000007000 <__end_handlers>:
> > 
> > At 0x7000 we have the FWNMI area, which is fixed and can't move. As you see
> > above we end up with only 4 bytes of space between the end of the handlers and
> > the FWNMI area.
> > 
> > So any tiny change that adds two more instructions prior to 0x7000 will then
> > fail to build.
> 
> Hi Michael,
> 
> I agree. But the OOL handlers that are moved up in v3 were below
> 0x7000 earlier as well and moving them below __end_interrupts marker
> shouldn't make any difference in terms of space consumption at least in
> comparison between v2 & v3. So, I guess picking either v2 or v3
> doesn't change this for better.

It does make a difference, due to alignment. Prior to your patch we have ~24
bytes free.

> Also, there is code between __end_interrupts and __end_handlers
> that is not location dependent as long as it is within 64K (0x10000)
> that can be moved above 0x8000, if need be.
 
That's true, but that sort of change is unlikely to backport well. And we need
to backport this fix to everything.

But if you can get that to work I'll consider it. I tried quickly but couldn't
get it working, due to problems with the feature else sections being too far
away from.

cheers
