To: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm inline
References: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
	<20021129160826.GA27950@ibrium.se>
	<Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
	<5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com>
	<20021202131158.GA2427@ibrium.se>
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 02 Dec 2002 14:35:17 +0100
In-Reply-To: <20021202131158.GA2427@ibrium.se> (Samuel Rydh's message of
 "Mon, 2 Dec 2002 14:11:58 +0100")
Message-ID: <jevg2cee7e.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Samuel Rydh <samuel@ibrium.se> writes:

|> Sure, here is a stand alone program that triggers the problem:
|>
|> ----------------------------------------------------------------
|>
|> #include <stdio.h>
|> typedef unsigned long ulong;
|>
|> static __inline__ void st_le32( ulong volatile *addr, ulong val )
|> {
|>         __asm__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr)  );
|> }
|>
|> int
|> main( int argc, char **argv )
|> {
|>         int b;
|>         st_le32( (ulong*)&b, 0 );
|>         testing( b );

This violates the aliasing rules.  The compiler is free to assume that
st_le32 does not modify b, because you are invoking undefined behaviour.

Andreas.

--
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
