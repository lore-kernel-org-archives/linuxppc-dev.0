Date: Sat, 14 Aug 1999 20:34:10 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: "David A. Gatwood" <dgatwood@mvista.com>, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <d3so5mdyta.fsf@lxp03.cern.ch>
Message-ID: <Pine.LNX.4.10.9908142012050.1163-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 14 Aug 1999, Jes Sorensen wrote:
> >>>>> "David" == David A Gatwood <dgatwood@mvista.com> writes:
> David> On Fri, 13 Aug 1999, Paul Mackerras wrote:
> >> Surely it should only take a couple of cycles to move a register to
> >> another and clear it?  I agree it's a pain though.  Actually, with
> >> gcc the asm statement that uses the eieio could just specify the
> >> register (which one is it?) as an input and give it the value 0.
> 
> David> For some reason, just loading the value isn't enough.  The code
> David> that Gilbert put in as a workaround shortly before DR3 looks
> David> like this:
> 
> David> #define eieio() __asm__ volatile("li 0,0: cmpwi 0,0; bne+ 0f;
> David> eieio; 0:" : : : "0")
> 
> Defininf a C function with the name of a PPC specific assembler
> function is pretty stupid. To the best of my knowledge wmb() is the

Well, David was talking about replacing the eieio() macro (which Linux/PPC had
since ages) by something that works around bugs in the hardware.

> generic name for the thing you are looking for.

Time to start grepping in include/asm-alpha/system.h. Huh, Alpha AXP has no
`rmb' mnemonic ;-)

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
