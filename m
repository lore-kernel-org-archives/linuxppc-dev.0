Date: Fri, 12 May 2000 16:57:39 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: "Dan A. Dickey" <ddickey@charter.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: NO_RELOAD_HTAB
Message-ID: <20000512165739.P1149@medea.fsmlabs.com>
References: <391A15CE.41488C9D@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <391A15CE.41488C9D@charter.net>; from Dan A. Dickey on Wed, May 10, 2000 at 09:07:10PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We covered a little in the paper "Optimizing the Idle Task and Other MMU
Tricks".  It's currently the only supported behavior on the 603 and in 2.3
has completely disappeared as an option (it's always used).

On the 603 we had to manage the hash table in software and load TLB entries
ourselves.  On the other (and incorrectly designed architectures, in my
opinion) PPC's the hardware loads PTE's from the hash table in hardware.
Since we have to maintain the x86-centric page table for Linux anyway, we
just avoid the hash table on the 603 and load directly into the TLB from
the page table.  We saw a lot of speedup from that.  We also saw
indications that the hardware managed tables of the other PPC's aren't as
efficient as they could be.

} Cort (or anyone else),
} can you tell me what NO_RELOAD_HTAB does in more detail?
} I see it says its an optimization for the 603.  Currently
} in the source that I'm using, its set to 1 (so it *is* defined).
}
} Some of the mmu code changes depending on whether it is
} defined or not, and I'm having problems with the the first
} InstructionTLBMiss.  I have an MPC850SAR on a FADS board.
} (Yes, I've heard all about the lowly fads...)
}
} So, I was wondering what NO_RELOAD_HTAB is for before I go
} delving into 860 & 850 mmu differences and the linux code
} for them.

As Dan said, they sure do.  The NO_RELOAD_HTAB has no effect on the 8xx
MMU, though.  The only chip is affects is the 603 and it's variants
603{e,ev}...

} If anyone else is reading this, can you verify that your
} linux code runs on both an 860 and 850 with no changes?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
