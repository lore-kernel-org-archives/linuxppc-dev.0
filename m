Date: Tue, 1 Feb 2000 10:51:42 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Script for automated booting RPX boards
Message-ID: <Pine.LNX.4.21.0002011038070.5714-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

Just in case if anybody here is interested, I'm sending a script that
makes it possible to automate booting RPX/Lite boards from Minicom.

This script can also be used together with pppd for establishing a PPP
connection upon the boot.

Main features:

Runs under runscript and intergrates well with Minicom (Ctrl-A G)
Can be run before and after reset, and also after an unsuccessful load
Detection of "dash rotation"
Flexibility - you can specify kernel name parameters

This script requires kernels to be processed with fixed zsrec.c (see my
previous message)

Happy hacking,
Pavel Roskin

=== cut here ===
#!/usr/bin/runscript
# Script for loading RPX/Lite boards
# Copyright (C) 2000 Pavel Roskin <pavel_roskin@geocities.com>
# Process this file with runscript from Minicom distributions

	goto faststart

try_enter:
	send ""
faststart:
	expect {
		"BCLOPRST key : <?> :"
		"123456789T key : <?> :" goto reload
		"/\b-\b\\" goto try_enter
		timeout 30 goto failed
	}
	send "l\c"
	expect {
		"<?> : "
		timeout 10 goto failed
	}
reload:
	send "7\c"
	expect {
		"> : "
		timeout 10 goto failed
	}
	send ""
	expect {
		"> : "
		timeout 10 goto failed
	}
	# kernel name goes here
	send ""
	expect {
		"> : "
		timeout 10 goto failed
	}
	send ""
	expect {
		"00200000"
		"<?> :" goto reload
		timeout 30 goto failed
	}
	expect {
		"<?> : "
		timeout 10 goto failed
	}
	send "9\c"
	expect {
		"confirm] :"
		timeout 10 goto failed
	}
	send "YES\c"
	expect {
		"load:"
		timeout 10 goto failed
	}
	# kernel parameters go here
	send ""
	expect {
		"booting the kernel"
		timeout 10 goto failed
	}
	exit 0

failed:
	print "\nScript failed\n"
	exit 1
=== cut here ===


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
