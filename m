From: gopi@india.tejasnetworks.com
Date: Thu, 21 Feb 2002 00:53:01 +0000 (GMT)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Unable to write to SIMASK
In-Reply-To: <Pine.LNX.4.21.0201312050570.1490-100000@tn100build.india.tejasnetworks.com>
Message-ID: <Pine.LNX.4.21.0202210030560.24106-100000@tn100build.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi..

  We have an MPC860T based custom board.

  We wanted to control interrupt on one of the irqs by writing to SIMASK
register using a small driver with two ioctls which will will do
the following:

  // WRITE_MASK_IOCTL
  simask_write_ioctl(mask) {
    cli();
    (volatile unsigned int *)(IMMR + simask_offset) = mask;
    written_value = *(volatile unsigned int *)(IMMR + simask_offset);
    sti();
    printk (written_value);
  }

  // READ_MASK_IOCTL
  simask_read_ioctl() {
    cli(); // Not really needed..
    read_value = *(volatile unsigned int *)(IMMR + simask_offset);
    sti();
    printk (read_value);
  }


  When we make the ioctl calls from user space the value of the mask
seems to be getting changed during the driver time, but is reverted
back to its original value when we try to read it again.

Following is the sequence of events:

  ioctl(fd, READ_MASK_IOCTL) = 0x3edd0000
  ioctl(fd, WRITE_MASK_IOCTL, 0x1edd0000)
    here printk of the driver prints 0x1edd0000, so it looks like
    the value is written
  ioctl(fd, READ_MASK_IOCTL) = 0x3edd0000
    => somebody is reverting it back.

Any clue as to why this is happening?

thanx in advance
gopi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
