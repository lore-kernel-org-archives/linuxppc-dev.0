Mime-Version: 1.0
Message-Id: <p04330100b63c8a1a240a@[192.168.0.1]>
In-Reply-To: <p04330100b63b9e07574a@[192.168.0.1]>
References: <200011060712.IAA00775@piglet.grunz.lu>
 <p04330100b63b9e07574a@[192.168.0.1]>
Date: Sat, 18 Nov 2000 15:03:14 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18pre21?
Cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


in my original post, I said:

>but I am highly suspicious of
>the code involving the 2940UW card in the box. The -only- drives I
>have are 2 9G atlases connected to the 2940. All 2.2.17 kernels I've
>tried work fine. OTOH, every linux-pmac-stable 2.2.18preX kernel
>panics just as it is beginning to register (poll? discover?) the SCSI
>devices, at the same place where 2.2.17 properly recognizes the 2
>drives and the 2940.
>
>From what little sense I can make of it, it sure
>looks like the panic has something to do with the aic7xxx code, or
>related code. Roughly speaking, just after the fd0 (floppy) message
>appears in the boot, I get :
>
>Machine check in kernel mode
>Caused by (from srr1): Unknown values in srr1
><debug info>
>[kernel panic]

This is the same place in 2.2.17 where the 2940 card and my dual 9G
atlas drives are normally and successfully probed/discovered. Here is
the backtrace and the relevant sections from the System.map. I've
included the address before the backtrace value to the address after
the backtrace value, inclusive.

C000F508:
	c000f4f4 T ioremap
	c000f518 T __ioremap

C013CAC8:
	c013b454 t aic7xxx_load_seeprom
	c013c444 T aic7xxx_detect
	c013d9f8 t aic7xxx_allocate_negotiation_command

C01FABC0:
	c01fab0c T scsi_init
	c01fad08 T st_setup

C01FA8EC:
	c01fa840 T scsi_luns_setup
	c01fa884 T scsi_dev_init
	c01fab0c T scsi_init		[yes, same as above]

C01F6058:
	c01f6038 T device_setup
	c01f61ec T rd_init

C01EC9E4:
	c01ec910 t do_basic_setup
	c01ecafc T pmac_display_supported

C0004434:
	c0004420 t init
	c00045c8 T machine_restart

C00095EC:						[last in backtrace]
	c00095c0 T kernel_thread
	c00095f8 T idle


I hope I've presented the info in a way that can be used. Just an
answer or some clues would be helpful; what would be fantastic would
be a mini-tutorial on how to use this info to figure it out for
myself :-)

Looking at the above, there appears to be no reason to believe that
there was any problem in the scsi initialization? If so, why then did
I never get the boot messages about the 2940 and scsi devices?

Is "machine_restart" where the kernel panic says it will restart in
180 seconds?

As you may have guessed, I'm not in front of the box at this moment
to check it directly, but can I do a search through the source to
find, for example, "aic7xxx_detect"?

It almost looks like it went -through- the scsi setup fine and went
on to something else related to the display? Or is it possible that
my problems started all the way back at ioremap and finally caught up
with me?



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
