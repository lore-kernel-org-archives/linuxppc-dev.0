Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbyZW1K07zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 21:40:19 +1100 (AEDT)
Message-ID: <1459507217.10340.5.camel@ellerman.id.au>
Subject: Re: [PATCH v3] ppc64/book3s: fix branching to out of line handlers
 in relocation kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gabriel Paubert <paubert@iram.es>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Date: Fri, 01 Apr 2016 21:40:17 +1100
In-Reply-To: <20160401063743.GA24955@visitor2.iram.es>
References: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
 <1459491275.10334.6.camel@ellerman.id.au>
 <20160401063743.GA24955@visitor2.iram.es>
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

On Fri, 2016-04-01 at 08:37 +0200, Gabriel Paubert wrote:
> On Fri, Apr 01, 2016 at 05:14:35PM +1100, Michael Ellerman wrote:
> > If you build an allmodconfig, and turn on CONFIG_RELOCATABLE, and then look at
> > the disassembly, you see this:
> > 
> >   c000000000006ffc:       48 00 29 04     b       c000000000009900 <.ret_from_except>
> >   
> >   c000000000007000 <__end_handlers>:
> > 
> > At 0x7000 we have the FWNMI area, which is fixed and can't move. As you see
> > above we end up with only 4 bytes of space between the end of the handlers and
> > the FWNMI area.
> 
> Nitpicking a bit, if I correctly read the above disassembly and there is an instuction
> at 0x6ffc, the free space is exactly 0! 

Well spotted! It was of course an April fools .. joke ? :)

> > None of that's your fault, it's just the nature of the code in there, it's very
> > space constrained.
> 
> Calling it space very constrained makes you win the understatement of the month 
> award, on April fool's day :-)

Well there are some holes here and there, so we could write two instructions,
then branch to the next hole, five more instructions, branch to the next hole
etc. But that makes for hard to read code :)

cheers
