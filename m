Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DCE31A0035
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Oct 2015 11:00:20 +1100 (AEDT)
Date: Sat, 3 Oct 2015 19:00:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Missing operand for tlbie instruction on Power7
Message-ID: <20151004000009.GA10997@gate.crashing.org>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
 <1443816930.13186.214.camel@otta>
 <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
 <20151002220051.GA26712@gate.crashing.org> <1443839086.13186.219.camel@otta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443839086.13186.219.camel@otta>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 02, 2015 at 09:24:46PM -0500, Peter Bergner wrote:
> > > Ok, than we can just zero out r5 for example and use it in tlbie as RS,
> > > right?
> > 
> > That won't assemble _unless_ your assembler is in POWER7 mode.  It also
> > won't do the right thing at run time on older machines.
> 
> Correct, getting this to work on both pre-power7 and power7 and later
> is tricky.  One really horrible hack would be to do:
> 
>   li r0,0
>   tlbie r4,0
> 
> On pre-power7, the "0" will be taken as a zero L operand and on
> power7 and later, it'll be r0, but with a zero value we loaded in
> the insn before.  I know, really ugly. :-)

Hide the "li 0,0" somewhere earlier, and write it as "tlbie 4,0", and
don't write a comment -- we *like* tricky!

It should really be a separate macro define for power7 and 4xx etc.;
and the macro should not be called "tlbia", but something that makes
it obvious at the usage sites that it is in fact a macro; and why a
macro anyway, a function call might be better here?


Segher
