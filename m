Message-ID: <39043DF4.92CE26D3@pop.agri.ch>
Date: Mon, 24 Apr 2000 14:28:38 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: unit@panix.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
References: <Pine.SUN.4.21.0004240012000.3430-100000@panix.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


unit@panix.com wrote:
>
> On Sat, 22 Apr 2000, Andreas Tobler wrote:
>
> i've also been having problems with ppp and kernels > 2.2.15pre9
> somewhat similar to below .. only with hard crashes. I can't get
> ppp to work w/ either prre17 or pre19 .. seems to be line dicipline:
>
> Apr 16 18:34:05 sophix pppd[2541]: Serial connection established.
> Apr 16 18:34:05 sophix modprobe: can't locate module tty-ldisc-3
> Apr 16 18:34:05 sophix pppd[2541]: ioctl(TIOCSETD): Invalid argument(22)
> Apr 16 18:34:05 sophix pppd[2541]: Hangup (SIGHUP)
> Apr 16 18:34:05 sophix pppd[2541]: Exit.

Have you built in ppp support or module support?
If you have mod, then have you added the lines below to
/etc/modules.conf or conf.modules?

alias   ppp-compress-21         bsd_comp
alias   ppp-compress-24         ppp_deflate
alias   ppp-compress-26         ppp_deflate
alias   tty-ldisc-3             ppp

Which ppp-pkg are you using? I use ppp-2.4.0b2, but ppp-2.3.11 should
also work fine.
(ftp.linuxcare.com.au/pub/ppp)

>
> w/ 2.2.15pre14 i can connect but if i reconnect linux crashes w/ no
> option other than a force reboot (this has happened on three occasions
> under the exact same circumstances).

How do you connect? I use netcfg. No problems so far.

> i rsynced the pre19 two days back so i'm not sure where i fall into the
> loop. However it would seem the/my problem is further back

Be sure not having something like ppp_async/ppp_generic in drivers/net/.
If so you may have the same situation I had.
rsync -avz linuxcare.com.au:linux-pmac-stable <dest-dir> should help to
get a clean download.

Otherwise???

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
