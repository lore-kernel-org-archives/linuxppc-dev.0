Date: Sat, 15 May 1999 17:04:35 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Corey Minyard <minyard@acm.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.8/2.3.0 SCSI problems?
In-Reply-To: <m2lnerwe5o.fsf@wf-rch.cirr.com>
Message-ID: <Pine.LNX.3.96.990515165822.25301C-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 14 May 1999, Corey Minyard wrote:

> I'm having the same problem with my MVME2700 with an ncr53c8xx chip.
> I did a little debugging and checking.  In my previous kernel version
> that I had running (2.2p4), it chose to use interrupt 14 for the chip.
> In 2.2.9, it chose to use interrupt 19.  But that is the only thing I
> can find.
> 
> If anyone has a solution I'd like to know.

The change in interrupts is due to it now using the MPIC for PCI
interrupts instead of the legacy PIC support in with the MPIC
in the default passthrough mode. Raven/Hawk boards got support starting at
2.2.8 but a couple lines of code got dropped somewhere.  My patch I posted
yesterday solves this problem...it wasn't setting the interrupt handler to
the openpic code as it should.  Thus, the first PCI device that tried to
init during boot hangs the system (SCSI).  I've tested this patch on MTX,
MVME2300SC, 2400. and 2700.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
