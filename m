From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15742.33086.511345.798962@argo.ozlabs.ibm.com>
Date: Wed, 11 Sep 2002 09:33:18 +1000 (EST)
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Caching in the MPC107
In-Reply-To: <1031581408.30396.81.camel@newt>
References: <1031581408.30396.81.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox writes:

> I've just been debugging an interesting problem with a new board that
> uses a MPC107 bridge with a 7445 processor. The symptoms were that the
> ethernet device never saw updated transmit descriptors unless another
> bus master was active in the system.
>
> The underlying problem is that linuxppc_2_4_devel only sets the
> _PAGE_COHERENT flag on memory when CONFIG_SMP is enabled. This doesn't
> allow for the fact that the MPC107 contains caches. The cache causing
> the problem was the PCI-to-Local-Memory-Read-Buffer (PCMRB), which can
> store two 32-byte cache lines.

Interesting.  You are of course quite correct in saying that if there
are other things in the system (besides the CPU) that can access and
cache memory, then we need to set the M (== _PAGE_COHERENT) bit in the
PTEs for at least any memory that is going to be accessed by those
other agents.

> My current thinking is to produce a patch which introduces a new option:
> CONFIG_CACHING_HOSTBRIDGE which boards combining the MPC107 and the
> MPC7450 can set. This will probably be needed for Motorola's Valis or
> Gyrus PMCs.

Hmmm, it would be better to have the code just do the right thing on
each platform.  We could for instance have platform_init set a flag to
say "we have a caching hostbridge" and have mapin_ram and
bat_mapin_ram set the M bit if that flag is set.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
