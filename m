Mime-Version: 1.0
Message-Id: <p05111b16b95d05434f09@[10.8.16.89]>
Date: Thu, 18 Jul 2002 19:06:12 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: Directly accessing I/O ports
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'd like to get the Linux ethernet card diagnostic tool,
eepro100-diag.c (from http://www.scyld.com/diag/index.html) running
on the PowerPC.

Unfortunately, it uses iopl() and inw()/outw()/inl()/outl() to access
the entire I/O port space directly in userland. In fact, much of this
family of utils does the same thing.

I tried something like:
	io_fd = open("/dev/port", O_RDWR);
	iobase = mmap(0, device_size, PROT_READ|PROT_WRITE, MAP_SHARED,
		io_fd, device_base);
but I can't get it to work.


Are there suggestions (or code snippets) as to how I should proceed?

For that matter, what's the *right* way to access this sort of thing
from userland?

Thanks,
-Greg
--
  Gregory E. Allen, MSEE Engineering Scientist
  Applied Research Laboratories: The University of Texas at Austin
  Please help find my missing daughter: http://FindSabrina.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
