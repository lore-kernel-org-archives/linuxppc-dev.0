Date: Sun, 3 Jan 1999 22:50:45 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: drow@cs.cmu.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
In-Reply-To: <199901030633.RAA09630@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.95.990103224624.29306A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i have tried out the current vger kernel and i'd characterize it as "five
times" as stable. meaning i can copy 125 megabytes from a jaz on the
external bus to a drive on the internal bus before it crashes--with
2.1.130 i could only copy about 25 megabytes before it crashed. the error
when it crashes is always:

Kernel panic: Inactive in scsi_request_queueable
In swapper task - not syncing
Rebooting in 180 seconds...

is there anything i could do to help dig up this problem?

thanks
brad

> 
> Brad Midgley <brad@pht.com> wrote:
> 
> > what was the result of testing this patch? i see it isn't present at vger.
> > but does it make scsi activity safer? does it need more testing? should i
> > test it as-is?
> 
> [patch to drivers/scsi/sd.c snipped]
> 
> It turns out that patch isn't necessary - all that was needed is to do
> spin_lock_irqsave(&io_request_lock, flags) before calling the scsi
> done function in the mesh driver (and spin_unlock_irqrestore after).
> That's done, in different forms, both in vger and Linus' 2.2.0-pre2
> and later, so it should be OK now.
> 
> Paul.
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
