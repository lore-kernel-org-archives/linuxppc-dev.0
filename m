Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: linuxppc_2_4_devel, rc1 and rc2 problem.
Date: Thu, 21 Nov 2002 16:27:21 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLGEDFFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021120191423.GA13132@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sending this to the embedded list as well.

 Jocke
> On Wed, Nov 20, 2002 at 07:55:35PM +0100, Joakim Tjernlund wrote:
> >
> > > >
> > > > hmm, my i2c stuff got into rc2 (and uart too?). I see this on rc2 AND rc1, but NOT in pre8.
> > > > No, I have not tried to port it to vanilla 2.4.x. It requires some work to do that.
> > >
> > > They both made it in post rc1 I think, yes.  Try going back carefully
> > > via bk changes and bk export -tr1.xxxxx (find when
> > > /home/.../linuxppc_2_4 was merged into /home/.../linuxppc_2_4_devel).
> >
> > The error ocurres between changeset 1.1130 - 1.1137.
> > I forgot to mention that the error only happens on a 862,100Mhz, 16KB icache, 8KB dcache.
> > My 860,80Mz does not show the problem.
> >
> > Idea's ?
>
> Can you narrow down the ChangeSet it occured at a bit?

Aaargh, now I am getting it in pre8 as well. However I have made
some progress:

I have 2 custom boards one mpc862(100Mhz, 16KB icache, 8KB dcache) and a
mpc860(80Mz,4KB icache, 4KB dcache). If I overclock the mpc860 to 100MHz I get
the same problem. If I set the clock on both boards to 95MHz all is well. If I overclock
the mpc862 to 105 MHz it works fine.

It turns out that syslog is actually running after the error. If I stop syslog and
start it again it works fine. If adjust my script so klogd is started before
syslogd all is well to.

This looks like a race somewhere to me, but i have no clue as to where.

Anyone?

    Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
