Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id A3984B70BF
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 19:29:34 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 25838-10 for <linuxppc-dev@ozlabs.org>;
	Thu, 11 Aug 2011 10:29:30 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Optimize __arch_swab32 and __arch_swab16
Date: Thu, 11 Aug 2011 10:29:33 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE28@saturn3.aculab.com>
In-Reply-To: <OF35FB17D7.41EF05A7-ONC12578E9.0032D316-C12578E9.00338C07@transmode.se>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: Andreas Schwab <schwab@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > Which is a problem because the compiler could schedule
> > it be written back to real memory between the instructions.
>=20
> It can? There is no memory here, just registers. Even if it
> is written to memory, how would that affect the register?

Although the function argument is passed in a register, the
compiler could generate a store-load sequence before and
after each __asm__() line.

> Assuming you are right, would rewriting it to
>   __asm__("rlwimi %0,%0,16,0x00ff0000\n\t"
> 	    "rlwinm %0,%0,24,0x0000ffff"
> 	    : "+r"(value));
> help?

Except that now you've stopped the compiler scheduling
another instruction between the two - probably forcing a
execution stall.

	David
