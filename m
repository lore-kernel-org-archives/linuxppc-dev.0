Message-ID: <022601c1ae91$34c80820$0900a8c0@Domain.invalid>
From: "murali nagarajan" <muralin@gdatech.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Problem with ping/telnet
Date: Tue, 5 Feb 2002 14:05:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

We have a custom designed board G4 MPC7450 with GT64260 Galileo controller.
We have been able to port the Linux on this board. But we do have some
issues for which I will appreciate if some one could help me.

Implementation details:
-----------------------
We have used Mission Critical Linux 2.4.5-Pre 5 (derived from debian distro)
and PPCBoot 1.0.4 as our base versions. I used the file system meant for NFS
mount from the mission critical linux web site. We made necessary
modifications to the software to work on our custom design.

I am able to boot Linux successfully with a NFS mounted file system and a
Ramdisk (I could test upto 128MB size) based file system. But this was
possible only when I bypassed the /sbin/init and run the "Bash" shell
directly. I made changes to init/main.c to run the shell directly after
successful opening of the /dev/console. Bypassing of /sbin/init at boot time
is inevitable until we integrate a MPSC port based serial console driver
with our linux system. We have a crude one (emulates the low level UART
functions using MPSC) that just works.

We have the following difficulties:
                                   ----------
- PING command does not work
  The erro message I get is   "ping: unknown protocol icmp"

- Telnet program does not work which tells me that the service is unknown.
   The error message I get is "telnet: tcp/telnet: unknown service"

What can be the issue? I suspect if any of the boot script is not done. I
ran manually /etc/init.d/rcS and /etc/rc3.d/* (my inittab says run level 3)
from the bash prompt. This did not help to solve my above problem.

I assume that TCP/IP is fine because I have performed NFS mount of the root
file system and can access all the files. The booted OS seems to be stable
as I have run some complex Linux applications and also able to build new
Linux images.


With best regards,
Murali


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
