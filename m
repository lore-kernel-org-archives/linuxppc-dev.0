From: clark@esteem.com
Message-Id: <1.5.4.32.20000819004501.006984e4@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 18 Aug 2000 17:45:01 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPCBoot memory mapping problems
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


        Okay here is the situation,

        I have hacked & slashed the PPCBoot code to work with our custom
board (all except the flash portion). I have mapped the memory as show below.

  address       size            name            BR#/OR#         buswidth
0x00000000      8meg            Bank0           1               32
0x00800000      8meg            Bank1           2               32
0x40000000      2meg            Flash0          0               16
0x60000000*     2meg            Flash1          3               16
0xFFF00000      whatever        IMMR            N/A             N/A

(* Note will be remapped to the end of flash0 to form contigious flash block
when I get around to hacking the flash code)

        I have taken the "include/asm/mbx.h" and replaced its boardinfo
structure with the one I used in the PPCBoot code and then compiled the
kernel. Following the instructions in the readme file, I grabbed
arch/ppc/coffboot/vmlinux.gz and converted as shown. It is given a load
address of 0x00000000 and an entry point 0x0000000C. I put the converted
image into flash using our ICE at address 0x40020000.

        Our board boots up checks the kernels CRC then uncompresses it. It
then jumps to 0x0000000C. A little bit later it then jumps to some address
0xC000???? and faults.

        Is this what it is supposed to do? Am I supossed to have the RAM
mapped at 0xC0000000? If it loads at address 0 how do I remap it to
0xC0000000 once the kernel starts? Is there any way to force the kernel to
run in lower memory?


        Thanks in advance for any help.

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
