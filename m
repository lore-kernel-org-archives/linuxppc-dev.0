Message-ID: <3A1BECC8.DB736163@siemens.at>
Date: Wed, 22 Nov 2000 16:56:56 +0100
From: Rainer Kloud <rainer.kloud@siemens.at>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: loading a elf binary
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a question about loading the init process, because I
can't find the place where the binary is loaded into the RAM.

All what I have seen is, that do_execve calls prepare_binprm
where the linux_binprm structure is loaded with the corresponding
values of the binary. Therefore this function calls do_generic_file_read
(called via kernel_read and nfs_file_read (the binary resides on a nfs
mounted place)). In this function the first page of the binary is loaded
(mapped) correctly into the RAM. But in the further process of loading
the
binary (search_binary_handler and load_elf_binary) I can't find the
place
where the rest of the binary is loaded?!
(the correct loaded part of the executable resides from 0xc0252000 to
0xc0252fff in the kernel and from 0x10000000 to 0x10000fff in user
space)

When then the kernel executes the binary, everything works correct
until the first executed instruction is outside of the first page (4k)
of the executable.
f.e.:

100000c0: 7c 29 0b 78  mr r9,r1
100000c4: 54 21 00 36  rlwinm r1,r1,0,0,27
100000c8: 38 00 00 00  li r0,0
100000cc: 94 21 ff f0  stwu r1,-16(r1)
100000d0: 7c 08 03 a6  mtlr r0
100000d4: 90 01 00 00  stw r0,0(r1)
100000d8: 3d 00 10 06  lis r8,4102
100000dc: 85 a8 92 00  lwzu r13,-28160(r8)
100000e0: 48 00 ed c8  b 1000eea8        ---> branch outside of first 4k
........
1000eea8: 94 21 ff e0  stwu r1,-32(r1)   <--- there are other
instruction at this address
1000eeac: 7c 08 02 a6  mflr r0                in the RAM
1000eeb0: 93 61 00 0c  stw r27,12(r1)

Then the processor will load a wrong instruction which results at the
end in a page fault.

Can anyone explain me whow a binary is normally loaded into the
RAM?
Does anyone have an idea how I can find a solution for my problem?

Thank you in advance!

Best Regards
Rainer

PS:
Board:  Scout Board (705+8260)
Kernel: 2.4.0-test4
gcc:    2.95.2
glibc:  2.1.3 with ctype.patch

--
Rainer Kloud               mailto:rainer.kloud@siemens.at
Siemens AG, PSE ECT OTN 2, Rampengasse 3-5, A-1190 Vienna

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
