Message-Id: <200001240802.JAA26818@denx.local.net>
To: dony <dony.he@huawei.com.cn>
cc: Brendan.Simon@ctam.com.au, Grant Carter <gcarter@eng.uct.ac.za>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile dynamic apps for mpc860 on ix86
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Jan 2000 14:46:03 +0800."
             <388BF52B.213CCD61@huawei.com.cn>
Date: Mon, 24 Jan 2000 09:02:11 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <388BF52B.213CCD61@huawei.com.cn> dony wrote:
>
>     Here are some notes:
>     1      Make sure you copy all your libraries under $(prefix)/$(target)/lib and $(prefix)/lib/gcc-lib to your target's root
> filesystem /lib.

I don't think you will need the gcc-lib files on your target (as long
as you don't want to compile / linke on the target).

>                powerpc-linux-gcc -O2 -mcpu=860 -Wl,--rpath,lib -o mytest mytest.c
>               An easyest way to test this is to replace your target NFS root filesystem's /bin/sh with the above "mytest" and

Adding "init=<your_path>/mytest" will do as well.

[I don't think it is a good idea to modify files on  the  NFS  server
just for testing things. You might forget to change something back to
the  original state, or in bigger projects there might be other users
trying to use the same NFS server.]

> reset your board. And running "rpc.nfsd -F -d call" on your x86 host to monitor whether it can run correctly. If not, what file
> it cannot find? In my case , First , it can not find "/etc/ld.so.preload" and "/etc/ld.so.cache". then I run "touch
> /tftpboot/etc/{ld.so.preload,ld.so.cache}". Then reset. And continue monitoring.

Again, I don't think this is a good idea. You will be  creating  some
files  that are not really needed. For instance, "/etc/ld.so.preload"
is *NOT* needed at all.

> > Does any body out there in linuxppc-embedded land have a clue as to what could be causing the segfaults ?
> > Can someone suggest a way of getting more debugging information.  I'm using nfsd with "-F -d" call options at the moment.
>
> I think this is enough to debug your problem. This is what I use.

Grrrgh. You cannot really debug anything this way.

For instance, you will never be able to know if a failing attempt  to
open  a  non-existing  file (like "/etc/ld.so.preload") is a critical
error or just a feature that may beuseful  under  some  very  special
circumstances.

> > I can see the ld.so.1 gets called which causes lots of reads from ld-2.1.2.so and then that's it.  I would expect to get
> > calls to libc.so.6 but it never gets that far.
>
> Then where does it go after it accesses ld.so.1?

Good question - do you still claim you can  find  this  out  just  by
looking at the NFS transfers?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You young'uns. That was *long* before AltaVista,  DejaNews,  or  even
(gasp) the *Web*! In fact, we typed that thread on steam-powered card
punchers, and shipped it around via Pony Express.
            -- Randal Schwartz in <8cwww1cd0d.fsf@gadget.cscaper.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
