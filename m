Content-Type: text/plain;
  charset="us-ascii"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with 8260ADS and Scout board networking
Date: Wed, 8 May 2002 00:03:41 -0400
MIME-Version: 1.0
Message-Id: <200205080003.41680.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings!

I am attempting to get Linux 2.4.18 and PPCBOOT working on
8260ADS board and the Scout (same as 8260ADS, but with
MPC750) board. There are two problems I am seeing:

1. On both boards: Networking does not seem to work well
   under Linux. For example, if I telnet to the board and then do
   and "ls -l /" or a "ps -ef", most of the times I dont get a
   complete output and the telnet session hangs. I can still
   start other telnet sessions and can find the previous hung
   telnet session is gone.

   A tcpdump trace shows that there is simply no further output
   being passed on from the board to the remote telnet client.


   Also, if I NFS mount a remote directory on the boards, the
   client on the board periodically gives a message about
   not getting response from the NFS server. Interestingly, if
   the NFS server is across a L3 ethernet switch, this NFS
   problem is seen less often.

   In either of the cases, there are no messages shown by
   "dmesg" that might give a clue.

   Each of the boards has 16MB of memory, a ramdisk rootfs
   and about 5MB or so of free memory. There is no application
   or processes besides bare minumum necessary to be able
   to telnet into the baord and execute BusyBox commands.


2. Scout board and PPCBOOT: This works, in that ppcboot
   shows prompt, and reponds to PPCBOOT commands. The
   PPCBUG is in the Flash.

   To boot Linux on the board, I have a TFTP setup, with
   all necessary network parameters setup. If I use VisionPROBE/
   VisionBOOT (JTAG debugger interface from WRS), to boot
   the board, and can TFTP Linux kernel and initrd from a TFTP
   server, uncompress the kernel and initrd and start Linux to
   a login problem and all.

   I must add that the hardware config word is setup for IMMR
   of 0x0000_0000, and the PCBOOT changes the IMMR to
   0xF000_0000. Also, before the control can be given to
   PPCBUG in the flash (0xFFF0_0100), I have to set the
   IMMR to 0x0F00_0000 first (in target and emulator) and then
   to 0xF000_0000 (in emulator only) in VisionPROBE/VisionCLICK.


   If I start the board standalone, PPCBOOT starts ok and can
   respond to commands, however, TFTP will not get the
   files from remote host. A tcpdump on remote host shows that
   an ARP packet is sent by the board, but the it is corrupted.
   The destination address (broadcast) is ok, but the source
   ethernet address has first two octets ok but remaining are
   'FF"s; also the rest of the frame including the type-length
   are a repeat of the source and destination ethernet addresses
   and some parts of the actual ARP frame payload.


I apologize for the double problem and the lengthy post. Some
how I think, there is a possibility that the two may be related
and hence the combo.

Any pointers to a solution, or clues to debug this problem would
be very helpful!

Thanks in advance.
-Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
