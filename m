Message-ID: <20030502010935.57319.qmail@web40905.mail.yahoo.com>
Date: Thu, 1 May 2003 18:09:35 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: gcc 2.95.3 powerpc bug
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We found an optimizer bug in 2.95.3.  (unreported
until now?)  Posted to gcc-GNATS, but the gcc folks
said they don't plan a fix for such an old compiler.
Does anyone on this list have a patch for this
already?

Basically, the dead-code optimization removes the
wrong code, leaving instructions which should be
optimized out and removing instructions which should
have been left in there.  Happens with -O2 and -Os,
but not -O1.

Example below:  inst at offset 14 should have been
removed, but instead the loop count initialization has
been incorrectly removed (r31 is not initialized
before offset 24).

Regards,
Brian

#include <stdio.h>
static void func(int a, int b)
{
   0:   94 21 ff f0     stwu    r1,-16(r1)
   4:   7c 08 02 a6     mflr    r0
   8:   93 c1 00 08     stw     r30,8(r1)
   c:   93 e1 00 0c     stw     r31,12(r1)
  10:   90 01 00 14     stw     r0,20(r1)
    int err;
    unsigned int port;

    switch (b) {
  14:   28 04 00 04     cmplwi  r4,4
        case 0:
        case 1:
                err = 1;
                break;
        case 2:
        case 3:
                err = 2;
                break;
        case 4:
        default:
                err = 3;
    }

    for (port = 0; port < 5; port++)
        printf("port: %d\n", port);
  18:   7f e4 fb 78     mr      r4,r31
  1c:   38 7e 00 00     addi    r3,r30,0
  20:   48 00 00 01     bl      20 <func+0x20>
  24:   3b ff 00 01     addi    r31,r31,1
  28:   28 1f 00 04     cmplwi  r31,4
  2c:   40 81 ff ec     ble     18 <func+0x18>
}
  30:   80 01 00 14     lwz     r0,20(r1)
  34:   7c 08 03 a6     mtlr    r0
  38:   83 c1 00 08     lwz     r30,8(r1)
  3c:   83 e1 00 0c     lwz     r31,12(r1)
  40:   38 21 00 10     addi    r1,r1,16
  44:   4e 80 00 20     blr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
