Date: Fri, 26 Jan 2001 16:04:41 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Amit Chaudhary <amitc@brocade.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010126160441.B16573@allspice.cs.swarthmore.edu>
References: <20010126151215.B13893@allspice.cs.swarthmore.edu> <Pine.LNX.4.30.0101262143110.5676-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0101262143110.5676-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@mail.biophys.uni-duesseldorf.de on Fri, Jan 26, 2001 at 09:50:49PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 26, 2001 at 09:50:49PM +0100, Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
> > > Though i cannot help you with your exact problem, some pointers.
> > > 1. The log should be typicall in /var/log/messages as long  as you
> > > have syslogd and klogd running.
> >
> > Unfortunately, since /var lives on the same bus, this doesn't help.  But
> > I'll try setting up a minimal linux installation on the other SCSI bus
> > and burning a CD, and will hopefully then find something out.
>
> Even with /var living on a different bus, locking the MESH bus solid
> probably means you have all of the SCSI midlevel and perhaps the whole VFS
> locked up.

Hmm, I wouldn't expect the VFS to be involved because this is using the
SCSI generic driver and presumably not going through the VFS at all.
Ah, I see, you mean if the SCSI subsystem locks, then the next time VFS
was waiting for the SCSI bus it might just stay locked forever.  Still,
if it turned out that the other SCSI bus was OK but the VFS had locked
up, I could avoid that by just mounting disks on the external bus.  But
I'll try to figure out other avenuse before going to the trouble of
doing another install on the external disk.

> I'm not sure about the precise granularity of locking (2.2 or
> 2.4 kernel? I forgot what you said about kernel versions) but I doubt
> there is a per-hostadapter lock even in 2.4.

This happens with both 2.2 and 2.4.

> So what I'm saying is: rather try logging to serial console or network in
> order to see if there's any output produced (it might help to stop syslogd
> and klogd altogether and only use serial console) before you go to the
> effort to set up a copy of the system on another bus.

The thing that makes me a little bit pessimistic about this is that I
don't get any log messages even when I'm logged in on the console.
Maybe I need to change my syslogd setup to log everything to the console
(which virtual console will it get logged to, or can I specify that?)
and not to any files so syslogd won't freeze when SCSI goes?  Is there
any reason to believe that I'd be able to get useful output over the
network or serial port when I can't on my screen?  (Note that the whole
system doesn't lock up immediately, especially with swap turned off, but
any attempts to access filesystems make things die quickly.)

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
