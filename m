Date: Mon, 8 Jan 2001 14:35:23 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
cc: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
In-Reply-To: <200101070559.XAA14527@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1010108140927.12092B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 6 Jan 2001 12:22:19 -0600, Tony Mantler <nicoya@apia.dhs.org> wrote:
>
> At 11:42 AM -0600 1/6/2001, Tom Rini wrote:
> [...]
> >In short, what I think we'll need soon is what 2.4.0 needs now.  People other
> >than the usual gang of testers to try it out and find bugs.
>
> For the record, where is an rsync/tgz for the current 'needs testing' tree?
> I haven't had a bootable kernel on my 9600/200mp since 2.4.0-test11
> linux-pmac-devel rsync.
>
Which tree is the 2.4.0 on rsync at ppc.samba.org::linux-pmac-devel?

For the record, it builds o.k. and has been running well on my Lombard
so (no SMP configured!) far, except for one panic I was unable to reproduce
yet.

I have some problems with dmasound and ppp modules, though. After some
fiddling with modules.conf I was able to get the mixer (from gkrellm)
to work and sound from internal and external speakers by aliasing
char-major-13 to dmasound_awacs, but there are occasional messages about
several sound-slot-[01] and sound-services-[01]-[013](?) modules
missing. The mixer tends to hang and has to be killed then. While
mpg123 did work, xmms always crashes with a Bus error on startup.

I can't get a ppp connection under 2.4.0 either (didn't work with any of
the -test kernels). The connection itself seems to be established correctly,
but then pppd or chat have problems with the terminal type:

Jan  7 22:26:35 miranda kernel: CSLIP: code copyright 1989 Regents of the University of California
Jan  7 22:26:35 miranda kernel: PPP generic driver version 2.4.1
Jan  7 22:26:35 miranda pppd[834]: pppd 2.3.10 started by derek, uid 2300
Jan  7 22:26:35 miranda kernel: PowerMac Z8530 serial driver version 2.0
Jan  7 22:26:35 miranda kernel: tty00 at 0xcd832020 (irq = 15) is a Z8530 ESCC (cobalt modem)
Jan  7 22:26:35 miranda kernel: tty01 at 0xcd853000 (irq = 16) is a Z8530 ESCC (IrDA)
[...]
Jan  7 22:27:11 miranda chat[836]: CONNECT
Jan  7 22:27:11 miranda chat[836]:  -- got it
Jan  7 22:27:11 miranda chat[836]: send (^M)
Jan  7 22:27:11 miranda pppd[834]: Serial connection established.
Jan  7 22:27:11 miranda pppd[834]: Using interface ppp0
Jan  7 22:27:11 miranda pppd[834]: Connect: ppp0 <--> /dev/ttyS0
Jan  7 22:27:34 miranda pppd[834]: Hangup (SIGHUP)
Jan  7 22:27:40 miranda pppd[834]: Connection terminated.
Jan  7 22:27:40 miranda pppd[834]: tcflush failed: Eingabe-/Ausgabefehler
Jan  7 22:27:40 miranda chat[840]: Can't get terminal parameters: Eingabe-/Ausgabefehler
Jan  7 22:27:40 miranda pppd[834]: disconnect script failed
Jan  7 22:27:41 miranda pppd[834]: Exit.

That last error means "I/O-error".
With 2.2 kernels, at this point the compression modules would be loaded:

Jan  8 11:11:15 miranda pppd[694]: Connect: ppp0 <--> /dev/ttyS0
Jan  8 11:11:16 miranda kernel: PPP BSD Compression module registered
Jan  8 11:11:16 miranda kernel: PPP Deflate Compression module registered

but under 2.4 they aren't loaded and neither do they seem to be missed:

root@miranda:634$ lsmod
Module                  Size  Used by
macserial              38176   1  (autoclean)
ppp_async               8672   0  (autoclean) (unused)
ppp_generic            21696   1  (autoclean) [ppp_async]
slhc                    4560   0  (autoclean) [ppp_generic]

(it doesn't make a difference when I load them manually).

I had to set the following aliases to start the connection in the first
place:

alias char-major-108  ppp
alias ppp ppp_async
alias tty-ldisc-3 ppp_async
#
alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate

Any ideas?

							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
