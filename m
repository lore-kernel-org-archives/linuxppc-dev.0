Date: Fri, 7 Apr 2000 00:54:59 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Pavel Roskin <pavel_roskin@geocities.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Minor makefile fixes
Message-ID: <20000407005459.I11686@medea.fsmlabs.com>
References: <Pine.LNX.4.21.0004061428150.9152-100000@sunapee.transcept.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0004061428150.9152-100000@sunapee.transcept.com>; from Pavel Roskin on Thu, Apr 06, 2000 at 03:12:53PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I already ran into the problem of assuming they were writable :)  I had to
fix that for 2.3 since with bitkeeper we don't always have writable files.

Using 'cat' also assumes that the umask allows writable files so what I did
in 2.3 is just do an explicit chmod to the file after copying it.

} I'm going to post some trivial differences between the kernel sources used
} in Transcept, Inc. and the kernel used in MontaVista's Hard Hat linux.
}
} I hope that somebody will take care of them.
}
} The patch for arch/ppc/kernel/Makefile is necessary because we are using a
} version control system that makes files read-only.
} If ppc_defs.head is read-only, then ppc_defs.h is read-only too, and the
} subsequent grep fails.
}
} I believe that the build system should not assume source files being
} writeable.
}
} The patch to drivers/macintosh/Makefile reduces the number of bloat that
} goes into the kernel e.g. for RPX/Lite. No embedded boards should ever
} need the ADB stuff. This is for PMAC and CHRP only.
}
} Regards,
} Pavel Roskin
}
} === cut here ===
} diff --exclude-from=reviewed -urN linux/arch/ppc/kernel/Makefile out/arch/ppc/kernel/Makefile
} --- linux/arch/ppc/kernel/Makefile	Tue Apr  4 12:36:23 2000
} +++ out/arch/ppc/kernel/Makefile	Thu Mar  2 11:35:59 2000
} @@ -68,7 +68,7 @@
}  		$(TOPDIR)/include/asm/pgtable.h \
}  		$(TOPDIR)/include/asm/ptrace.h
}  	$(CC) ${CFLAGS} -S mk_defs.c
} -	cp ppc_defs.head ppc_defs.h
} +	cat ppc_defs.head >ppc_defs.h
}  	grep '^#define' mk_defs.s >>ppc_defs.h
}  	rm mk_defs.s
}
} diff --exclude-from=reviewed -urN linux/drivers/macintosh/Makefile out/drivers/macintosh/Makefile
} --- linux/drivers/macintosh/Makefile	Thu Apr 29 15:53:48 1999
} +++ out/drivers/macintosh/Makefile	Tue Jan 18 16:08:52 2000
} @@ -15,7 +15,7 @@
}  L_TARGET := macintosh.a
}  M_OBJS   :=
}
} -ifndef CONFIG_MBX
} +ifndef CONFIG_8xx
}  L_OBJS   := via-cuda.o macio-adb.o via-pmu.o mediabay.o
}  LX_OBJS  := adb.o
}  endif
} === cut here ===

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
