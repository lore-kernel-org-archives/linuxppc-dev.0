Date: Thu, 20 Nov 2003 23:11:57 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440gx ethernet lockup
Message-ID: <20031121071157.GA7078@gate.ebshome.net>
References: <20031121023649.GA5602@gate.ebshome.net> <20031121063247.59445.qmail@web40905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031121063247.59445.qmail@web40905.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 20, 2003 at 10:32:47PM -0800, Brian Kuschak wrote:
>
> >
> > What kernel version? What board? Eval or your custom
> > one?
> > If the custom one, did you try your test on eval?
> >
>
> It's based on 2.4.19 linuxppc_2_4 plus IBM's
> 440gx_nova_fp patch.

I got impression that IBM patch wasn't of a good quality (the one
against mvl 2.4.17).
linuxppc-2.4 tree has some changes for EMAC4, not sure they
were in IBM's patch.

> Custom hardware.  During
> previous testing on eval board there was a loss of
> connectivity, which in hindsight could have been this
> problem.  I'm working on reproducing it on the eval
> board.
>
> > How long does it usually take to get into lock up
> > state?
> >
> > I've just ran your "find" cmd for 10 minutes on our
> > 440GX board
> > without any problems.
> >
>
> With aforementioned command, <5000 to 300,000 packets,
> if MSWM bit is disabled or enabled, respectively.
> Only happens if nfs is mounted tcp, udp mode doesn't
> seem to trigger it, or at least not as quickly.

Hmm, I was testing NFS over UDP for 40 min. Not sure I can easily test
NFS over TCP. What about netperf?

> > What clock mode are you using (533/152, 500/166 or
> > smth else)?
> > Do you have L2C enabled? If yes, please check
> > L2C0_SR for parity
> > errors (we have some problems with several our 440GX
> > boards).
> >
>
> 666/166.

You may want to try lower speeds. May help to isolate problem :)

> CONFIG_440GX_L2_INSTRUCTION=y
> CONFIG_440GXL2_CACHE=y
>
> I'll check on the parity errors, although I'm not sure
> how that could lockup the EMAC.

Well, you can get corrupted code with impredictable results. We are
still investigating these L2C parity errors. I saw several times
something similar to your situation when EMAC was stuck on faulty
board, although I didn't look at it hard.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
