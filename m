To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: make module_install 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Dec 2002 17:55:33 +0100."
             <001301c2a5ed$1d546ea0$0700a8c0@pc005>
Date: Tue, 17 Dec 2002 18:37:39 +0100
Message-Id: <20021217173744.78C63C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001301c2a5ed$1d546ea0$0700a8c0@pc005> you wrote:
>
> > make modules_install INSTALL_MOD_PATH=/opt/eldk/ppc_8xx
>
> By doing that I have solved only the 50% of the problem. In fact now the
> files are moved in the right place but the message still exist.

I know. I tend to simply ignore it ;-)

> It seems that the architecture of the ELF files was wrong or the depmod runs
> for an i386 architecture.

The latter is the case: you are running a host-depmod  but  a  cross-
depmod  is  needed.  Feel  free to change the defintiion of DEPMOD in
your top-level makefile to your liking.

IMHO this is overkill, though. For  standard  desktop/server  systems
modules are used to be able to run the same kernel version for a wide
range  of  hardware  configurations;  but the situation is completely
different for embedded systems: modules are  usually  only  used  for
driver  development,  and  then you will manually load and unload the
driver anyway. I will even go so far to say that if you need  to  run
"depmod"  for  your embedded system you should fix your system design
because you are doing something wrong.

Of course, YMMV.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In theory, there is no difference between  theory  and  practice.  In
practice, however, there is.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
