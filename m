To: boehringer@snom.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem booting Linux on MPC8XXFADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Mar 2002 19:08:37 +0100."
             <3C9F67A5.827D4BBC@snom.de>
Date: Mon, 25 Mar 2002 20:56:03 +0100
Message-Id: <20020325195609.0E27C109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C9F67A5.827D4BBC@snom.de> you wrote:
>
> i read the lists and some manuals but i can't find any solution that fit
> to my problem.

One possible solution: get yourself a debugger...

>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
> An then no further output :-(
> I also tried, that with 2.4.4-Sources from ftp.denx.de
> (linux-2.4.4-2002-03-21.tar.bz2) but still the same problem. And i also
...
> can somebody help me? Sorry if that is a newbie question..

Check that you have configured the console on the correct  port;  you
should be able to get a good configuration with

	$ make FADS860_config
	$ make oldconfig
	$ make dep
	$ make pImage

If it still hangs, try a post-mortem dump of the log_buf  area  (grep
the  address  from  the  System.map  file  for  your kernel, subtract
0xC0000000 to get the physical address, and use the "md"  command  in
PPCBoot to dump that area).

But you should be aware - your chances to succesfully run Linux on  a
FADS rev ENG or PILOT board are pretty limted anyway.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Testing can show the presense of bugs, but not their absence.
                                                   -- Edsger Dijkstra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
