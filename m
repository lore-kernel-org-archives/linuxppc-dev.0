Subject: Writing in virtual memory space failed
From: Thomas RIVIERE <thomas.riviere@com2gether.net>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 28 Aug 2003 11:36:29 +0200
Message-Id: <1062063390.17263.1304.camel@pcl1.com2gether-corp.net>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I m trying to boot linux-2.4.21 kernel on a custom board with MPC852T
proc.I use zImage.embedded and it hangs after "Now booting the kernel".

When debugging with gdb/BDI2000 in start_kernel (head_8xx.S) it doesn't
recover from the following instruction :
        stwu    r0,-STACK_FRAME_OVERHEAD(r1)

Inserting another write operation in an unused mapped SDRAM location
(c0700000) confirms that the first write access with MMU enabled always
failed. I also try to store in IMMR space (internal RAM) and I have the
same problem.

BDI>t
    Target state      : debug mode
    Debug entry cause : trace
    Current PC        : 0xc00020fc
BDI>t
    Target state      : running
# Step timeout detected


These write operations fail even without debugging with BDI2000.
Cache inhibition doesn't change anything.
SDRAM already used with MMU and cache by Redboot

Kernel     : linux-2.4.21 from linuxppc_2_4 tree
bootloader : redboot
probe      : ABATRON BDI 2000 firmware 1.12
processor  : MPC852T

Any help will be appreciated.

Thomas Riviere
com2gether


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
