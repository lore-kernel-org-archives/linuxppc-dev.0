Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Subject: Re: [POWERPC 2/9] spufs: always send sigtrap on breakpoint
Date: Tue, 28 Nov 2006 01:29:21 +0100
References: <20061127181851.796747000@arndb.de>
	<20061127182429.882511000@arndb.de>
	<1164672736.3683.10.camel@localhost>
In-Reply-To: <1164672736.3683.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200611280129.22498.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Ulrich Weigand <ulrich.weigand@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 28 November 2006 01:12, Luke Browning wrote:
>=20
> Arnd, could you explain this change a little bit more. =A0Don't you have
> to consider whether the program is setup to receive SIGTRAP. =A0We know it
> is code to handle SIGTRAP if it is ptraced. =A0Or, are you asserting that
> at this point the spu has hit a trap instruction? =A0What does 0x3fff
> mean?

0x3fff is indeed the code returned from the breakpoint instruction,
as specified in the JSRE list of stop-and-signal codes. The behaviour
is consistant with that of a Linux process entering a breakpoint.
This usually only happens while ptracing a task, but there is no
reason to treat a task differently when it's not being traced.

It could even be used as well-defined way for an application to
create a core dump, similar to abort() in posix.

	Arnd <><
