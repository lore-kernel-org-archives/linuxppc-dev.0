Date: Tue, 8 Aug 2000 13:20:39 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
In-Reply-To: <Pine.LNX.4.10.10008041515510.879-100000@cassiopeia.home>
Message-ID: <Pine.HPX.4.10.10008081233550.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Geert,

On Fri, 4 Aug 2000, Geert Uytterhoeven wrote:

> > Actually given the problems with RTC being UTC or local time, the offset
> > might perhaps better be setup as a kernel parameter so that th system
> > start up in a known good state. It seems that it is in RAM for Macs, but
> > what about other machines (I have no problems since all my machines are
> > UTC and I simply refuse to use an OS which requires anything else) ?
>
> Why do you want to handle the offset in the kernel???
>
> Any decent distro (e.g. Debian) allows to configure the time system for a
> hardware clock running in either UTC or local time, so the correction will be
> done on boot up.
>

I think there is some misunderstanding here. I don't want to handle the
offset in the kernel, with one possible exception: when reading the
RTC for the first time to initialize xtime. Getting timestamps right as early
as possible might be important in some cases, and it's not a big deal
since the code to do this is small and thrown away anyway.

Oh and I can't remember whether the clock or hwclock command ever worked
on my machines. I think hwclock did once upon a time; life is so much
simpler with NTP anyway (but it is run quite late in the boot process,
actually just before the rc.local script on most of my machines and after
mounting NFS file systems and starting daemons like syslogd/crond/inetd).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
