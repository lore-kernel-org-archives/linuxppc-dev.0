Message-ID: <40239C69.5040803@siemens.com>
Date: Fri, 06 Feb 2004 14:53:45 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: BUG in mtd/chips/cfi_cmdset_0002.c for 64bit width flashes (linuxppc_2_4_devel)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We have found the following bug in mtd/chips/cfi_cmdset_0002.c
for 64bit bus width.

The routine do_write_oneword() uses the DQ6 algorithm in order
to detect the end of programming phase (see bitkeeper: linuxppc_2_4_devel)


oldstatus = cfi_read(map, adr);
status = cfi_read(map, adr);

while( (status & dq6) != (oldstatus & dq6) &&
         (status & dq5) != dq5 &&
         !time_after(jiffies, timeo) ) {

     if (need_resched()) {
         cfi_spin_unlock(chip->mutex);
         yield();
         cfi_spin_lock(chip->mutex);
     } else
         udelay(1);

     oldstatus = cfi_read( map, adr );
     status = cfi_read( map, adr );
}

There are two contiguous calls of cfi_read() to check for the DQ6 toggling.

But for 64bit one cfi_read() results in two flash accesses, one for
the upper 32bit and the other for lower 32bit. In this way the DQ6 bits toggle
for the two accesses related to one cfi_read(). The first access will be
compared with the third and the second with the fourth.
The end detection is broken, the body of the while loop will never be executed.

I suggest to switch to the alternative DQ7 algorithm.


Steffen

--


--------------------------------------------------------------

Steffen Rumler
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
