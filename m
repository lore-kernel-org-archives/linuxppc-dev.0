Message-ID: <39D9E451.9A4E20D4@siemens.at>
Date: Tue, 03 Oct 2000 15:51:13 +0200
From: Rainer Kloud <rainer.kloud@siemens.at>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: different memory map
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear All,

for porting the 2.4.0-test4 kernel to my Scout Board I
used as base the EST8260 configuration.
This two boards are very similar, but they have a different
Memory Map.
The EST board has the IMMR Registers at 0xf0000000, my
Board has them at 0x10700000.

Therefore I'd like to know which changes are necessary to
get the Board running.
All what I have done up to now is that I have changed the
define for IMAP_ADDR and in MMU_init I setup the bat with
index 0 from 0x10000000 (instead of 0xf0000000).

With this two changes the kernel can boot correctly
until it tries to execute the init process.
When loading the init process via load_elf_binary
the kernel gets a machine check execption in function
clear_user (beqlr) which was called from padzero (first time
that we are in user space?).
The parameters for the function are: address: 0x10010528
len: 0xad8
This address resides in the BAT which I have used for my
IMMR registers.

Is there any coherence between the machine check exceptions
and my changes for the different memory map?

Any suggestions to fix my problem?

Thank you in advance!

Bye
Rainer


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
