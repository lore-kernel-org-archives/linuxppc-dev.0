Date: Sun, 3 Jan 1999 17:33:49 +1100
Message-Id: <199901030633.RAA09630@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: drow@cs.cmu.edu, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.96LJ1.1b7.990102121137.439B-100000@cricket> (message
	from Brad Midgley on Sat, 2 Jan 1999 12:14:49 -0700 (MST))
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96LJ1.1b7.990102121137.439B-100000@cricket>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> what was the result of testing this patch? i see it isn't present at vger.
> but does it make scsi activity safer? does it need more testing? should i
> test it as-is?

[patch to drivers/scsi/sd.c snipped]

It turns out that patch isn't necessary - all that was needed is to do
spin_lock_irqsave(&io_request_lock, flags) before calling the scsi
done function in the mesh driver (and spin_unlock_irqrestore after).
That's done, in different forms, both in vger and Linus' 2.2.0-pre2
and later, so it should be OK now.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
