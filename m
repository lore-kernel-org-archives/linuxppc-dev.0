Date: Tue, 13 Jul 2004 14:22:03 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: apparent config error, SMC1/SCC3 conflict in uart.c
Message-ID: <Pine.LNX.4.60.0407131411560.9692@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   following up on my earlier posts regarding trying to simultaneously
use SMC1 as console and SCC3 as ethernet, it appears that the source
file arch/ppc/8xx_io/uart.c has a condition error.

   similar to a check that was used in the 2.4 kernel, we have:
=========================================================
...
# ifndef CONFIG_SERIAL_CONSOLE_PORT
#  ifdef CONFIG_SCC3_ENET
#   ifdef CONFIG_CONS_SMC2
#    define CONFIG_SERIAL_CONSOLE_PORT  0       /* Console on SMC2 is
1st port */
#   else
#    error "Can't use SMC1 for console with Ethernet on SCC3"
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
...
=========================================================

which would normally prevent both SMC1 and SCC3 being selected
simultaneously (without the necessary patch, that is).

   but based on changes in Kconfig options, it appears that i can
select both of those and not be notified of an error (my system will
just hang at boot time).  some of my config options:


CONFIG_SERIAL_CONSOLE=y
...
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
# CONFIG_SERIAL_CPM_SCC1 is not set
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
CONFIG_SERIAL_CPM_SMC1=y                 <-- pick SMC1
# CONFIG_SERIAL_CPM_SMC2 is not set
...
CONFIG_SCC_ENET=y
# CONFIG_SCC1_ENET is not set
# CONFIG_SCC2_ENET is not set
CONFIG_SCC3_ENET=y                       <-- pick SCC3
# CONFIG_FEC_ENET is not set
# CONFIG_ENET_BIG_BUFFERS is not set
# CONFIG_8xx_UART is not set

   based on the above, it sure *looks* like i'm selecting SMC1 and SCC3
at the same time, and i recall a previous poster suggesting that
CONFIG_8xx_UART is a holdover from 2.4 that will disappear so i left
it unselected.

   with this set of options, the build succeeds, but the system hangs
at boot time.  however, if i select ethernet on SCC2 (it will
obviously not work, then), at least the system boots and i have a
system console.

   thoughts?  i suspect that set of "ifdef"s needs to be updated --
there isn't even a "CONFIG_SERIAL_CONSOLE_PORT" option anymore, among
other things.  or CONFIG_CONS_SMC2.  and probably others.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
