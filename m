Date: Tue, 1 Jun 1999 21:00:46 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
cc: linuxppc-user <linuxppc-user@lists.linuxppc.org>
Subject: Re: Crashes with 2.2.9
In-Reply-To: <374878E2.1D00A662@phx.mcd.mot.com>
Message-ID: <Pine.BSI.3.96.990601205536.16317A-100000@usr07.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Jeff Rugen wrote:
> 
> > I'm running 2.2.9 (from vger a couple days ago) on a Motorola PowerStack
> > (100MHx 604).  The entire OS is locking up on me in two different
> > circumstances.
> >

<snip>

> >
> > #2 SCSI timeouts or something.  The following was dumped to the console
> > (this happens even while I'm not doing anything at the machine).
> >
> > scsi : aborting command due to timeout : pid 30858, scsi0, channel 0, id 2, lun
> > 0 0x0a 0d 40 28 08 00
> > ncr53c8xx_abort: pid=30858 serial_number=30863 serial_number_at_timeout=30863
> >

Interestingly enough, I reproduced some scsi aborts due to timeouts in
2.2.2, and the kernel did not lock up.  The timeout info was sent to my
current console instead of to my serial console on that version as well (but
I don't know if I have that built in to that version, and don't have access
to my other computer to look now).

The way I was able to generate the scsi timeouts nearly at will was with a
sequence of commands like:

     1  20:52   cat /proc/bus/pci/00/0b.0
     2  20:52   cat /proc/bus/pci/00/0c.0
     3  20:52   cat /proc/bus/pci/00/0e.0
     4  20:52   cat /proc/bus/pci/00/0f.0
     5  20:52   cat /proc/scsi/

The 3rd one I hit ^D a few times before hitting return.  I don't know for
sure if that specifically caused the problem, but by playing around with cat
/proc/<whatever> I generated scsi timeouts that did not lock up the machine
on 2.2.2.  Maybe the error handling code for this situation was tweaked in a
later version of the kernel?  (Or maybe it was wrong in 2.2.2 and I would be
safer had the machine locked up).

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
