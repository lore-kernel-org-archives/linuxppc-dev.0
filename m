Date: Fri, 3 Oct 2003 22:42:01 -0400 (EDT)
From: "Shih-Ying S. Chou" <sschou@mtu.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Question about IBM 405GP PCI mapping on EP405 board
Message-ID: <Pine.GSO.4.53.0310032240420.17354@tesla2.ee.mtu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
     As I am reading the IBM 405GP user manual, and check the PCI memory
mapping in the ep405.c in the kernel source.  I run in a question about
there is a difference between the manual and the code's comment.  Can
anyone explain to me if it is normal or it is an typo in the code.
     In the user manual, the range of PLB to PCI I/O mapping is

PLB address range    Description                      PCI address range
0xE8000000 -         PCI I/O                          0x00000000 -
0xE800FFFF           Accesses to this range are       0x0000FFFF
                     translated to an I/O access
                     on PCI in the range 0 to 64KB-1.

But in the ep405.c in the kernel source

 /*
  * Expected PCI mapping:
  *
  *  PLB addr                    PCI memory addr
  *  ---------------------       ---------------------
  *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
  *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
  *
  *  PLB addr                    PCI io addr
  *  ---------------------       ---------------------
  *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
  */
                                     ^
                                     |
                                     |
				isn't here should
                                be same as PCI I/O address
                                range??


Thank you

Shih-Ying Chou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
