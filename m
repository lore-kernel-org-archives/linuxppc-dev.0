Date: Mon, 9 Aug 1999 10:19:30 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: readl() and friends and eieio on PPC
In-Reply-To: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.990809101224.18667D-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Aug 1999, Geert Uytterhoeven wrote:

> Jes Sørensen pointed out to me that readl() and friends should not use
> eieio on PPC. On other architectures (e.g. AXP) this isn't done neither. 
> 
> Currently we have[*]:
> 
> #define readl(addr) in_le32((volatile unsigned *)(addr))
> #define inl(port)               in_le32((unsigned *)((port)+_IO_BASE))
> #define inl_p(port)             in_le32((unsigned *)((port)+_IO_BASE))
> 
> extern inline unsigned in_le32(volatile unsigned *addr){
>         unsigned ret;
> 
>         __asm__ __volatile__("lwbrx %0,0,%1; eieio" : "=r" (ret) :
>                              "r" (addr), "m" (*addr));
>         return ret;
> }
> 
> [*] Except on APUS, where readl() uses native endianness.
> 
> Hence both inl() and readl() protect against reordering. This is not necessary
> for readl(). Drivers that need to protect against reordering should use
> wmb()/rmb()/mb() theirselves.

Further, eieio should never be used by itself as an assembly instruction
like this -- not in _any_ macro.  If you ever hope to support all of the
x100 PowerMacs, you'll have to have a macro just for eieio, as several
instructions are required before and after eieio, sync, and isync (or at
least two of them, and I forget which) to avoid hardware buglet on certain
machines.


Later,
David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
