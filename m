Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8363A2C0344
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 07:22:29 +1100 (EST)
Message-ID: <1381868527.7979.713.camel@snotra.buserror.net>
Subject: Re: Perf not resolving all symbols, showing 0x7ffffxxx
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 15 Oct 2013 15:22:07 -0500
In-Reply-To: <1381866837.17841.21.camel@pasglop>
References: <CAJUS3Xn4tHKvDK8tzLw09+zsEAJHEScV2DbZhH9KkYL-5iCmUA@mail.gmail.com>
 <CAJUS3X=LVHDMa+CTFS=O=F=DfU1=0cgcNzn-mEvXGaDXEZ+CBA@mail.gmail.com>
 <1381851009.17841.14.camel@pasglop>
 <CAJUS3XmN2WNJ1cnorb5vfas7mB6tdNLxuupFja=u_wYS=cxmdQ@mail.gmail.com>
 <1381866837.17841.21.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-15 at 14:53 -0500, Benjamin Herrenschmidt wrote:
> On Tue, 2013-10-15 at 14:44 -0400, Martin Hicks wrote:
> > On Tue, Oct 15, 2013 at 11:30 AM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > On Tue, 2013-10-15 at 09:59 -0400, Martin Hicks wrote:
> > >> I've tracked the start of the strange instruction pointers in 'perf
> > >> report' to a commit by Anton:
> > >>
> > >> commit 75382aa72f06823db7312ad069c3bae2eb3f8548
> > >> Author: Anton Blanchard <anton@samba.org>
> > >> Date:   Tue Jun 26 01:01:36 2012 +0000
> > >>
> > >>     powerpc/perf: Move code to select SIAR or pt_regs into perf_read_regs
> > >>
> > >> I don't know enough about PPC to know what's going on, but reverting
> > >> the changes to perf_instruction_pointer() gets me reasonable 'perf
> > >> report' output with 3.11.
> > >
> > > This is an e300 core right ? (603...). Do that have an SIAR at all
> > > (Scott ?)
> > 
> > Yes, e300c3.
> 
> Ok so I have a hard time figuring out how that patch can make a
> difference since for all I can see, there is no perf backend upstream
> for e300 at all :-(
> 
> I must certainly be missing something ... Scott, can you have a look ?

e300c3 has a core-fsl-emb style performance monitor (though Linux
doesn't support it yet).  If a bug was bisected to a change in
core-book3s.c, then it's probably a coincidence due to moving code
around.

-Scott
