To: linuxppc-dev@lists.linuxppc.org
Subject: Re: serial on lombard 
In-reply-to: Your message of "Thu, 14 Oct 1999 14:31:51 +0300." <3805BF27.1944652E@fadata.bg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Oct 1999 13:35:48 +0100
Message-ID: <4461.939904548@MessagingDirect.com>
From: Chris Ridd <Chris.Ridd@messagingdirect.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Oct 1999 14:31:51 +0300, Momchil Velikov wrote:
> 
> Michael Schmitz wrote:
> > 
> > > alarm(0x2, 0x7ffff7b4, 0, 0x8, 0x7f7f7f7f) = 0
> > > open("/dev/ttyS0", O_RDWR|O_NONBLOCK)   = 3
> > > --- SIGALRM (Alarm clock) ---
> > > alarm(0, 0x1, 0, 0x8, 0x7f7f7f7f)       = 0
> > > rt_sigaction(0xe, 0x7ffff698, 0x7ffff728, 0x8) = 0
> > > write(2, "minicom: cannot open /dev/ttyS0:"..., 59minicom: cannot open /dev/ttyS0: No such file or directory
> > > ) = 59
> > 
> > The port blocks on open, and you get a timeout.
> 
> But there is O_NONBLOCK, and according to POSIX, 
> " ... if O_NONBLOCK flags is set or if CLOCAL has been set,
>   the open() function shall return immediately without
>   waiting for the connection."
> 
> Note that this is the/a way to set CLOCAL -- open the device with O_NONBLOCK
> and then tcsetattr() or whatever.

The open on /dev/ttyS0 returns a valid fd, so it is succeeding. As BenH 
pointed out, the problem is the SIGALRM ringing which causes Minicom to 
erroneously think it couldn't open the device.

Chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
