Message-ID: <3DAAFB50.9090509@mvista.com>
Date: Mon, 14 Oct 2002 12:13:52 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC
References: <Pine.LNX.4.33.0210141138290.24959-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bret Indrelee wrote:
> We are trying to wade our way through the various processor choices and
> options available for PPC on Linux.
>
> One of our requirements is to be able to run the same binary image across
> a range of systems. The image can not change just because the processor
> does.
>
> We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC III.

(I am ONLY speaking of userspace! .. each system will require a custom kernel)

The 7xx (as well as 74xx if you avoid altivec) and 82xx are all compatable in
userspace.  Those CPU families floating point units, the same cache line size
and other commonalities.

The 405 does not have an FPU.. If you enable the in kernel floating point
emulator it will then be capable of running the same binaries as above.. but do
to performance, personal preferance and other reasons I do not recommend running
a non FPU machine with FPU emulation unless you need to.

(Since we're on the topic) the PowerPC 403, and 8xx lines are binary compatable
with each other.  Similar to the 405 they lack an FPU, but they also use only
half the cacheline size of the above CPUs.  This (potentially) makes the libc
incompatable, and many optimizations may not work as intended.

There is still a question on wether or not the Book E stuff will be user space
compatable with the current 7xx style binaries.  I wouldn't hold my breath.. :P

If I was building a range of systems that required varying PowerPC CPUs with a
common userspace I would stick to the 82xx/7xx/74xx families today.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
