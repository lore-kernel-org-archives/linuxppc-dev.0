Date: Wed, 31 Jan 2001 17:08:52 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Ron Bianco <ronb@junction.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux 2.4.x, PPC and  openPIC interrupt priorities
Message-ID: <20010131170852.D19501@hq.fsmlabs.com>
References: <000501c08b3f$3d4645f0$4d012ac7@warp-speed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000501c08b3f$3d4645f0$4d012ac7@warp-speed>; from Ron Bianco on Tue, Jan 30, 2001 at 08:35:29PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} Can anyone please tell me what, if any, distribution of 2.4.x linux is 'best' as a
} starting point for porting to our custom 8240 board?  I realize 2.4.x, especially for
} PPC, is being updated daily.   Any advice will be greatly appreciated.
} I'm also somewhat aware of RTlinux and others, but don't have time to search, read
} and compare the plethora of tech doc on kernel versions, changes, and PPC gotchas
} right now.

I don't have any info no which distrubtion would be best (from which
vendor, that is) but any should do.  I'd suggest starting with the 2.4.X
sources from www.fsmlabs.com/linuxppcbk.html for any work you do.  You may
also want to subscribe to the mailing list there.

} The 8240 is basically an enhanced 603 with an open PIC compatible EPIC and PCI etc.
} on chip.

Should be easy with 2.4.X.

} Can anyone also tell me if the 2.4.x-testx kernel now, indirectly at least, handles
} 'external' interrupt priorities according to the way the open pic registers are
} programmed.
} i.e. it allows a lower priority interrupt handler to be interrupted by a higher
} priority int?

We don't explicitly program them and rely on all-enabled or all-disabled
with the MSR.  Dealing with priorities is a mess for us since we support
over a dozen interrupt controllers, all of which have different methods of
assigning priorities.

} Instead of the old 2.2.x and 2.3.x way of disabling external ints via the MSR  EE bit
} until ANY int handler returns.
}
} The EPIC will only assert the int signal to the CPU if a higher priority int comes
} along, so the linux interrupt
} dispatching code should, ideally, NOT globally disable ints via MSR[EE] when calling
} a handler, for PPC anyway.
}
} We are currently testing with HHL 2.3.16-sandpoint8240 and are finding too much
} interrupt 'jitter' to be able to service our special PCI device properly while SCSI
} disk accesses using the sym53c8xx driver, are going on.
}
} Max.  latency has been found to be >300usec, which is too long for our special device
} which interrupts every 167usec.

You'll never get that with normal linux.  We've found 810ms (that is not a
mistype - 810 _ms_) delays with certain operations.

However, with the 82xx chips you can get sub 10 us (even better with some
configurations) worst-case interrupt latency with RTLinux.  For periodic
tasks we see about 10us worst-case jitter for those chips.  A standard G4
pmac will push the worst case latency/jitter to 16us/20us because of the
IDE controller being slow.

Take a look at www.rtlinux.org and download it from
www.rtlinux.com/pub/rtlinux/v3/  That's the "open" version of RTLinux
which is GPL.  Your application code does not invoke the GPL so it can be
closed or open but if you modify the RTLinux code itself you need to talk
to us.  The details of the license are there.

} We have only 3 external ( PCI ) interrupts on our board.
}
} Ethernet - i82559 lowest priority
} SCSI     - 52c895 next
} special  - highest priority
}
} As far as I can tell so far, neither the eepro100 and sym53c8xx drivers disable ints
} themselves.

Send me details on your needs and I can give you some recommendations.
RTLinux will give you much better than the 167us worst-case latency you need.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
