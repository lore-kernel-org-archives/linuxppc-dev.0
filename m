Message-ID: <67505026E29DD311A9AA00508B7315F31956C3@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: Ram Disk
Date: Thu, 24 Aug 2000 14:55:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From:	Whitney, John [mailto:johnw@aiinet.com]
<mailto:[mailto:johnw@aiinet.com]>
Sent:	Thursday, August 24, 2000 12:33 PM
To:	'Julia Elbert'
Subject:	RE: Ram Disk

It is certainly possible.  I found that when my system loaded files from the
ramdisk, it attempted to cache them in memory (look at /proc/meminfo).  When
the free memory started to run out, kswapd attempted to free some of the
memory.  Unfortunately, it attempted to swap out processes, which caused the
system to crash with errors similar to yours (although in my case it was
"init" that usually crashed first... I don't use /linuxrc to boot my
system).
In *my* code (I am running a modified 2.2.15 kernel), I merely commented out
the "swap_out ()" code in routine do_try_to_free_pages in mm/vmscan.c (in my
code, it's lines 405-409).  Since I made this change, my system has been
rock-steady (and I run a LOT of applications, including the Apache web
server and various CGI scripts I have written).  I now see free memory go
down as new images are read from the ramdisk, and back up as memory is freed
by the system.
Hope this helps your problem...
John Whitney
johnw@aiinet.com <mailto:johnw@aiinet.com>

-----Original Message-----
From:	Julia Elbert [mailto:jelbert@enerdyne.com]
<mailto:[mailto:jelbert@enerdyne.com]>
Sent:	Thursday, August 24, 2000 3:12 PM
To:	'linuxppc-embedded@lists.linuxppc.org'
Subject:	Ram Disk
	Importance: High



				Hi All,

I am running a 7mg ram disk in my 860t. I have multiple programs I start
through linuxrc. I am streaming video, serial data, and running a web server
on various sockets. The webserver is GoAhead. When I click on a cgi script
my system crashes with
Software Emulation Web/62 NIP: 1009a014 *NIP: 0x0 code: ffffffdaSoftware
Emulati
on linuxrc/6 NIP: 1009a014 *NIP: 0x0 code: ffffffdasash-2.03#
Am I running out of ram? I have 16 mgs.
Thanks in advance....
--Julia
<http://lists.linuxppc.org/>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
