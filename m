Date: Mon, 15 May 2000 18:49:38 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Ruedi.Hofer@ascom.ch
cc: linuxppc-embedded@lists.linuxppc.org, host@linux01.hasler.ascom.ch
Subject: Re: CVS
In-Reply-To: <0FUL00C4EG2IEL@pmdf-it.hasler.ascom.ch>
Message-ID: <Pine.LNX.4.21.0005151818050.9964-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> I have a slightly off topic question: How do you control your Linux files?

CVS

> I tried to use CVS and wanted to keep all files stored in there. I imported
> directories containing complete Linux distributions....
>
> I ran into problems with those files:
> - /dev/xxx

Write a script that creates them or moves them to the place where they
should be.

Another, slightly perversive approach is to make /dev/console a regular
file and create other devices at the run time from rc.sysinit. It works
for me.

> - binary, executable files

Don't put them on CVS. Write another script that compiles them from the
sources. Make exceptions only for huge files that take too much time to
compile and are not going to change often (e.g. libc, libstdc++)

> - How to preserve the permissions for the /dev and executable files.
>   (The PRESERVEPERMISSIONS switch is too strong and complains
>     about 'hard linkage errors' when rebuilding binaries and committing
>     to the repo again!)

Set them from scripts.

> - How to distinguish automatically between binaries and text files.
>   (Automatic control of the -kb switch!)

I have just 6 binary files on my CVS (one being logo.gif - the penguin
from the kernel sources). It's not worth the trouble IMHO.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
