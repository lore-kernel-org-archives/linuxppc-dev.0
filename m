Date: Fri, 11 Feb 2000 14:17:32 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-bk@fsmlabs.com
Subject: Re: Latest OpenPic changes
Message-ID: <20000211141732.F15548@hq.fsmlabs.com>
References: <Pine.LNX.4.05.10002111816100.356-100000@callisto.of.borg> <Pine.HPX.4.10.10002111826230.1866-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10002111826230.1866-100000@gra-ux1.iram.es>; from Gabriel Paubert on Fri, Feb 11, 2000 at 06:30:06PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} Note that there are still problems, some functions use check_arg_irq(irq)
} and then use irq while othre use irq-open_pic_irq_offset after the same
} check. I'm still trying to understand how it should work since I suspect
} something is wrong given the behaviour of my nfsroot machines :-(
}
} Oh and BTW there is a typo in the kernel.org sources:
}
} 		if ( !(_machine && (_MACH_gemini|_MACH_Pmac)) )
}
} 				^^
} should be & otherwise the cascade interrupt will never be requested.

I think we should drop the check_irq_arg() calls everywhere.  They will
always fail for IPI's and since we remap the irqs anyway it doesn't matter.

I'll fix the typo... Thanks :)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
