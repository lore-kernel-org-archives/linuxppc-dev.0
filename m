Date: Thu, 12 Sep 2002 10:05:31 -0700
From: Matt Porter <porter@cox.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Todd Poynor <tpoynor@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
Message-ID: <20020912100531.A8552@home.com>
References: <3D7FB97B.9060301@mvista.com> <20020912032640.GA32156@zax> <20020912142945.GC13840@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020912142945.GC13840@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Sep 12, 2002 at 07:29:45AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 12, 2002 at 07:29:45AM -0700, Tom Rini wrote:
> IIRC, to fix the interrupt context bit, we need something like the
> following, which was Paul's idea, and he said he would talk to Dave M.
> about it.  Did anything ever happen there?

<snip>

In addition to that, you need to scrub the entire consistent_alloc
path...that includes map_page()->pte_alloc_kernel() which may
do a GFP_KERNEL allocation.

Then it's more complex yet with Book E's need to have those possible
page table allocations from the pinned TLB region.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
