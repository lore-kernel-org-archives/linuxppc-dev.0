From: Alan Mimms <alan@packetengines.com>
To: Pavel Roskin <pavel_roskin@geocities.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Script for automated booting RPX boards
Date: Tue, 1 Feb 2000 10:39:33 -0800
Content-Type: text/plain
References: <Pine.LNX.4.21.0002011038070.5714-100000@sunapee.transcept.com>
In-Reply-To: <Pine.LNX.4.21.0002011038070.5714-100000@sunapee.transcept.com>
MIME-Version: 1.0
Message-Id: <0002011040160D.00776@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel,

Why not FLASH the kernel on your RPXLite and then autoboot it?  That works
FINE for me.  (Always assuming that you're past kernel development and doing
application work which changes on your target's NFS root mounted filesystem.)

a

On Tue, 01 Feb 2000, Pavel Roskin wrote: > Hello!
>
> Just in case if anybody here is interested, I'm sending a script that
> makes it possible to automate booting RPX/Lite boards from Minicom.
>
> This script can also be used together with pppd for establishing a PPP
> connection upon the boot.
>
> Main features:
>
> Runs under runscript and intergrates well with Minicom (Ctrl-A G)
> Can be run before and after reset, and also after an unsuccessful load
> Detection of "dash rotation"
> Flexibility - you can specify kernel name parameters
>
> This script requires kernels to be processed with fixed zsrec.c (see my
> previous message)
>
> Happy hacking,
> Pavel Roskin
>
> === cut here ===
> #!/usr/bin/runscript
> # Script for loading RPX/Lite boards
> # Copyright (C) 2000 Pavel Roskin <pavel_roskin@geocities.com>
> # Process this file with runscript from Minicom distributions
>
> 	goto faststart
>
> try_enter:
> 	send ""
> faststart:
> 	expect {
> 		"BCLOPRST key : <?> :"
> 		"123456789T key : <?> :" goto reload
> 		"/\b-\b\\" goto try_enter
> 		timeout 30 goto failed
> 	}
> 	send "l\c"
> 	expect {
> 		"<?> : "
> 		timeout 10 goto failed
> 	}
> reload:
> 	send "7\c"
> 	expect {
> 		"> : "
> 		timeout 10 goto failed
> 	}
> 	send ""
> 	expect {
> 		"> : "
> 		timeout 10 goto failed
> 	}
> 	# kernel name goes here
> 	send ""
> 	expect {
> 		"> : "
> 		timeout 10 goto failed
> 	}
> 	send ""
> 	expect {
> 		"00200000"
> 		"<?> :" goto reload
> 		timeout 30 goto failed
> 	}
> 	expect {
> 		"<?> : "
> 		timeout 10 goto failed
> 	}
> 	send "9\c"
> 	expect {
> 		"confirm] :"
> 		timeout 10 goto failed
> 	}
> 	send "YES\c"
> 	expect {
> 		"load:"
> 		timeout 10 goto failed
> 	}
> 	# kernel parameters go here
> 	send ""
> 	expect {
> 		"booting the kernel"
> 		timeout 10 goto failed
> 	}
> 	exit 0
>
> failed:
> 	print "\nScript failed\n"
> 	exit 1
> === cut here ===
>
--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
