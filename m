Subject: Re: linux + serial console
From: Guillaume =?ISO-8859-1?Q?Laur=E8s?= <guillaume.laures@noos.fr>
To: Jure Menart <jure@kom.org>
Cc: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20011009203308.B28132@hannanges.teden-mladih.com>
References: <20011009203308.B28132@hannanges.teden-mladih.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 09 Oct 2001 21:58:03 -0400
Message-Id: <1002679084.773.5.camel@pmg4>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


le mar 09-10-2001 at 14:33 Jure Menart a écrit :
>
> Hello,
> I'm trying to have Linux box (custom made board, IBM 405gp), which would
> 'work' only through serial console (ttyS0).
> I try many things but I just couldn't keep my 'console' on ttyS0.
> I change everything in main.c to open only /dev/ttyS0, not the usual
> /dev/console. I made /dev/std[io,out,err] links which pointed to /dev/ttyS0
> (although it isn't important I think), but my console 'dissapears' anyway.
> Did I forget something... or better - what did I forget?


I run "root=/dev/hda14 console=ttyS0,38400 console=tty0" as a boot
comand line.
Both console declaration enable output of startup messages on the serial
port as well as on the console, you may only use "console=ttyS0,9600" or
so.

Interesting too, if you happen to have getty installed (getty_ps rpm)
you can set in your /etc/inittab:
s1:2345:respawn:/sbin/getty ttyS0 DT38400
so that you can login on the serial port with a utility like cu or
minicom.

Adding :
ttyS0
in /etc/securetty helps also, to log in as root directly

Enjoy,

--
GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
