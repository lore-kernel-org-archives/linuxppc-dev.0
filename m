Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42C812C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 06:54:16 +1100 (EST)
Message-ID: <1381866837.17841.21.camel@pasglop>
Subject: Re: Perf not resolving all symbols, showing 0x7ffffxxx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Hicks <mort@bork.org>
Date: Tue, 15 Oct 2013 14:53:57 -0500
In-Reply-To: <CAJUS3XmN2WNJ1cnorb5vfas7mB6tdNLxuupFja=u_wYS=cxmdQ@mail.gmail.com>
References: <CAJUS3Xn4tHKvDK8tzLw09+zsEAJHEScV2DbZhH9KkYL-5iCmUA@mail.gmail.com>
 <CAJUS3X=LVHDMa+CTFS=O=F=DfU1=0cgcNzn-mEvXGaDXEZ+CBA@mail.gmail.com>
 <1381851009.17841.14.camel@pasglop>
 <CAJUS3XmN2WNJ1cnorb5vfas7mB6tdNLxuupFja=u_wYS=cxmdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-15 at 14:44 -0400, Martin Hicks wrote:
> On Tue, Oct 15, 2013 at 11:30 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2013-10-15 at 09:59 -0400, Martin Hicks wrote:
> >> I've tracked the start of the strange instruction pointers in 'perf
> >> report' to a commit by Anton:
> >>
> >> commit 75382aa72f06823db7312ad069c3bae2eb3f8548
> >> Author: Anton Blanchard <anton@samba.org>
> >> Date:   Tue Jun 26 01:01:36 2012 +0000
> >>
> >>     powerpc/perf: Move code to select SIAR or pt_regs into perf_read_regs
> >>
> >> I don't know enough about PPC to know what's going on, but reverting
> >> the changes to perf_instruction_pointer() gets me reasonable 'perf
> >> report' output with 3.11.
> >
> > This is an e300 core right ? (603...). Do that have an SIAR at all
> > (Scott ?)
> 
> Yes, e300c3.

Ok so I have a hard time figuring out how that patch can make a
difference since for all I can see, there is no perf backend upstream
for e300 at all :-(

I must certainly be missing something ... Scott, can you have a look ?

Cheers,
Ben.
