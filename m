Date: Fri, 28 Mar 2003 22:25:13 +0100
From: Boris Bezlaj <boris@gajba.net>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
Message-ID: <20030328212513.GA456@gajba.net>
References: <16004.27866.270601.561756@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16004.27866.270601.561756@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 28, 2003 at 04:40:10PM +0100, Mikael Pettersson wrote:
>
> With 2.4 kernels, writes to floppy are about a factor of 10 slower
> on my PowerMac 4400 than they are with 2.2 kernels.

The code changed somewhere in 2.3.x (i looked at it some time ago,
facing the same problem). I wonder how does this work on newer machines?

> The cause for this is a poll-loop in swim3.c which doesn't exist
> in the 2.2 version. The patch below reverts that change, and
> restores floppy write performance to 2.2 levels. I've built many
> boot floppies with this modified driver w/o any problems.

I tested your patch extensively..seems to work fine :)
|swim3: expected cyl 5, got 133
|swim3: expected cyl 75, got 144  <-- this could be due to bad floppy
|swim3: expected cyl 75, got 6        as i always get the same cyl
|2880+0 records in                    with the same floppy
|2880+0 records out
|1474560 bytes transferred in 41.599343 seconds (35447 bytes/sec)

There seem to be some old problems when reading
(also in 2.2 / 2.4 w/o your patch):
| swim3: expected cyl 3, got 4
| swim3: expected cyl 4, got 5
| swim3: expected cyl 5, got 6
| ....and so on until everything is loaded
most notable when loading commpressed filesystem image at boot.

There is one thing i haven't encountered before (probably
not related to your patch):
reading ...
|swim3_interrupt, state=1, cmd=0, intr=30, err=4
|swim3_interrupt, state=1, cmd=0, intr=34, err=4
|swim3: error reading block 2826 (err=4)
|end_request: I/O error, dev 02:00 (floppy), sector 2826
|swim3: error reading block 2827 (err=4)
|end_request: I/O error, dev 02:00 (floppy), sector 2827
|swim3: error reading block 2828 (err=4)
|end_request: I/O error, dev 02:00 (floppy), sector 2828
|swim3: error reading block 2829 (err=4)
|end_request: I/O error, dev 02:00 (floppy), sector 2829
|swim3: error reading block 2830 (err=4)
|end_request: I/O error, dev 02:00 (floppy), sector 2830
|swim3: error reading block 2831 (err=4)
|end_request: I/O error, dev 02:00 (floppy), sector 2831
|dd: reading `/dev/fd0': Input/output error
..end of story. After this the swim3 seems to remain in "headless
chicken mode" until reboot. Reading/writing fails miserably. Again this
could be due to bad floppy..

--

  Boris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
