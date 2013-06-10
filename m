Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 2FBC32C0095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 22:48:25 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 24447-07 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Jun 2013 13:48:13 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: PowerPC assembler question
Date: Mon, 10 Jun 2013 13:41:48 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B727F@saturn3.aculab.com>
In-Reply-To: <20130610211439.a69d2b26ee216f34caf473bd@mega-nerd.com>
References: <20130610090135.a002eba2401c06eedfa7b7ec@mega-nerd.com>
 <1370820095.14883.45.camel@pasglop>
 <20130610211439.a69d2b26ee216f34caf473bd@mega-nerd.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Note: It's more readable if you use the register names, ie:
> >
> > 	lwz	%r30, .label - (1b)(%r31)
> >
> > The form of lwz is
> >
> > 	lwz	dest_reg, offset(address_reg)
> >
> > So it will load a 32-bit value from memory at the address contained =
in
> > r31 offset by ".label - 1b" which is itself the difference between
> > two labels, "label", and the first "1:" label before the instruction
...
> Is there something I could replace this above lwz instruction with
> that would work for PIC with offsets greater than +/- 32k?

With a scratch register there are some two instruction sequences.
Reusing the destination register something like:
	addis	%r30,%r31,hi(.label - 1b)
	lwzx	%r30,lo(.label - 1b)(%r30)
(Not sure of the hi()/lo() functions for ppc!)
It is even possible that there are some macros for the
assembler that will do this automatically - %r1 might
even be reserved for the purpose (as it is on MIPS).

	David
