Date: Thu, 6 Sep 2001 12:30:22 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs vs gcc-2.95.x
Message-ID: <20010906123022.D5873@ftsoj.fsmlabs.com>
References: <20010906112613.M21172@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010906112613.M21172@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Sep 06, 2001 at 11:26:13AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is this a comment by me?  If so, that was a problem with
__builtin_return_address() not working in leaf functions which still exists
today, I believe.  The "fix" there is a hack to leave those outline in lieu
of the inline versions so that several functions were made non-leaf.

In some other projects I've used changed those around so that
__builtin_return_address() is redefined to call another stub function so
that it's always called in a non-leaf function.  It's cleaner and more
reliable, but not any prettier.

} Hello all.  I happened to be skimming asm/byteorder.h for some reason, and
} noticed that we have ___arch__swab16/___arch__swab32 written, but #if 0'ed
} because of an egcs bug.  A bit of grep'ing showed that set_bit (asm/bitops.h)
} used to be #if 0'ed because of another egcs bug but isn't now.  So the
} question is, is anyone still using egcs to compile a kernel?  If, so
} what version (1.0.x or 1.1.x) and does anyone remember what version of
} egcs produced the bug?
}
} If nothing else, perhaps in 2.5 this should go away..
}
} --
} Tom Rini (TR1265)
} http://gate.crashing.org/~trini/
}
} _______________________________________________
} linuxppc-commit mailing list
} linuxppc-commit@source.mvista.com
} http://source.mvista.com/cgi-bin/mailman/listinfo/linuxppc-commit

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
