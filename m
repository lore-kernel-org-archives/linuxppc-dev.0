Date: Fri, 26 Jan 2001 22:32:35 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Amit Chaudhary <amitc@brocade.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <20010126160441.B16573@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Unfortunately, since /var lives on the same bus, this doesn't help.  But
> > > I'll try setting up a minimal linux installation on the other SCSI bus
> > > and burning a CD, and will hopefully then find something out.
> >
> > Even with /var living on a different bus, locking the MESH bus solid
> > probably means you have all of the SCSI midlevel and perhaps the whole VFS
> > locked up.
>
> Hmm, I wouldn't expect the VFS to be involved because this is using the
> SCSI generic driver and presumably not going through the VFS at all.
> Ah, I see, you mean if the SCSI subsystem locks, then the next time VFS
> was waiting for the SCSI bus it might just stay locked forever.  Still,

Right. And are you sure the sg driver isn't going through VFS (sharing
buffers with the rest of the system)?

> if it turned out that the other SCSI bus was OK but the VFS had locked
> up, I could avoid that by just mounting disks on the external bus.  But

As long as the sg driver doesn't touch VFS buffers at all, not even for
copying data from user space, I think you should be safe.

> This happens with both 2.2 and 2.4.

So more lock granularity in 2.4 didn't help :-(


> > So what I'm saying is: rather try logging to serial console or network in
> > order to see if there's any output produced (it might help to stop syslogd
> > and klogd altogether and only use serial console) before you go to the
> > effort to set up a copy of the system on another bus.
>
> The thing that makes me a little bit pessimistic about this is that I
> don't get any log messages even when I'm logged in on the console.

I think that's a different story: these messages would be posted to the
console by syslogd which might already hang. Depends on your syslog.conf.

Serial console is different in that it doesn't just write log messages to
the kernel log buffer and wait for klogd/syslogd to pick them up, but
instead write the messages out to the serial port without delay.

> Maybe I need to change my syslogd setup to log everything to the console
> (which virtual console will it get logged to, or can I specify that?)

# same to a separate screen
*.info;mail.none;authpriv.none;local0.none		/dev/tty7

is what keeps a not-too-cluttered log (copy of /var/log/messages) on tty7
of our server. kern.notice to some tty would probably be enough for you.

> and not to any files so syslogd won't freeze when SCSI goes?  Is there

So put just that one line redirecting log output to /dev/tty7 into
syslog.conf temporarily and kill -1 syslogd before starting the test.

> any reason to believe that I'd be able to get useful output over the
> network or serial port when I can't on my screen?  (Note that the whole
> system doesn't lock up immediately, especially with swap turned off, but
> any attempts to access filesystems make things die quickly.)

The system not locking up immediately makes me hope serial console will
still work and show messages if there are any generated. At least
interrupts aren't blocked yet. syslog to a log host might also still work.
But output to console should also still work ...

Have you tried to increase the kernel log level (dmesg -n 7 should be the
max level you can set from user space) to make sure every kernel message
goes to the current console directly? If that doesn't work, but you can
still use the keyboard, it's time to hack a new sysrq option that dumps
the current MESH status and so on. Or toggles logging in the MESH driver.
You might be able to use xmon as well - I've never tried hard enough to
understand xmon.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
