Date: Thu, 8 Jul 2004 20:28:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: SMC1, ethernet on SCC3 and patches to allow this
Message-ID: <Pine.LNX.4.60.0407081923190.2164@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   final issue i have here involving our 850DE board, related to
console on SMC1 co-existing with ethernet on SCC3.

   the default parameter RAM layout for this processor is, according to
the user's manual:

 	...
 	0x1e00-0x1e7f	SCC3
 	0x1e80-0x1ebf	SMC1

no problem, unless you want ethernet on SCC3, which won't fit in that
window and runs over into the space for SMC1, clobbering it.  in the
2.4 kernel we have, this is solved by (apparently) relocating SMC1 by
adding a micropatch.c file to the kernel in the directory
arch/ppc/8xx_io/.  the relevant part of the Config.in file in that 2.4
source tree:

if [ "$CONFIG_SCC3_ENET" != "y" -o "$CONFIG_SMCUCODE_PATCH" = "y" ];
then
   bool 'Use SMC1 for UART' CONFIG_8xx_SMC1
fi

in short, you can't use SMC1 for UART unless you *don't* put ethernet
on SCC3, or you've installed the patch to relocate SMC1.  easy enough.
so how is this handled in the 2.6 kernel, which should have the same
problem?

   first, arch/ppc/8xx_io/uart.c clearly recognizes the conflict with
the code:

# ifndef CONFIG_SERIAL_CONSOLE_PORT
#  ifdef CONFIG_SCC3_ENET
#   ifdef CONFIG_CONS_SMC2 #    define CONFIG_SERIAL_CONSOLE_PORT  0
/* Console on SMC2 is 1st port */
#   else
#    error "Can't use SMC1 for console with Ethernet on SCC3" <-- aha!
#   endif
#  else /* ! CONFIG_SCC3_ENET */
#   ifdef CONFIG_CONS_SMC2                      /* Console on SMC2 */
#    define CONFIG_SERIAL_CONSOLE_PORT  1
#   else                                        /* Console on SMC1 */
#    define CONFIG_SERIAL_CONSOLE_PORT  0
#   endif /* CONFIG_CONS_SMC2 */
#  endif  /* CONFIG_SCC3_ENET */
# endif   /* CONFIG_SERIAL_CONSOLE_PORT */
#endif    /* CONFIG_SERIAL_CONSOLE */

but there's no reference to a patch that lets me get away with this.
surely others might want to have console SMC1 and ethernet SCC3.  how
is it done?  (i mean, short of configuring the console on SMC2, which
is not an option here.)

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
