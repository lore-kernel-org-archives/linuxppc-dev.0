MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 8260 CPM DP ram free function
Date: Fri, 21 May 2004 14:34:08 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DADF@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> First, when this has come up in the past, the first question
> is why is this useful, given that with the hardware and
> peripherals in question, loadable drivers aren't really
> useful (and don't shoot the messenger please).

Right now I mainly use it to debug a driver, which would run out of host
ram when I reloaded it

> Second, you removed the EXPORT_SYMBOL for the old alloc, but
> I didn't see quickly how a module would make use of the new
> infrastructure since there weren't any new EXPORT_SYMBOLs.

This is because I did my patch against 2.6.5, and all the EXPORT sympols
are in arch/ppc/kernel/ppc_ksyms.c
and not in commprocs.c

In ppc_ksyms.c I have:
extern uint m8260_cpm_dpalloc(uint size, uint align);
extern uint m8260_cpm_hostalloc(uint size, uint align);
extern uint m8260_cpm_hostfree(uint ptr);
extern uint m8260_cpm_dpfree(uint ptr);

EXPORT_SYMBOL(m8260_cpm_dpalloc);
EXPORT_SYMBOL(m8260_cpm_hostalloc);
EXPORT_SYMBOL(m8260_cpm_dpfree);
EXPORT_SYMBOL(m8260_cpm_hostfree);


>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
