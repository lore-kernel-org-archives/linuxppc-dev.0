To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LinuxPPC2000 on MPC860
References: <0FQH0010T6SWW5@pmdf-it.hasler.ascom.ch>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Feb 2000 13:35:24 +0100
In-Reply-To: Ruedi.Hofer@ascom.ch's message of "Fri, 25 Feb 2000 08:42:14 +0100 (CET)"
Message-ID: <kfywvntv4s3.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch writes:

> Changing the following values from
>
> >linux01:/usr/nfs/tftpboot/dev # l cua0 console ttyS0
> >crw-------   1 root     tty        5,   1 Feb 25 08:18 console
> >crw-------   1 root     tty        5,  64 Feb 25 08:05 cua0
> >crw-------   1 root     tty        4,  64 Feb 23 11:44 ttyS0
>
> to
>
> >linux01:/usr/nfs/tftpboot/dev # l cua0 console ttyS0
> >crw-------   1 root     tty        4,  64 Feb 25 08:26 console
> >crw-------   1 root     tty        4,  64 Feb 25 08:26 cua0
> >crw-------   1 root     tty        4,  64 Feb 23 11:44 ttyS0
>
> or to
>
> >linux01:/usr/nfs/tftpboot/dev # l cua0 console ttyS0
> >lrwxrwxrwx   1 root     root            5 Feb 25 08:29 console -> ttyS0
> >lrwxrwxrwx   1 root     root            5 Feb 25 08:29 cua0 -> ttyS0
> >crw-------   1 root     tty        4,  64 Feb 23 11:44 ttyS0
>
> didn't help, unfortunately. Only the first (and original) setting produced
> an output at all!

The first version is the only correct one.
The "tty_io.c: process 1 (swapper) used obsolete /dev/cua0 - update software to use /dev/ttyS0"
is a non-harmful bug in uart.c. Just ignore it or change the first
occurence of TTYAUX_MAJOR to TTY_MAJOR.

> Does someone know where the initial stdin, stdout settings are configured??

They point to /dev/console, which is your boot-console.

> The /dev/stdin points somewhere to /proc/self/fd/0. At this time of boot, /proc
> is not mounted yet !!!

/dev/stdin, /dev/stdout and /dev/stderr doesn't have anything to do
with anything.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
