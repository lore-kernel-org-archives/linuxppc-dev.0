Date: Tue, 21 Mar 2000 15:55:12 -0600 (CST)
From: Don Holmgren <djholm@fnal.gov>
Reply-To: Don Holmgren <djholm@fnal.gov>
To: Wolfgang Denk <wd@denx.de>
cc: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root nfs boot problems
In-Reply-To: <200003211928.UAA20238@denx.local.net>
Message-ID: <Pine.SGI.3.95.1000321154553.11833B-100000@hppc.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 21 Mar 2000, Wolfgang Denk wrote:

>
> In message <Pine.SGI.3.95.1000321111628.2421C-100000@hppc.fnal.gov> you wrote:
> >
> > I don't believe the "neighbour table overflow" errors are the problem.  I
> > get them frequently but otherwise have success.
>
> I have never seen such errors when the ethernet  inrface  is  working
> correclty.

>From a boot this morning on an MVME-2307:

  eth0: DC21140 at 0x11000 (PCI bus 0, device 14), h/w address 08:00:3e:2a:1d:42,
      and requires IRQ18 (provided by PCI BIOS).
  de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
  Looking up port of RPC 100003/2 on 131.225.84.99
  neighbour table overflow
  eth0: media is TP.
  Looking up port of RPC 100005/1 on 131.225.84.99
  VFS: Mounted root (NFS filesystem) readonly.
  . . .

I almost always get this single "neighbour table overflow" message, but
subsequently no ethernet problems.


>
> > It looks like a problem on your nfs server.  The "unable to get nfsd port
> > number from server" and "unable to get mountd port number from server"
> > messages indicate that at minimum, the portmapper is not running on your
> > server.  Perhaps mountd and/or nfsd are also not running.
>
> Well, IMHO it's more likely that no packets were  ever  sent  to  the
> ethernet  at  all.  This  type  of problemppens for instance when the
> Transmit Enable signal is not asserted.
>
> It might be useful to check with a sniffer if the box is transmitting
> at all...
>
> Wolfgang Denk
>

I definitely agree.  tcpdump on the nfs server (or strace on
rpc.mountd/rpc.nfsd tasks) would do the trick.

Don Holmgren


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
