Message-ID: <20000825025003.23151.qmail@web512.mail.yahoo.com>
Date: Thu, 24 Aug 2000 19:50:03 -0700 (PDT)
From: Dan Winkler <dantwinkler@yahoo.com>
Subject: RPX Lite programming
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Newbie alert!!!  I've just started developing on the
RPX lite board from embedded-planet.  I am currently
trying to write some i2c code that just reads the
temperature registers from the temperature sensor and
thermal monitor (TCN75).  I was wondering where
someone like myself could find some example code to
get me started.  I found the i2c driver from the
Motorola site and tried to modify it to acommidate my
needs but the first register I try to access it core
dumps.  Here is the only part of the code that get's
executed and the line on which it core dumps.  Looking
at the immr in memory, everything seems fine.  Any
suggestions?  Or better yet does anyone have any code
(very basic) that can get me past this first hurdle.
Thanks...

Dan Winkler

unsigned long GetIMMR(void)
{
    return 0xFA200000;
}

...init function
  /* MPC8xx internal register map */
  EPPC *immr = ( EPPC * )( GetIMMR() & 0xffff0000 );

  /* Get pointer to BD area on DPRAM */
  RTXBD *rtx = ( RTXBD * ) immr->udata.bd_ucode2;

  /*
   * Configure Port Pins
   */

  /*
   * PB27: I2CSDA -- I2C Serial Data In/Out
   * PB26: I2CSCL -- I2C Serial
   */

  immr->pb.pbpar |= (0x30);
  immr->pb.pbdir |= (0x30);
  immr->pb.pbodr |= (0x30);

=====


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
