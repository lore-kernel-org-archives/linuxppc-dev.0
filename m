Date: Fri, 26 Jan 2001 21:50:49 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: Amit Chaudhary <amitc@brocade.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao m
 ode
In-Reply-To: <20010126151215.B13893@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.30.0101262143110.5676-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Though i cannot help you with your exact problem, some pointers.
> > 1. The log should be typicall in /var/log/messages as long  as you
> > have syslogd and klogd running.
>
> Unfortunately, since /var lives on the same bus, this doesn't help.  But
> I'll try setting up a minimal linux installation on the other SCSI bus
> and burning a CD, and will hopefully then find something out.

Even with /var living on a different bus, locking the MESH bus solid
probably means you have all of the SCSI midlevel and perhaps the whole VFS
locked up. I'm not sure about the precise granularity of locking (2.2 or
2.4 kernel? I forgot what you said about kernel versions) but I doubt
there is a per-hostadapter lock even in 2.4.

So what I'm saying is: rather try logging to serial console or network in
order to see if there's any output produced (it might help to stop syslogd
and klogd altogether and only use serial console) before you go to the
effort to set up a copy of the system on another bus.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
