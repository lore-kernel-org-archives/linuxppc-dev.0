Message-ID: <3C99D513.5740FDAF@lvl7.com>
Date: Thu, 21 Mar 2002 07:41:55 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Question regarding the clear_page function
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Morning all!
	I've got a question regarding the clear_page function in
arch/ppc/kernel/misc.S.  We have been seeing a series of intermittent oopses in
which the call stack terminates inside clear_page with a data access exception
(trap 0x300), on the 0x100th iteration of the clear_page loop.  Inspection of
the function reveals that for the 8XX processor (we're using an 860P),
clear_page does 4 32 bit stores to memory and advances a counter in increments
of a cache line size.  However, for a non 8XX processor, the dcbz instruction is
used to clear the cache line.  My question is, why is this not the case for the
8XX series as well?  I've looked through the users guide and the instruction is
present on the 8XX family of processors, and the dcbz instruction behavior seems
appropriate to the referenced function regardless of the state of the cache
(enabled or disabled).  I'm asking because I'm testing a modifed kernel in which
we use the dcbz instruction rather than 4 stores, and we curious as to what
consequences I might expect.  Any thoughts or opinions appreciated.  Thanks a
bunch!
Neil :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
