To: Robert Schwebel <robert@schwebel.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Jun 2003 16:10:47 +0200."
             <20030610141047.GU9379@pengutronix.de>
Date: Tue, 10 Jun 2003 16:39:06 +0200
Message-Id: <20030610143911.C3835C5FD7@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20030610141047.GU9379@pengutronix.de> you wrote:
>
> I'm currently porting u-boot and Linux to an IBM 405GP based board. The
> problem is now that init seems not to be running and does not give any
> output. Up to that point where init should make some noise the kernel
...
> Nevertheless, the kernel runs smoothly. I can ping the machine, I can
> even floodping it with 0% packet loss. Only that there is no userspace
> running.

Do user space program like init really don;t run,  or  is  there  any
chance that you just might see no output?

You can do a couple of things:

* Check your adaptions of the kernel source and your kernel  configu-
  ration is you really have a working serial console port.

* If booting over NFS realy works, you can try to start a (statically
  linked small test program) that does something else but a printf to
  the console. For example, open  a  file  in  /tmp  for  output  and
  frpintf to that file.

* Or  start  your  test  program  with  a  known  system  call  (like
  gettimeofday() or maybe even getuid() etc.) and set a breakpoint at
  the system call handler code inthe kernel.


You wrote "opening the console works" - set a breakpoint, and  verify
that your console driver is really initialized and used.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In general, if you think something isn't in Perl, try it out, because
it usually is :-) - Larry Wall in <1991Jul31.174523.9447@netlabs.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
