Date: Mon, 9 Aug 1999 10:17:17 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: readl() and friends and eieio on PPC
Message-ID: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Jes Sørensen pointed out to me that readl() and friends should not use eieio on
PPC. On other architectures (e.g. AXP) this isn't done neither.

Currently we have[*]:

#define readl(addr) in_le32((volatile unsigned *)(addr))
#define inl(port)               in_le32((unsigned *)((port)+_IO_BASE))
#define inl_p(port)             in_le32((unsigned *)((port)+_IO_BASE))

extern inline unsigned in_le32(volatile unsigned *addr){
        unsigned ret;

        __asm__ __volatile__("lwbrx %0,0,%1; eieio" : "=r" (ret) :
                             "r" (addr), "m" (*addr));
        return ret;
}

[*] Except on APUS, where readl() uses native endianness.

Hence both inl() and readl() protect against reordering. This is not necessary
for readl(). Drivers that need to protect against reordering should use
wmb()/rmb()/mb() theirselves.

If readl() and friends don't do eieio, the fbcon-* routines won't be slowed
down by using readl() and friends (but we're still having the byte swapping
then).

And atyfb should use readl()/writel() instead of aty_{ld,st}_le32(), so we can
get rid of the inline assembler. Note that this will probably break on Atari,
since on m68k readl() doesn't do byte swapping. But that can be circumvented
with one #ifdef.

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
