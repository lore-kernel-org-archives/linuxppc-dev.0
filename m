Date: Sun, 21 Mar 2004 17:35:36 -0900
From: Ethan Benson <erbenson@alaska.net>
To: yaboot-users@lists.penguinppc.org,
	yaboot-devel@lists.penguinppc.org,
	Debian-powerpc <debian-powerpc@lists.debian.org>,
	Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>,
	yellowdog-general@lists.terrasoftsolutions.com,
	yellowdog-devel@lists.terrasoftsolutions.com,
	g5-test@lists.terrasoftsolutions.com
Subject: [YABOOT] Preliminary ofpath with 2.6 kernel support NEEDS TESTING
Message-ID: <20040322023536.GB21226@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

As many are painfully aware ofpath in current yaboot does not function
correctly under 2.6 systems, worse case it gives out bogus paths
therefore causing the system to fail to boot.

I have preliminary changes in current development version of yaboot
which fixes ofpath to support 2.6.4 and above kernels.

I need everyone with 2.6.4 or newer systems to test this version of
ofpath and verify that it produces correct OpenFirmware paths to your
devices (compare with ofpath output from a recent 2.4 kernel (2.4.23
or newer))

Prerequisites:

* You must have 2.6.4 or newer, previous versions lack necessary
  sysfs information.

* You must have sysfs mounted (normally on /sys, but ofpath should be
  able to detect where its mounted).

* You must still have /proc/ide so if this becomes a configurable
  option like /proc/scsi you must have it enabled (/proc/scsi is also
  required for machines with SATA drives).

The easiest way to test the new ofpath is download the current version
from http://penguinppc.org/~eb/files/ofpath and install it manually:

as root enter:

	which ofpath

this will return the path of the active ofpath program, probably
/usr/sbin/ofpath

move it to safe place:

	mv `which ofpath` /root

install the new version (put it in the same place as the old one was,
see step 1):

	install -m 755 /home/youruser/ofpath /usr/sbin/ofpath

run ofpath on all your disk devices and ensure its output is correct.

then comment out any ofboot= lines in /etc/yaboot.conf and change your
macos* entries back to /dev/ nodes, run ybin and ensure the bootloader
functions correctly.

MOST IMPORTANTLY:

	* REPORT SUCCESS *AND* FAILURE *

I want to know what kind of machine you have, and that ofpath worked
correctly, I will release yaboot 1.3.12 once I have enough success
reports for enough differing machines, very new machines are most
important, as they are the ones which old ofpath failed on.

Thanks in advance, and thanks to Nick Lopez for granting me local
shell access to his machine so I could get this done.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
