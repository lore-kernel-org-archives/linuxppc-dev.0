Date: Mon, 7 May 2001 16:35:46 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: "'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
Message-ID: <20010507163546.B680@ftsoj.fsmlabs.com>
References: <B25E2E5A003CD311B61E00902778AF2A0204463A@SERVER1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A0204463A@SERVER1>; from brian.kuschak@skystream.com on Mon, May 07, 2001 at 03:19:51PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can I get a tar file of your kernel tree that exhibits this problem?

} Just to be clear, we do have several active subscriptions with MontaVista,
} and have contacted them numerous times in the past month about this issue.
} Unfortunately they were unable to provide a solution.  This kernel was the
} latest that MontaVista had for the 4xx as of 3/7/2001.  This was the 2.4.2
} kernel.  I applied the 2.4.3 patch to bring it up to date with the latest
} bugfixes.  The version as report in /proc/version:  Linux version
} 2.4.3-mvista_010303.
}
} I looked at the atomic.h code and think I found one bug, however it doesn't
} solve my problem.  See if this patch makes sense to you.  Looks like a typo
} when the atomic_* functions were converted from assembler to inline.  The
} bne should be 'bne-' for the atomic decrement operation.
}
} Regards,
} Brian
}
} *** atomic.h    2001/02/26 19:07:19     1.1.1.2
} --- atomic.h    2001/05/07 21:13:54
} ***************
} *** 86,94 ****
}
}         __asm__ __volatile__("\n\
}   1:    lwarx   %0,0,%2\n\
}         addic   %0,%0,-1\n\
}         stwcx.  %0,0,%2\n\
} !       bne     1b"
}         : "=&r" (t), "=m" (v->counter)
}         : "r" (v), "m" (v->counter)
}         : "cc");
} --- 88,96 ----
}
}         __asm__ __volatile__("\n\
}   1:    lwarx   %0,0,%2\n\
}         addic   %0,%0,-1\n\
}         stwcx.  %0,0,%2\n\
} !       bne-    1b"
}         : "=&r" (t), "=m" (v->counter)
}         : "r" (v), "m" (v->counter)
}         : "cc");
}
}
}
} -----Original Message-----
} From: Dan Malek [mailto:dan@mvista.com]
} Sent: Monday, May 07, 2001 2:05 PM
} To: Eli Chen
} Cc: Brian Kuschak; linuxppc-embedded@lists.linuxppc.org
} Subject: Re: dcache BUG()
}
}
} Eli Chen wrote:
}
} > I have also seen the dcache BUG, as well as bugs and warnings from other
} > parts of the kernel in the MontaVista 2.4.0 kernel.
}
} Again, I don't know what a "MontaVista 2.4.0" kernel would be.
} MontaVista clearly names our software distributions and releases
} them on a CD after a QA process.  If you can duplicate this
} problem with the software that is on the CD, and then use the
} proper reference name, we could all use the same baseline.  Of
} course, it would be nicer if you would have purchased the subscription
} with the CD and called your dedicated technical representative,
} but we'll provide the best free help available now :-).
}
}
}
} 	-- Dan
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
