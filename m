From: Eric.Oosterhof@radisys.com
Subject: I2C module problem on 8260
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OFC97C91CA.1E7BB35E-ON88256B5E.007CD94A@radisys.com>
Date: Tue, 12 Feb 2002 14:49:53 -0800
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a problem with the I2C on a custom 8260 board.  I modified the
8xx device driver (I've seen it called the Dan Malek driver) and am trying
to load it as a module.  I discovered in so doing that the virtual address
space that the module is placed in does not allow the use of __pa to get a
virtual address.  I looked at the 860 driver that we are using on a
different board, and it has the same issue.  But, it is compiled into the
kernel, hence won't have that problem.  My question is two-fold.  First, is
there a smarter version of __pa that understand how to get the physical
address of a construct in a dynamically loaded module?  Second, is this a
bug in the I2C, and I just happened to be using the module form where the
bug shows up?  I have included below the output (snipped) of insmod -m to
show the symbol.  My system has only 64 MB of SDRAM, hence virtual SDRAM
addresses range from 0xc0000000 to 0xc3ffffff.  Thanks!

sh-2.04# insmod -m i2c-algo-8260.o
Sections:       Size      Address   Align
.this           00000060  c5008000  2**2
.text           00000ad8  c5008060  2**2
.rodata         000004bc  c5008b38  2**2
.kstrtab        0000010a  c5008ff4  2**2
__ksymtab       00000038  c5009100  2**2
.data           0000003c  c5009138  2**2
.sdata          00000008  c5009174  2**2
.vtop_fixup     0000001c  c500917c  2**1
.bss            00000010  c5009198  2**2
.sbss           00000004  c50091a8  2**1
.plt            00000080  c50091b0  2**4
.kmodtab        0000000c  c5009230  2**2
__archdata      00000000  c5009240  2**4

Symbols:
00000000 a i2c-algo-8260.c
...
...


Eric.Oosterhof@RadiSys.com    503-615-1283
5445 NE Dawson Creek Drive
Hillsboro, Oregon, 97124
USA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
