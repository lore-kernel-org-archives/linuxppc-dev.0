Date: Thu, 28 Oct 1999 12:31:02 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
cc: Daniel Nilsson <daniel.n.nilsson@home.se>,
        Adrian Cox <apc@agelectronics.co.uk>, Wolfgang Denk <wd@denx.de>
Subject: Bug Discovered in Binutils/GCC for PPC403
In-Reply-To: <Pine.SGI.4.10.9910281200550.695157-100000@sapphire.lcse.umn.edu>
Message-ID: <Pine.SGI.4.10.9910281224020.695157-100000@sapphire.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For those of you working with the TiVo Linux sources, I discovered bug in
binutils-2.9.1.0.25 and binutils-2.9.5.0.14 that results in the following
sorts of error:

foobar.c: Assembler messages:
foobar.c:7868: Error: junk at end of line: `28'

It appears that the assembler has the incorrect definition for the
'dcread' instruction:

In the file binutils-2.9.5.0.14/opcodes/ppc-opc.c, the definition is as
follows:

{ "dcread",  X(31,486), XRT_MASK,       PPC403,         { RA, RB } },

However, according to the IBM PowerPC 403GCX manual the definition is:

	dcread RT,RA,RB

The patch to fix this is:

{ "dcread",  X(31,486), X_MASK, 	PPC403,         { RT, RA, RB } },

Patch the ppc-opc.c file and rebuild binutils and you're back on your way.
Otherwise, just comment out the offending line of code, such as:

	asm("dcread %0,0,%1" : "=r" (tag) : "r" (p));


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
