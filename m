Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id CDE0E2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 01:27:20 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27646-04 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 18 Dec 2012 14:27:14 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] powerpc: POWER7 optimised memcpy using VMX and enhanced
 prefetch
Date: Tue, 18 Dec 2012 14:14:40 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B70F3@saturn3.aculab.com>
In-Reply-To: <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten> <1355790373.5180.26.camel@otta>
 <16080DCD-0E42-43E9-93E3-D3076637DCB1@pobox.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jimi Xenidis" <jimix@pobox.com>,
	"Peter Bergner" <bergner@vnet.ibm.com>
Cc: Kumar Gala <kumar.gala@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >>        dcbt    r0,r8,0b01010   /* GO */
> >> .machine pop
> >
> > Jimi, are you using an "old" binutils from before my patch that
> > changed the operand order for these types of instructions?
> >
> >    http://sourceware.org/ml/binutils/2009-02/msg00044.html
>=20
> Actually, this confused me as well, that embedded has the same
> instruction encoding but different mnemonic.

That it utterly horrid!

> I was under the impression that the assembler made no instruction =
decisions based on CPU.
> So your only hint would be that '0b' prefix.
> Does AS even see that?

Or maybe see the 'r' prefix.
I know they tend to be absent making ppc asm even more unreadable.
It isn't as though the mnemonics were designed at a time when
the source file size or difference in decode time (or code space)
would be significant.

Otherwise it is a complete recipe for disaster.

	David
