Date: Sun, 24 Jan 1999 15:30:14 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Ryan Nielsen <ran@krazynet.com>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: kswapd and SMP still broke on 2.2.0-pre9
In-Reply-To: <19990123230227.A625@gondolin>
Message-ID: <Pine.LNX.4.04.9901241522050.17601-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 23 Jan 1999, Ryan Nielsen wrote:

> 
> Paul Mackerras wrote:
> > 
> > Troy Benjegerdes <hozer@drgw.net> wrote:
> > 
> > > Can anyone verify 2.2.0-pre9 works on a SMP Pmac? (or for that matter,
> > > vger.. if vger works I can figure out what changed)
> > 
> > Both 2.2.0-pre9 and vger work fine on my 2-processor powermac.  I do
> > have some local changes in my tree to do with some extra memory
> > barriers etc., but I haven't changed kswapd.  You could try rsyncing
> > my current tree from samba.anu.edu.au::linux-pmac-devel to see my
> > changes.
> 
> do you use scsi on your 2-processor powermac?
> with the rsync'd tree it stops somewhere after printing the last line of this type:
> Detected scsi disk sd%d at scsi%d, channel %d, id %d, lun %d
> all the disks are on the MESH.

I haven't tried the rsync'd tree yet, my machine was crashing in the same
SCSI initialization. I have an on-board ncr53c8xx fast-wide chip, so this
leads me to believe there is some interaction between the memory
management code and the SCSI init code.

Is this something we should bring up on the regular linux-kernel list?
Maybe someone there would have an idea what is broken.

I don't know if this is related, but I also get crashes when doing nfs
access (checking out files from my local CVS archive, in particular).
I traced it one time and it appears a pointer is getting trashed in
rpciod.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
