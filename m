Date: Thu, 25 Jan 2001 14:02:02 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Rabeeh Khoury <rabeeh@galileo.co.il>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Max bus
In-Reply-To: <3A701C2C.60008@galileo.co.il>
Message-ID: <Pine.HPX.4.10.10101251343100.22074-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi,

On Thu, 25 Jan 2001, Rabeeh Khoury wrote:

> I'm trying MAX Bus protocol on Galileo evaluation board and I'm getting
> the following errors -
>
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 176k init
> floating point used in kernel (task=c022e000, pc=944)
> floating point used in kernel (task=c022e000, pc=c01e1c60)
> floating point used in kernel (task=c022e000, pc=944)
> floating point used in kernel (task=c022e000, pc=c01e1c60)
> floating point used in kernel (task=c022e000, pc=944)
> floating point used in kernel (task=c022e000, pc=c01e1c60)
> floating point used in kernel (task=c022e000, pc=944)
> floating point used in kernel (task=c022e000, pc=c01e1c60)
> floating point used in kernel (task=c022e000, pc=944)
> floating point used in kernel (task=c022e000, pc=c01e1c60)
> floating point used in kernel (task=c022e000, pc=944)
> floating point used in kernel (task=c022e000, pc=c01e1c60)
> floating point used in kernel (task=c01a0ff0, pc=944)
> NIP: 00000F28 XER: 00000000 LR: C000638C REGS: c01a2eb0 TRAP: 0400
> floating point used in kernel (task=c01a0ff0, pc=944)

Welcome to the marvelous world of hardware problems ;-) Hints:

1) these are all at the same address, probably in a loop.

2) there are no fp instructions in the kernel except for FPU context
save/restore, which previously set the MSR FP bit to avoid the exception.

3) one of the characteristics of floating point instructions is that the
most signficant few bits are all ones.

Conclusion: the timing of your RAM is too aggressive. You've got corrupt
data in the cache and it won't disappear that easily. Just try to print
the opcode of the instruction that NIP is pointing to, flush the cache
at this address, try to print it again.

> After these errors the kernel hangs !
>
> Does Linux support MAX Bus ?

This is absolutely transparent as long as the chipset is correctly
configured.

> Should I add new flags to the compiler ?

Will never help, corrupt data is corrupt data. OTOH, if you have the
possibility, enable ECC on the RAM, parity on the busses, and get the
machine checks and dump the relevant info from the chipset if you can.

	Regards,
	Gabriel.

P.S: there are other possibilities, data at some cache level which has
become incoherent due to a bug, or a wild pointer which has overwrittem
kenel code. But if the difference only happens by switching bus
protocols, these can't be the reason.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
