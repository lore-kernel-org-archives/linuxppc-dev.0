Date: Thu, 11 Feb 1999 13:43:29 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Brad Midgley <brad@pht.com>
Cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        geiseri@msoe.edu
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Message-ID: <19990211134328.A16812@drow.res.cmu.edu>
References: <Pine.LNX.3.95.990118132148.32489A-100000@pacific.pht.com> <Pine.LNX.3.95.990203174811.1985A-100000@pacific.pht.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.990203174811.1985A-100000@pacific.pht.com>; from Brad Midgley on Wed, Feb 03, 1999 at 05:54:38PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 03, 1999 at 05:54:38PM -0700, Brad Midgley wrote:
> i did a successful burn today! woohoo!
> 
> cdrecord: fifo was 0 times empty and 13164 times full, min fill was 92%.
> 
> the solution was to move the hard drive with the data on it to the
> internal scsi bus on my 7500. the burner (a ricoh) is still on the
> 53c94. 
> 
> so... the 53c94 driver currently doesn't allow enough access to regular
> hard drives when you're using the generic device. i don't know how this
> relates to disconnect/reconnect or the scheduler. 
> 
> it isn't going to be an option for everybody to move their source drives
> to another bus but at least we know burning works in some configurations. 

This is interesting - my failed burns were from internal HD to external
burner.  They do work now, though, with Paul's evil interrupt-disabling
patch to sd.c.  I couldn't track down why the interrupts were
incorrectly enabled...

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|     CMU, CS class of 2002      |
|   Debian GNU/Linux Developer    __   Part-Time Systems Programmer  |
|         dan@debian.org         |  |        drow@cs.cmu.edu         |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
