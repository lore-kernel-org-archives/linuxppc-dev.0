Message-ID: <3A2E0EC6.A1239E1A@esd-electronics.com>
Date: Wed, 06 Dec 2000 11:02:46 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mount via nfs using MontaVista's Linux for IBM405
References: <3A2CC1A9.8A0E8DC2@esd-electronics.com> <3A2D4B81.F0238326@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Frank,

I tried the nolock option for the mount command. It does not really
work, only sometimes, not very
frequently.

Here is exactly how I do the mount:

mount -t nfs -o nolock -v 192.168.2.190:/home/matthias/canbtgw
/home/matthias

(All directories exist, mounting from other computers is working.)

Here is the output:

  nfs warning: mount version older than kernel
  192.168.2.190:/home/matthias/canbtgw on /home/matthias type nfs
(rw,nolock,addr=192.168.2.190)
... long time later ...
  VFS: Close: file count is 0
  VFS: Close: file count is 0
... long time later ...
  VFS: Close: file count is 0

... mount never returns ...

Any further idea ?

Matthias

Frank Rowand wrote:
>
> Matthias Fuchs wrote:
> >
> > Hello,
> >
> > I am trying to mount a directory from a nfs server to my IBM405GP board.
> >
> > Here are the facts:
> >
> >         Kernel on our 405 board: 2.4.0-test2_mvista_001126
> >         Root filesystem: target_ftest4 from MontaVista
> >
> > When I do a: mount -t nfs <nfs-servers-ip>:/home/matthias /test on the
> > 405 board, I get this output (after some delay):
> >
> >         nfs warning: mount version older than kernel
> >         portmap: server localhost not responding, timed out
> >         portmap: server localhost not responding, timed out
> >         lockd_up: makesock failed, error=-5
> >
> > But I can still telnet to the board (it does not crash) but I cannot
> > interrupt the mount call.
> >
> > The nfs server is working properly, because I get the root filesystem
> > from the same server (with no problems).
> >
> > Has anybody a solution for this problem ?
> >
> > Matthias
> > --
>
> Add the "-o nolock" option to the mount command.
>
> -Frank
> --
> Frank Rowand <frank_rowand@mvista.com>
> MontaVista Software, Inc

--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
