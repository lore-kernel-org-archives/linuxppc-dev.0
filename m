Message-ID: <3F0B7B28.7040902@earthlink.net>
Date: Tue, 08 Jul 2003 19:17:12 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Ethernet PHY chip discovery not working on 855T with 971/972 chips
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To whomever maintains the file arch/ppc/8xx_io/fec.c:

I note the following code in mii_discover_phy() :

     fep = dev->priv;

     if ((phytype = (mii_reg & 0xffff)) != 0xffff) {

         /* Got first part of ID, now get remainder.
         */

In our devices, reading the first word with the wrong address yields the
value 0, not 0xFFFF.  This happens even if we play with it by hand.  The
search goes through address 0, 1, 2, .., and our chip is hard-coded at
address 1.  What happens is the kernel panics with something like
"Don't know what chip ID 0000FFFF is".  Anyway, I changed it to the
following, and it finds our PHY correctly now.

     fep = dev->priv;

     phytype = (mii_reg & 0xffff);
     if (phytype != 0xffff && phytype != 0x0000) {

         /* Got first part of ID, now get remainder.
         */

I am guessing that probably most devices have the PHY chip at address
zero, so nobody else has run into this problem because it finds their
chip in the first iteration.

You may also want to note in the file that it supports 972 chips (which
apparently look like 971 chips from the inside, 'cuz that's what the
kernel says it is).  Perhaps the printk() should be updated to say
"971/972" instead of just "971"?


Thanks
Dean Matsen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
