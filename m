Message-ID: <20010425165751.20891.qmail@web12408.mail.yahoo.com>
Date: Wed, 25 Apr 2001 09:57:51 -0700 (PDT)
From: Laura Dean <tralad@yahoo.com>
Subject: Re: Mounting NFS on RPX-Lite - Solved!
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20010417141021.25988.qmail@web12402.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My problem was that upon mounting, NFS wanted to see a
name for the board (not sure why it needed this when
mounting by IP address - just one of those things, I
guess).  Adding this line to /etc/hosts fixed my
problem:

10.1.100.111 rpxlite

(where 10.1.100.111 is the IP address of the board)

Cheers,
Laura


--- Laura Dean <tralad@yahoo.com> wrote:
>
> Well, rebooting fixed the problem with trying to
> mount
> the wrong directory, maybe I should use DHCP Beta
> 3.0
> but I was having problems getting that one to work
> earlier...
>
> Yes, I assume I have something configured wrong on
> my
> NFS server but I can't figure out what it could be,
> especially since I can mount the directories from
> other Linux PCs on the network.
>
> Someone suggested that I should take out the nis
> entrys in my nsswitch.conf file (which I did) and
> maybe that would make it work (which it didn't).
>
> I've also noticed a new behavior which might
> indicate
> something to someone smarter than me - after the
> board
> tries to mount the NFS server, showmount no longer
> returns a response. I restart the NFS server (and
> unplug the board), and showmount shows that
> 10.1.100.111 (the IP of the board) is mounted.
>
> Any ideas?
>
> Thanks,
> Laura
>
> --- Dan Malek <dan@mvista.com> wrote:
> > Laura Dean wrote:
> >
> > > I expect this on the kernel I built from source,
> > but I
> > > was expecting the Hard Hat kernel to be mounting
> > > /opt/hardhat/devkit/ppc/8xx/target. I assumed
> the
> > > "option root-path" line in dhcpd.conf configured
> > this.
> >
> > Version 2.0 DHCP doesn't work properly with some
> > BOOTP
> > clients, in particular when providing this
> > "extended"
> > type of information.  I suspect this may be the
> > problem, and suggest you check out isc.org for
> > information.
> >
> > I personally run Beta 3.0.
> >
> > It still looks like you may have some NFS related
> > configuration problems on the server, too.
> >
> > Oh yeah, NFS root works fine, whether you
> recompile
> > or
> > use the ready made kernels.
> >
> > 	-- Dan
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
