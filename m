Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3581F1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 08:01:00 +1000 (AEST)
Date: Fri, 2 Oct 2015 17:00:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Peter Bergner <bergner@vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Missing operand for tlbie instruction on Power7
Message-ID: <20151002220051.GA26712@gate.crashing.org>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
 <1443816930.13186.214.camel@otta>
 <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 03, 2015 at 12:37:35AM +0300, Denis Kirjanov wrote:
> >> -0:     tlbie   r4;                             \
> >> +0:     tlbie   r4, 0;                          \
> >
> > This isn't correct.  With POWER7 and later (which this compile
> > is, since it's on LE), the tlbie instruction takes two register
> > operands:
> >
> >     tlbie RB, RS
> >
> > The tlbie instruction on pre POWER7 cpus had one required register
> > operand (RB) and an optional second L operand, where if you omitted
> > it, it was the same as using "0":
> >
> >     tlbie RB, L
> >
> > This is a POWER7 and later build, so your change which adds the "0"
> > above is really adding r0 for RS.  The new tlbie instruction doesn't
> > treat r0 specially, so you'll be using whatever random bits which
> > happen to be in r0 which I don't think that is what you want.
> 
> Ok, than we can just zero out r5 for example and use it in tlbie as RS,
> right?

That won't assemble _unless_ your assembler is in POWER7 mode.  It also
won't do the right thing at run time on older machines.

Where is this tlbia macro used at all, for 64-bit machines?


Segher
