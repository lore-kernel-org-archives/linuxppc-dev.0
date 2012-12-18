Return-Path: <bergner@vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 674EA2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 03:31:57 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Tue, 18 Dec 2012 11:31:51 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 48351C9005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 11:31:48 -0500 (EST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBIGVlma261378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 11:31:47 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBIGVP5M021011
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 09:31:26 -0700
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and
 enhanced prefetch
From: Peter Bergner <bergner@vnet.ibm.com>
To: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten> <1355790373.5180.26.camel@otta>
 <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 Dec 2012 10:31:09 -0600
Message-ID: <1355848269.5180.41.camel@otta>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Kumar Gala <kumar.gala@gmail.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-12-18 at 07:28 -0600, Jimi Xenidis wrote:
> On Dec 17, 2012, at 6:26 PM, Peter Bergner <bergner@vnet.ibm.com> wrote:
> > Jimi, are you using an "old" binutils from before my patch that
> > changed the operand order for these types of instructions?
> > 
> >    http://sourceware.org/ml/binutils/2009-02/msg00044.html
> 
> Actually, this confused me as well, that embedded has the same instruction
> encoding but different mnemonic.

The mnemonic is the same (ie, dcbtst), and yes, the encoding is the same.
All that is different is the accepted operand ordering...and yes, it is
very unfortunate the operand ordering is different between embedded and
server. :(


> I was under the impression that the assembler made no instruction decisions
> based on CPU.  So your only hint would be that '0b' prefix.
> Does AS even see that?

GAS definitely makes decisions based on CPU (ie, -m<cpu> option).  Below is
the GAS code used in recognizing the dcbtst instruction.  This shows that
the "server" operand ordering is enabled for POWER4 and later cpus while
the "embedded" operand ordering is enabled for pre POWER4 cpus (yes, not
exactly a server versus embedded trigger, but that's we agreed on to
mitigate breaking any old asm code out there).

{"dcbtst",	X(31,246),	X_MASK,      POWER4,	PPCNONE,	{RA0, RB, CT}},
{"dcbtst",	X(31,246),	X_MASK,      PPC|PPCVLE, POWER4,	{CT, RA0, RB}},

GAS doesn't look at how the operands are written to try and guess what
operand ordering you are attempting to use.  Rather, it knows what ordering
it expects and the values had better match that ordering.


Peter
