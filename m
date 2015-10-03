Return-Path: <bergner@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A5A51A0046
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 12:26:00 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Fri, 2 Oct 2015 20:25:59 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3A5923E40041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 20:25:51 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t932OcQH9896332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 19:24:38 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t932PotF018789
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 20:25:51 -0600
Subject: Re: Missing operand for tlbie instruction on Power7
From: Peter Bergner <bergner@vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Laura Abbott <labbott@redhat.com>, Paul
 Mackerras <paulus@samba.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20151002220051.GA26712@gate.crashing.org>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
 <1443816930.13186.214.camel@otta>
 <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
 <20151002220051.GA26712@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Oct 2015 21:24:46 -0500
Message-ID: <1443839086.13186.219.camel@otta>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-02 at 17:00 -0500, Segher Boessenkool wrote:
> On Sat, Oct 03, 2015 at 12:37:35AM +0300, Denis Kirjanov wrote:
> > >> -0:     tlbie   r4;                             \
> > >> +0:     tlbie   r4, 0;                          \
> > >
> > > This isn't correct.  With POWER7 and later (which this compile
> > > is, since it's on LE), the tlbie instruction takes two register
> > > operands:
> > >
> > >     tlbie RB, RS
> > >
> > > The tlbie instruction on pre POWER7 cpus had one required register
> > > operand (RB) and an optional second L operand, where if you omitted
> > > it, it was the same as using "0":
> > >
> > >     tlbie RB, L
> > >
> > > This is a POWER7 and later build, so your change which adds the "0"
> > > above is really adding r0 for RS.  The new tlbie instruction doesn't
> > > treat r0 specially, so you'll be using whatever random bits which
> > > happen to be in r0 which I don't think that is what you want.
> > 
> > Ok, than we can just zero out r5 for example and use it in tlbie as RS,
> > right?
> 
> That won't assemble _unless_ your assembler is in POWER7 mode.  It also
> won't do the right thing at run time on older machines.

Correct, getting this to work on both pre-power7 and power7 and later
is tricky.  One really horrible hack would be to do:

  li r0,0
  tlbie r4,0

On pre-power7, the "0" will be taken as a zero L operand and on
power7 and later, it'll be r0, but with a zero value we loaded in
the insn before.  I know, really ugly. :-)

Peter
