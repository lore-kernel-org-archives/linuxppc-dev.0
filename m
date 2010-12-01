Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 2CF3BB6F11
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2010 02:11:09 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 17590-08 for <linuxppc-dev@ozlabs.org>;
	Wed,  1 Dec 2010 15:11:04 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [MPC52xx]Latency issue with DMA on FEC
Date: Wed, 1 Dec 2010 15:09:54 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
In-Reply-To: <1291215130.4881.55.camel@gandalf.stny.rr.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Steven Rostedt" <rostedt@goodmis.org>,
	"Jean-Michel Hautbois" <jhautbois@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-rt-users@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> A mb() is usually used if you do a write to device and read from it.
> With out it, the CPU could perform the read before the write, which
> would give you an incorrect result. There's no other way around that.

Possibly the synchronisation functions are doing significantly
more work than is required.

I was looking at the in_le32() and out_le32() functions for the
ppc e300 (and maybe others).

The out_le32() contains a 'sync' instruction - this may only
be needed after a series of writes (eg just before a command).

The iosync() function just adds a 'sync' and can be used as needed.

The in_le32() not only contains the unwanted 'sync', but also
a 'twi' (trap immediate - NFI exactly what this does) and 'isync'.
The 'isync' is particularly horrid and unnecessary (aborts
the instruction queue and refeches the opcode bytes).

The very slow in_le32() might be there to give semi-synchronous
traps on address fault - but unless the hardware is being probed
that really isn't necessary.

I did find st_le32() and ld_le32() in arch/powerpc/include/asm/swab.h
but had difficulty #including that version of swab.h!
    #include <../arch/powerpc/include/asm/swab.h>
worked - but isn't that nice.

	David
