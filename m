Date: Wed, 2 Jul 2003 12:54:05 -0400
From: Kent Borg <kentborg@borg.org>
To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large initrd and arch/ppc/boot/simple Question
Message-ID: <20030702125405.E27205@borg.org>
References: <20030701162944.E20876@borg.org> <20030701175117.G20876@borg.org> <3F02060A.8010402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F02060A.8010402@mvista.com>; from fray@mvista.com on Tue, Jul 01, 2003 at 05:07:06PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 01, 2003 at 05:07:06PM -0500, Mark Hatle wrote:
> Yes, you can definatly kill a kernel by asking for too much memory.

I wrote a simple test program that malloc()s a 64KB block, fills it
with data, malloc()s another, fills it, etc.

If I run it in the background and queue up a bunch of copies in bash's
input buffer, the kernel quickly grinds to a near halt as the kernel
starts scrounging for memory and kills these processes one at a time.
I can get a ps to eventually run, showing as many as two dozen of
these hungry programs--though it is a little like astronomy of distant
objects: by the time ps completes the processes listed have already
been long ago announced in the console as killed.

And once they have all run and been killed, the system is again
responsive and appears to be happy.  So the OOM killer in 2.4 works in
this simple case, multiplied.

The case of our big program dying is certainly more complicated.  We
are looking to see what it is using/whether it can be told to restrain
itself.


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
