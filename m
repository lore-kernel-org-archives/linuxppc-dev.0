Date: Tue, 8 Jun 1999 20:28:48 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: ioremap() on ISA memory space
Message-ID: <Pine.LNX.4.10.9906082022070.25878-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I found one reason why current kernels don't work on my LongTrail: my NVRAM is
in ISA memory space. When the kernel tries to ioremap() it in
pmac_nvram_init(), I get

    __ioremap(): phys addr e0000 is RAM lr c000e43c

and ioremap() returns NULL, causing all later accesses to NVRAM (e.g. in atyfb)
to fail due to NULL pointer dereferences.

Do all CHRP boxes have NVRAM in ISA memory space? The comment (by Corey) near
the call to pmac_nvram_init() in chrp_init2() already wonders whether
pmac_nvram_init() should be called or not.

Besides, I'd say one must call ioremap() to access ISA memory space anyway, so
it sounds like a bug in the memory management subsystem to me.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
