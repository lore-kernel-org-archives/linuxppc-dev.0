From: "Jim Lewis" <jlewis@mvista.com>
To: "David C. Chiu" <dchiu@ariodata.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Memory Pre-allocation (mem=xxx)
Date: Fri, 22 Feb 2002 19:54:32 -0600
Message-ID: <NDBBLNMCOLBBHLKBOLFEGEKHDLAA.jlewis@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Another way to allocate physically contiguous memory in 2.4 is to use
the alloc_bootmem function. It has to be called during kernel
initialization, though.
-Jim Lewis

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of David C.
> Chiu
> Sent: Friday, February 22, 2002 6:43 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Memory Pre-allocation (mem=xxx)
>
>
>
> We're working on a project that requires a two megabytes block of
> contiguous memory in kernel space. Although it is well
> documented that
> memory can be reserved by using mem=xx arguments during
> boot time, it is
> unclear (to me) as to how a driver can automatically detect
> the size of
> the said reserved block.
>
> At this moment I am 'cheating' by inserting a global
> variable to save a
> copy of total_memory before it gets replaced by __max_memory in
> arch/ppc/mm/init.c so that the saved total_memory
> (containing the real
> physical memory size passed in from boot block) is available to my
> driver. But I can't help but to feel there has to be a better way to
> determine the reserved buffer size. Is there something else
> that will do
> this without having to modify the kernel?
>
> Any comment is appreciated.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
