Date: Wed, 7 Apr 1999 13:40:30 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: MVME2306 progress
Message-ID: <Pine.SO4.4.05.9904071129260.15656-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody !

I am pleased to be able to say that our MVME2306 finally runs 
full Linux - sort of ;-)

FTR, the main problem after installing the pre-R5 were the several
'chkconfig --add' commands in the install scripts. I fixed this by
booting with ``init=/bin/bash'' and then doing all the chkconfigs
manually from the bash prompt. After this, Linux boots almost
perfectly smooth. There are still some small problems, though, but
they seem more RedHat-related to me :

* rpm works fine on the NFS host (a Linux/i386 PC), but not on the
  board itself. I suspect it has to do with the path settings.
  On the PC, I use ``--root /export'' for the correct path. On the
  board however, I get always this message :
  
  ``failed to open //var/lib/rpm/packages.rpm''

  Note the double-slash. Using ``--root /'' on the board did not work.

* Syslogd does not run. It exits because it says it cannot create a
  /dev/log device (which is a FIFO, I believe). Now, running the
  dev package does not help, although it contains a /dev/log file.

* I have all the network-scripts in /etc/sysconfig/network-scripts,
  but there is no /etc/sysconfig/networking. In fact, the only file
  in /etc/sysconfig is ``network-scripts''. Is this normal ?

If anyone could solve this minor glitches, I'd appreciate their help.

Kind regards,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"I am cold on a bed of ice,
 but like seasons I know it will pass.
 It will always return again though.
 A summer of love is a momentary and transient thing.
 Winter will always return again."
 - Anne Clark




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
