Message-ID: <397FE132.1690D2DD@execpc.com>
Date: Thu, 27 Jul 2000 02:13:54 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Stephan Leemburg <pmud-bugs@jvc.nl>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: powerbook hang from post-sleep cdrom access - fix
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I have a fix to prevent a system hang when trying to access a cdrom
after sleeping.  I have a small util "wakebay" that simply does a
CDROM_MEDIA_CHANGED ioctl on a specified device.  I added a the line "wakebay
/dev/hdc" to PMUD's wakeup script on my PDQ.  This seems to get the desired
response from the drive, in that it locks the door and spins the disk when it
should, and if its not there, mounted, or otherwise, does nothing.

my code can be grabbed from http://www.execpc.com/~jpgarcia

Can this be done automatically at the kernel level?

Thanks.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
