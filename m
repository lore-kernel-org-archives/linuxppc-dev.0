Subject: Re: Oops on sleep w/2.6.4 tipb 1ghz
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Bryson <david@tsumego.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040312084439.GA6929@heliosphan.futuretel.com>
References: <20040312084439.GA6929@heliosphan.futuretel.com>
Content-Type: text/plain
Message-Id: <1079150842.1967.77.camel@gaston>
Mime-Version: 1.0
Date: Sat, 13 Mar 2004 15:07:22 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-03-12 at 19:44, David Bryson wrote:
> Got an oops on sleep, this is entirely repeatable.  This is me writing
> down the oops then typing it in, so there might be some discrepancies ;-)
>
> hdc: start_power_step (step:0)
> hdc: completing PM request, suspend
> hda: start_power_step (step:0)
> hda: start_power_step (step:1)
> hda: complete_power_step (step:1, stat:50, err:0)
> hda: completing PM request, suspend
> Oops: kernel access of bad area, sig 11 [#1]
> NIP: C00B8388 LR: C00b83A4 SP: EF433DA0 REGS: ef433cf0 TRAP: 0301 Nottainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000049, DSISR: 40000000
> TASK: ef4fc000[125] 'devfsd' Last syscall: 83
> GPR00: 00000002 EF433DA0 EF4FC000 C11B9A0D EDBF8F7C 00000005 C1029A0D
> EDBF8F24
> GPR08: EDBF4F1C C1144A0D EDBF8F0C C0270000 24002422
> Call trace:
> [c00b925c] devfs_lookup +0x58/0x2de
> [c0068fa8] __lookup_has +0xe4/0x17e
> [c00690ac] lookup_create +0xa4/0x120
> [c000560c] ret_from_syscall +0x0/0x04c
>
> looks like the oops is somewhere in the bowels of devfs... any hints
> on what might have bothered the kernel ?

Not at this point, I'll have a look. Looks like a NULL ptr deref,
I suspect a devfs bug, though devfs is mostly obsolete by now, so
I don't normally use it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
