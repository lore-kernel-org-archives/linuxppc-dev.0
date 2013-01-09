Return-Path: <xenidis@gmail.com>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5E0D2C018B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 09:19:53 +1100 (EST)
Received: by mail-ie0-f180.google.com with SMTP id c10so2747476ieb.39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2013 14:19:51 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and enhanced
 prefetch
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1355848269.5180.41.camel@otta>
Date: Wed, 9 Jan 2013 16:19:53 -0600
Message-Id: <9A768D6E-D4DC-4F8B-ADAC-A1E953B38462@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten> <1355790373.5180.26.camel@otta>
 <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
 <1355848269.5180.41.camel@otta>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: "paulus@samba.org Mackerras" <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Kumar Gala <kumar.gala@gmail.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 18, 2012, at 10:31 AM, Peter Bergner <bergner@vnet.ibm.com> =
wrote:

> On Tue, 2012-12-18 at 07:28 -0600, Jimi Xenidis wrote:
>> On Dec 17, 2012, at 6:26 PM, Peter Bergner <bergner@vnet.ibm.com> =
wrote:
>>> Jimi, are you using an "old" binutils from before my patch that
>>> changed the operand order for these types of instructions?
>>>=20
>>>   http://sourceware.org/ml/binutils/2009-02/msg00044.html
>>=20
>> Actually, this confused me as well, that embedded has the same =
instruction
>> encoding but different mnemonic.
>=20
> The mnemonic is the same (ie, dcbtst), and yes, the encoding is the =
same.
> All that is different is the accepted operand ordering...and yes, it =
is
> very unfortunate the operand ordering is different between embedded =
and
> server. :(
>=20
>=20
>> I was under the impression that the assembler made no instruction =
decisions
>> based on CPU.  So your only hint would be that '0b' prefix.
>> Does AS even see that?
>=20
> GAS definitely makes decisions based on CPU (ie, -m<cpu> option).  =
Below is
> the GAS code used in recognizing the dcbtst instruction.  This shows =
that
> the "server" operand ordering is enabled for POWER4 and later cpus =
while
> the "embedded" operand ordering is enabled for pre POWER4 cpus (yes, =
not
> exactly a server versus embedded trigger, but that's we agreed on to
> mitigate breaking any old asm code out there).
>=20
> {"dcbtst",	X(31,246),	X_MASK,      POWER4,	PPCNONE,	=
{RA0, RB, CT}},
> {"dcbtst",	X(31,246),	X_MASK,      PPC|PPCVLE, POWER4,	=
{CT, RA0, RB}},
>=20
> GAS doesn't look at how the operands are written to try and guess what
> operand ordering you are attempting to use.  Rather, it knows what =
ordering
> it expects and the values had better match that ordering.
>=20

I agree, but that means it is impossible for the same .S file can be =
compiled but -mcpu=3De500mc and -mcpu=3Dpowerpc?
So either these files have to be Book3S versus Book3E --or-- we use a =
CPP macro to get them right.
FWIW, I prefer the latter which allows more code reuse.

-jx


>=20
> Peter
>=20
>=20
>=20
