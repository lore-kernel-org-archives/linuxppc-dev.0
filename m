Message-ID: <3A6331BF.FB53A3FF@mvista.com>
Date: Mon, 15 Jan 2001 12:22:07 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Timothy Ritchey <tritchey@vacuumgenesis.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kswapd Oops
References: <3A625423.E0F6C9AC@vacuumgenesis.com> <3A628C9B.489E401A@mvista.com> <3A633075.5952B4C0@vacuumgenesis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Timothy Ritchey wrote:

> so far, this is the only version I have gotten to boot completely.

Ahhh.....

> ...... I
> have tried the montavista 2.2.14-1.2.2_1 kernel, but it crashes after
> loading the compressed ramdisk image with:

That kernel _works_.  If you can't boot that one, you better start
looking elsewhere for problems.

> It is a B5 revision

Are you including the software work arounds for the CPU6 silicon
errata?

> is enabled, and hang the kernel completely. 2) Sometimes it occurs right
> after the:
>
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: enabling 8 loop devices
> Oops: kernel access of bad area, sig: 11

Yeah, you have some hardware problems.  I suspect if you disable
caches or only run with data cache in writethrough mode you will
make more progress.

The Linux kernel does things you just can't without some pretty
sophsticated diagnostics.  With the MMU and caches enabled, plus
the CPM running I/O in parallel, you will generate worst case bus
timing to the DRAM that you have never seen before.  The problems
you see are quite typical of a memory controller configuration
or a processor/memory board layout problem.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
