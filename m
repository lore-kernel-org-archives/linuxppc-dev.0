Date: Fri, 3 May 2002 10:14:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd in 2.4.19
Message-ID: <20020503001413.GT9043@zax>
References: <D769D33A5A2FBD4381E1F6030D28DBFA01029C92@hq-ex-6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D769D33A5A2FBD4381E1F6030D28DBFA01029C92@hq-ex-6>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 02, 2002 at 10:13:30AM -0700, Brian Kuschak wrote:
>
> > I want to use pivot_root, so I don't use the special /linuxrc running
> > code.  Instead I use "init=/linuxrc" as part of the command line.  If
> > you do this your first script should work fine (pivot follwed by
> > chroot).  But to be honest, I don't chroot.  I don't think it's
> > necessary.
>
> Using init=/linuxrc allows my first script to work.
>
> However, it's a bit restrictive:  if I want to override the usual boot
> sequence and get the kernel to mount the real root and drop into a shell I
> can't use this method.  With the 'old-style' script, I can set
> "init=/bin/bash".  These get applied AFTER /linuxrc terminates.  If I use
> your method, I can't do that.

Remember that any kernel command line options that the kernel doesn't
recognize get passed to init - as environment variables if they
contain a "=" and as command line arguments otherwise.  So it's fairly
easy to invent a new parameter to control the "real" init and have
your linuxrc interpret it and act accordingly.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
