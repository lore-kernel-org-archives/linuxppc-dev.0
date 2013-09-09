Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 55A732C011E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 20:09:30 +1000 (EST)
Message-ID: <1378721359.11525.3.camel@pasglop>
Subject: Re: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 09 Sep 2013 20:09:19 +1000
In-Reply-To: <20130908223559.GA495@iris.ozlabs.ibm.com>
References: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
 <20130908223559.GA495@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-09 at 08:35 +1000, Paul Mackerras wrote:
> On Fri, Sep 06, 2013 at 10:13:00AM -0500, Tom Musta wrote:
> > To: linuxppc-dev@lists.ozlabs.org
> > Subject: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
> > From: Tom Musta <tommusta@gmail.com>
> > 
> > PowerISA uses instruction bit 21 to indicate that the overflow (OV) bit
> > of the XER is to be set, as well as its corresponding sticky bit (SO).
> > This patch addresses two defects in the implementation of the PowerISA
> > single step code for this category of instructions:  (a) the OE=1 case
> > is not correctly accounted for in the case statement for the extended
> > opcode handling.  (b) the implementation is not setting XER[OV] and
> > XER[SO].
> 
> Are you seeing any actual problems arising from the OE=1 instructions
> not being emulated?  This code was designed primarily for emulating
> instructions in the kernel, which is written in C, and the C compiler
> doesn't emit OE=1 instructions -- or at least it didn't in the past.
> So, does the impetus for this change come because the C compiler is
> now emitting these instructions, or because this code is being used on
> non-kernel instructions, or just for completeness?  Your patch
> description needs to include answers to these kinds of questions.

Isn't that code occasionally used with uprobes too nowadays  ?

Cheers,
Ben.

> Also, you need to indent your code correctly according to
> Documentation/CodingStyle.
> 
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
