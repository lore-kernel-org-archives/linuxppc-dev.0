Date: Sun, 30 Mar 2003 10:28:04 +0200
From: Boris Bezlaj <boris@gajba.net>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
Message-ID: <20030330082804.GA495@gajba.net>
References: <16004.27866.270601.561756@gargle.gargle.HOWL> <16005.35950.570218.844672@nanango.paulus.ozlabs.org> <20030329155501.GA587@gajba.net> <16006.19831.210218.170305@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16006.19831.210218.170305@nanango.paulus.ozlabs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 30, 2003 at 11:50:47AM +1000, Paul Mackerras wrote:
> Boris Bezlaj writes:
>
> > | kista:/tmp# dd if=swimmer of=/dev/fd0 bs=512 count=2880
> > | swim3: timeout reading sector 2647
>
> Hmmm, wonder why it's reading that sector?
>
> The timeout probably indicates that the sector header is corrupted or
> unreadable.  The driver should probably retry after verifying that it
> is on the right track.

Well it is the _bad_ floppy case :)

> > | end_request: I/O error, dev 02:00 (floppy), sector 2647   <--bad sector
> > | dd: writing `/dev/fd0': Input/output error
> > | 2647+0 records in
> > | 2646+0 records out
> > | 1354752 bytes transferred in 134.614549 seconds (10064 bytes/sec)
> >
> > after the error at sector 2647, swim3 seems to move the heads to sector 0
> > and write? another 2647 sectors. Any particular reason for that ?
>
> I don't think it's the swim3 driver itself that is doing that.  I
> would start by stracing the dd to see what writes it is doing.  It may
> be the block I/O layer doing something funny.

I will give it a shot later in the evening.

Many thanks for your effort 8)

--

  Boris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
