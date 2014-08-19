Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33F4B1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:31:00 +1000 (EST)
Message-ID: <1408487444.4058.40.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Make 256k pages depend on PPC32=n
From: Scott Wood <scottwood@freescale.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 19 Aug 2014 17:30:44 -0500
In-Reply-To: <CAJhHMCAA3rLkszp=Fk9mC81f9+qe8JU_TB6RG3rzdnmpR07jJA@mail.gmail.com>
References: <1408484166-20711-1-git-send-email-bobby.prani@gmail.com>
 <1408486751.4058.37.camel@snotra.buserror.net>
 <CAJhHMCAA3rLkszp=Fk9mC81f9+qe8JU_TB6RG3rzdnmpR07jJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, "open list:LINUX
 FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-19 at 18:23 -0400, Pranith Kumar wrote:
> On Tue, Aug 19, 2014 at 6:19 PM, Scott Wood <scottwood@freescale.com> wrote:
> 
> >>  config PPC_256K_PAGES
> >>       bool "256k page size" if 44x
> >> -     depends on !STDBINUTILS
> >> +     depends on !PPC32 && !STDBINUTILS
> >>       help
> >>         Make the page size 256k.
> >>
> >
> > How will this ever be selected then?  44x is 32-bit only.
> 
> Indeed. I am actually confused about the error which is being thrown
> here. The operand (65536) is actually within the range. Any suggestions
> on how to fix this?

It's not within range of "li".  I wonder if whatever non-"STD" binutils
this is supposed to be used with is rewriting it into an lis
instruction.  This sort of external dependency is a poor fit for the
randconfig concept (plus, shouldn't the symbol be indicating what
binutils you're supposed to have rather than anything that isn't
"standard"?).

In any case, you could use something like LOAD_REG_IMMEDIATE().

-Scott
