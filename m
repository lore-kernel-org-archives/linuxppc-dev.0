Message-ID: <385714D8.8AD74656@netx4.com>
Date: Tue, 14 Dec 1999 23:11:04 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <3856C0D7.4E1404C9@ctam.com.au> <385703C2.AA4298E7@netx4.com> <38570544.476D42C9@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> What I don't understand is why it starts to boot (ie. uncompresses into
> memory) but then nothing happens.


Could be lots of things.  I hope you can reset your board
without losing memory.  If so, find the address of 'log_buf'
in the System.map and dump it out (convert the virtual address
to physical by masking the upper few bits).  This is the staging
area for kernel printk messages, and lots of information is
here before the console is enabled.

> ....  Are there things that the kernel expects
> to be setup besides the flash/dram memory ?


Considering you are doing your own UPM, the Linux kernel will
find lots of timing errors with it.  It enables the MMU and
caches very early, so the bus timing will see something new
for the first time.  I hope you are peforming the proper cache
initialization sequence and setting all of the necessary
processor registers in the boot rom.

You can disable the caches in arch/ppc/kernel/head.S.  Try that.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
