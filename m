Cc: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <39660C4A.8DE0898B@lucent.com>
Date: Fri, 07 Jul 2000 11:58:50 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Gong Zhuo <gongzhuo@163.net>
Subject: Re: How to debug the linux kernel?
References: <000901bfe7f2$25d23be0$4607a8c0@LocalHost>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gong Zhuo wrote:
>   If I want to change the kernel of linux , how can I debug the kernel ? Any
> kind of tools can I use?

This may be a different problem than what you are asking about. THis
is how I got Linux working on our proprietary PowerPC board.

I had the problem that initially I had _NO_ I/O devices whatsoever;
the only thing I could do was read and write on-board memory from
the host (my system is a PCI board which plugs into a PC running
Linux). So I could load the Linux kernel and an initrd image, and
start it executing. I of course wrote a serial I/O and console
driver with corresponding host-side driver, but they were undebugged
also....

I mocked-up versions of my console driver using the proprietary OS
we currently run on this board, and debugged both the console driver
and its host-side counterpart (along with the program and driver
used to download programs and boot the board). This covered ~95% of
that code. Then I compiled the driver into the Linux kernel and
started on that.

	This was the key step, IMHO -- without a known-working
	console driver it would be VERY difficult to know when
	Linux got to the point of doing a printk().

Initially I had to get the Linux kernel to thread its way through
head.S, even though none of the configuration options correspond
at all to my hardware (so I created a CONFIG_LSPS....). This is well
before any printk() can work, of course. So I grep-ed head.S and
found two registers which were essentially unused, and set one to 0
as the first instruction of head.S. Then to trace the execution
through head.S I loaded the other with some unique constant and did
a stwu using the other one -- this overwrites the initial few words
of head.S with markers which essentially told me "I got here"; I
could dump memory from the host and see where it got. It took me
about four days of this until a printk() came out [half of that was
due to hardware problems unrelated to Linux -- I had unknowingly
used an early-revision of our board on which multi-beat memory
transactions did not work -- enabling the cache killed the program;
switching to a working board solved it]. Once the first printk()
appeared, in a few hours I had a bash prompt from the initrd image.

Then I wrote a network driver for the board and a corresponding
driver for the host. With printk() working this took me about
a week to get the first ping of the board, and another few days
to mount the root via NFS. I then built up a full root image from
the Suse PowerPC distribution beta CDROM I got as a door prize. I
now have 4 boards all running Linux quite well, including native
compilers.

	Note that this is the first point at which using gdb or
	some other debugging program would have worked for me.
	All the hard work came long before any such program could
	possibly be used....

All-in-all I spent about a month from the time I started seriously
to get Linux up on the board until I had it working reasonably
well. As you can tell, my method relied heavily on my experience
in writing and implementing our proprietary OS, and on my knowledge
and abilities as a low-level PowerPC assembly programmer. YMMV.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
