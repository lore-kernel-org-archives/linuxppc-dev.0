To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: make module_install 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Dec 2002 16:58:49 +0100."
             <000701c2a5e5$30b5a660$0700a8c0@pc005>
Date: Tue, 17 Dec 2002 17:39:01 +0100
Message-Id: <20021217163906.0E610C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gianfranco,

in message <000701c2a5e5$30b5a660$0700a8c0@pc005> you wrote:
>
> I have implemented a loadable driver and I have compiled the source code
> with the command "make modules". When I try to run the install script with

OK so far.

> the command "make modules_install" it exits with the following message:

This is wrong; it will try to install the modules not on your  target
filesystem,  but  on your development host, and (if you're running as
root and the copy actually succeeds - which is another mistake: never
do such things  as  root!)  your  development  host's  "depmod"  will
complain.

You should pass a "INSTALL_MOD_PATH=<target_dir>" parameter  to  your
make command, something like

	make modules_install INSTALL_MOD_PATH=/opt/eldk/ppc_8xx

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are three ways to get something  done:  do  it  yourself,  hire
someone, or forbid your kids to do it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
