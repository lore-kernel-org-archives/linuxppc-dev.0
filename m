Date: Tue, 3 Apr 2001 10:58:29 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Correct /etc/gettydefs for a Serial Console
Message-Id: <Pine.SOL.4.20.0104031043200.18563-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to debug two issues with the look and feel of a serial console
on a IBM PowerPC 405GP Walnut board.

Issue 1)

	- After the first few lines of text spew out for user-space
	  process kick-off, the end-of-line characters get translated
	  incorrectly:

	  INIT: Entering runlevel: 3
	  The system is coming up.
	  Network daemons: portmap.
	  NIS domain: borg-nis
	  NIS daemons: ypbind.

	  Linux (walnut)


	  walnut console login: .
                                  NFS daemons: automount.
                                                         Internet daemons: ine
          td.
             Log daemons: syslogd klogd.
                                        RPC daemons: rstatd rusersd.
                                                                    Other dae
          mons:.

	I suspect that the problem is with my /etc/gettydefs file:

	  #
	  #    Line settings and hunt sequences for TTY ports used by getty.
	  #

	  #
	  # <speed># <init flags> # <final flags> #<login string>#<next-speed>
	  #

	  # Serial Console entry
	  console# B9600 CLOCAL # B9600 SANE TAB3 CLOCAL #\r\n\n@S console login: #console

	Does anyone have a more reasonable /etc/gettydefs. I suspect I
	might need ONLCR?

Issue 2)

	- The console prompt from getty comes up before the daemons
	  executed by the scripts in /etc/rc.d/rc3.d are finished (see
	  above example). I suspect that there's a possible problem in my
	  /etc/inittab:

	  #
	  #    System V init run level process control file
	  #

	  # Default run level
	  id:3:initdefault:

	  # System initialization.
	  si::sysinit:/etc/rc.d/rc.sysinit

	  # System console
	  co:123:respawn:/sbin/getty console console

	  l0:0:wait:/etc/rc.d/rc 0
	  l1:1:wait:/etc/rc.d/rc 1
	  l2:2:wait:/etc/rc.d/rc 2
	  l3:3:wait:/etc/rc.d/rc 3
	  l4:4:wait:/etc/rc.d/rc 4
	  l5:5:wait:/etc/rc.d/rc 5
	  l6:6:wait:/etc/rc.d/rc 6

Any ideas?

Thanks,

Grant Erickson


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
