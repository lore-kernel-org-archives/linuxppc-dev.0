Message-ID: <E0A487F3EEFFD111A3C5004033933F9ABBF6CA@postoffice.iotech.com>
From: Derrik Weeks <derrikW@iotech.com>
To: "'Sangmoon Kim'" <dogoil@etinsys.com>,
	Derrik Weeks <derrikW@iotech.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: execve system call question
Date: Wed, 27 Feb 2002 09:33:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings Sangmoon,

My apologies, I thought that most PPC based chips had configuration or
status registers that were not in the SPR space (i.e. IMMR based regs).  A
little research says this is not the case.  As I understand it (with thanks
to Wolfgang) Linux reserves memory space below 80000000 for user
applications.  In my case I had my IMMR based registers mapped below this
value, and the kernel was setting mapping for this space to virtual =
physical, which caused my problem.  You may have the same issue with your
serial port, it would be worth a try to move it to high memory and see if
this resolves your problem.

Best of luck,
Derrik Weeks

-----Original Message-----
From: Sangmoon Kim [mailto:dogoil@etinsys.com]
Sent: Tuesday, February 26, 2002 8:31 PM
To: Derrik Weeks; linuxppc-embedded
Subject: Re: execve system call question


Hi Derrik Weeks!

> IMMR needs to be located in high memory above F0000000.

The MPC755 doesn't have an IMMR.
If it is because all the I/O should be locaced above F0000000, please let me
know. The serial port of my board is located at 0x78000000.

> kernel will crash whether you're running NFS or a ram disk.

You are right I tried ramdisk but kernel crashed.

Thank you for the reply.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
