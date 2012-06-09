Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 94F0BB6FCC
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2012 19:39:53 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/15] powerpc: fixes for instructions not using correct
 register naming
References: <1339155365.316308.981577666228.qpush@ale>
 <20120608113605.91B88D43B2F__24549.446340143$1339156128$gmane$org@localhost.localdomain>
 <m2sje6t2y5.fsf@igel.home> <1339195362.24838.50.camel@pasglop>
 <m2boktnfh9.fsf@linux-m68k.org> <1339226228.24838.74.camel@pasglop>
Date: Sat, 09 Jun 2012 11:39:43 +0200
In-Reply-To: <1339226228.24838.74.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Sat, 09 Jun 2012 17:17:08 +1000")
Message-ID: <m2y5nwn7s0.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2012-06-09 at 08:53 +0200, Andreas Schwab wrote:
>> 
>> > The macro system we use cannot do that (it will prefix with REG_),
>> since
>> > both arguments are registers we must use R0 in this case.
>> 
>> So define a ___PPC_RA0 macro that doesn't do that.
>
> But then we lose the checking for other instructions :-)

??? There is no loss of checking for instructions that do not use
___PPC_RA0.

> Unless we start being nasty and defining a different macro form for RA
> which can be 0...

That's what ___PPC_RA0 is all about.

> I'd rather not go there unless we absolutely have to...

Having to use R0 for an insn that does *not* use r0 is clearly a step
backwards.

> What would be nice also would be if we had a gas option to enforce the
> use of % for register names.

If gas is ever changed that way you have to be explict about 0 vs. %r0
anyway.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
