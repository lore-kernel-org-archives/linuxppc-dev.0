Subject: Re: IRDA/IRCOMM on a TiBook patch
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Till Straumann <Till.Straumann@TU-Berlin.de>
Cc: linuxppc-dev@lists.linuxppc.org, linux-irda@pasta.cs.uit.no
In-Reply-To: <3BCC104D.B5770ADE@TU-Berlin.de>
References: <3BCC104D.B5770ADE@TU-Berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: 19 Oct 2001 03:02:27 +0200
Message-Id: <1003453347.24371.912.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2001-10-16 at 12:47, Till Straumann wrote:

> I (and I believe other people as well) had problems
> setting up IRDA/IRCOMM on a TiBook / 2.4.12-benh and
> older 2.4 series kernels [on powerpc].
>
> As far as I could find out there are several problems:
>
> 1) There seems to be a timing problem when opening
>    the irda port which prevents it from being properly
>    initialized.
>
>    When I run "irattach /dev/ttyS1 -s 1", my Nokia 8890
>    is never discovered. However, when I issue a 'cat /dev/ttyS1',
>    prior to starting irattach (i.e. by opening the device
>    [and holding it open until irattach starts]),
>    things are properly initialized
>    and discovery works. Putting 'mdelay(100);' somewhere
>    in macserial.c:rs_open() does the job. However, I have
>    not yet figured out what exactly causes the problem.
>    A user space work-around involves patching irattach.c
>
> 2) There is an endianness bug. A possible solution is attached.

Your patch seems to be missing a bit (in qos.c IIRC) though.

> 3) When applying 1) and 2), IRCOMM works provided that
>    /proc/sys/net/irda/max_baud_rate is clamped to 57600.
>    Apparently, there is another problem in 'macserial.c' where speeds
>    higher than 57600 are treated especially.

Have you managed to do anything 'real' yet? I tried your patch, and it
does seem to improve things, irdadump seems to show data from my Palm,
but I haven't succeeded to synchronize yet.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
