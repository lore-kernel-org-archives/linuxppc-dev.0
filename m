Subject: very minor 405GP and 405GPr PCI difference
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com>
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Fri, 27 Sep 2002 08:27:35 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yesterday I discovered a minor 405GP vs 405GPr PCI difference.
IN the 405GP the ptm1ms bit 31, the enable bit for the region is set to 1
by the hardware and cannot be written.
On the 405GPr the bit is writable and this makes necessitates  a change in
walnut.c

In walnut.c there is the line

out_le32((void *) &(pcip->ptm1ms), 0x00000000);

On the walnut, this would work fine because bit 31 cannot be written to a
0,
On the GPr, this disables the regions and PCI no longer functions.
The line should be changed to

out_le32((void*)&(pcip->ptm1ms),0x000000001);

This will fix the 405GPr and make no difference to the 405GP since the bit
is permanently to 1.

Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
