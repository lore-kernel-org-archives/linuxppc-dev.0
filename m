Message-ID: <3F02060A.8010402@mvista.com>
Date: Tue, 01 Jul 2003 17:07:06 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large initrd and arch/ppc/boot/simple Question
References: <20030701162944.E20876@borg.org> <20030701175117.G20876@borg.org>
In-Reply-To: <20030701175117.G20876@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is based on my past observations, and may not reflect the current
version of 2.4.x.

Yes, you can definatly kill a kernel by asking for too much memory.
This is especially true if you do not have swap enabled, which in my
experience is rather rare on embedded systems.  I THINK there is a
mechanism that you can turn off over commit of memory which will allow
you to kill processors requesting the memory that doesn't exist.  The
only problem with that is depending on how you do this overcommit
control you have to accoutn for COW pages, and other things that may
blow you out.

The best you can hope for is "Under normal circumstances my system
should use this much memory, I will give it X * 1.5 (or some other
reasonable amount)."

This is something that needs to be worked out between the hardware and
software folks, unfortunatly it rarely seems to be and you get bogus
"This product WILL run under 8MB of ram no matter what requirements...
ohh and did I mention it needs to have 16 MB worth of ramdisk?"   heh

So in short, no the kernel shouldn't oops when it runs out of memory.
However what is the "correct" thing to do has been debated many times,
and depending on the application returning ENOMEM may be appropriate,
crashing (to cause a reboot) may be appriopriate or a whole host of
other things like killing off the offending process (or a lower priority
process even).  It all comes down to system requirements.

--Mark

Kent Borg wrote:
> Looking more, it seems that we are (at minimum) killing the kernel by
> asking for too much memory.  We are seeing whether we can reproduce
> that with a simpler program.
>
> -kb
>
>
> In the meantime, here is some output of and about our crash:
>
>   $ size bigapp.strip
>      text	   data	    bss	    dec	    hex	filename
>   7465252	  97296	 401844	7964392	 7986e8	bigapp.strip
>   $ size /tftpboot/zImage.initrd.elf
>      text	   data	    bss	    dec	    hex	filename
>     24896	6856704	  12732	6894332	 6932fc	/tftpboot/zImage.initrd.elf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
