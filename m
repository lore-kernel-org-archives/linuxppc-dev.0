Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFCA@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: uncached user space mapping with mmap() ???
Date: Mon, 8 Mar 2004 11:25:06 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> When I map only the the GRAM I get a throughput of
>
> IoremapTest...        8.0 s      => 2049.4 kW/s

Talking about Retries count, the higher the better.
Getting 8 seconds is okay, but not less to have good average result.
Perform several times the IoremapTest to check for noise consistency.
To compare it with some other IoremapTest's, do it in identical (at best)
environement, for example at fresh bootup. But you must know all this
already.

To maximize thruput, you'll have to unroll the loop if your compiler
is not smart enough to do it. Here is an unroll 4 (provided Size%4=0):

	while (Retries--) {
		for (i = 0; i < Size; i+=4) {
			pData[i]   = *p;
			pData[i+1] = *p;
			pData[i+2] = *p;
			pData[i+3] = *p;
		}
	}

Unroll the loop 8 times or 16 times to have better result (minimize branch).
Then compare it to the spec of your bus bandwidth and memory bandwidth.

If you're chasing after high perf, it's always good to disassemble
the code to understand it (compile with -g and then objdump -S).

> But when I map the whole address range
>
>	p = (unsigned short *)
>		ioremap(BASE, imcdevif_iosize);
>
> and move the pointer
>
>	p += GRAM;
>
> before entering the test loop I only get
>
> IoremapTest...        8.4 s      => 1944.8 kW/s

This is only ~5% thruput variation afterall, so make sure you perform
serveral time the IoremapTest to check for consistency.

In the case you're moving the pointer *in* in the test loop,
the IoremapTest will also be measuring the minor page faults.

If this is an issue for you, you'll have to tweak the kernel
and use some hugetlb entries. Please ppc gurus, correct me if I'm wrong.

Note: if the external SDRAM is not changed while the CPU's accessing it,
you'd better access it throught the cache, and use prefetches.
This won't help the page faults, but you'll gain burst accesses,
and you may even access it directly through structures pointers, etc..
You'll need some cache invalidating functions before the copy/access.
For more on the topic, read any good paper on non-cache coherent memory.

> Is it always better to map only the small part I am going to use?

The bigger the mmap, the better, and the "lesser" entries in page table
there will be.
Note: this would make also a good victim for the Out-Of-Memory killer :)


Regards,
Stéphane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
