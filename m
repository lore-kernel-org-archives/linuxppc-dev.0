Date: Sat, 27 Jan 2001 16:31:15 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Amit Chaudhary <amitc@brocade.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010127163115.B2695@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Fri, Jan 26, 2001 at 10:32:35PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 26, 2001 at 10:32:35PM +0100, Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de> wrote:
> > Hmm, I wouldn't expect the VFS to be involved because this is using the
> > SCSI generic driver and presumably not going through the VFS at all.
> > Ah, I see, you mean if the SCSI subsystem locks, then the next time VFS
> > was waiting for the SCSI bus it might just stay locked forever.  Still,
>
> Right. And are you sure the sg driver isn't going through VFS (sharing
> buffers with the rest of the system)?

Um, no idea.  I'd believe you if you said that it was.  :-)

> > The thing that makes me a little bit pessimistic about this is that I
> > don't get any log messages even when I'm logged in on the console.
>
> I think that's a different story: these messages would be posted to the
> console by syslogd which might already hang. Depends on your syslog.conf.
>
> Serial console is different in that it doesn't just write log messages to
> the kernel log buffer and wait for klogd/syslogd to pick them up, but
> instead write the messages out to the serial port without delay.

How do I set it up to log to a serial console?  (I may not be able to do
this for a few days until I borrow a friend's laptop, though.)

> > Maybe I need to change my syslogd setup to log everything to the console
> > (which virtual console will it get logged to, or can I specify that?)
>
> # same to a separate screen
> *.info;mail.none;authpriv.none;local0.none		/dev/tty7
>
> is what keeps a not-too-cluttered log (copy of /var/log/messages) on tty7
> of our server. kern.notice to some tty would probably be enough for you.
>
> > and not to any files so syslogd won't freeze when SCSI goes?  Is there
>
> So put just that one line redirecting log output to /dev/tty7 into
> syslog.conf temporarily and kill -1 syslogd before starting the test.

I'll try this variation in a few minutes.

> Have you tried to increase the kernel log level (dmesg -n 7 should be the
> max level you can set from user space) to make sure every kernel message
> goes to the current console directly?

I did "dmesg -n 8" since I forgot the number and didn't have your email
right in front of me, and it accepted that.  Does dmesg just tell the
kernel what to send to syslogd, or does it tell it what to send to the
current console directly?  If the former, how does this work on a
per-console basis?  If the latter, why would a serial console have a
better chance of working?

> If that doesn't work, but you can still use the keyboard, it's time to
> hack a new sysrq option that dumps the current MESH status and so on.
> Or toggles logging in the MESH driver.  You might be able to use xmon
> as well - I've never tried hard enough to understand xmon.

Hmm, I'll try to look into this.  If anyone has any pointers to
information about xmon, please let me know.  Do I need to use it over a
serial line?

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
