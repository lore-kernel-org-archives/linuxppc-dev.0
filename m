Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMN3M3NWGzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:04:13 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [RFC][PATCH] powerpc/64s: optimise syscall entry with relon
 hypercalls
Date: Mon, 13 Feb 2017 11:04:06 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0284DFE@AcuExch.aculab.com>
References: <20170210182304.12955-1-npiggin@gmail.com>
In-Reply-To: <20170210182304.12955-1-npiggin@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin
> Sent: 10 February 2017 18:23
> After bc3551257a ("powerpc/64: Allow for relocation-on interrupts from
> guest to host"), a getppid() system call goes from 307 cycles to 358
> cycles (+17%). This is due significantly to the scratch SPR used by the
> hypercall.
>=20
> It turns out there are a some volatile registers common to both system
> call and hypercall (in particular, r12, cr0, ctr), which can be used to
> avoid the SPR and some other overheads for the system call case. This
> brings getppid to 320 cycles (+4%).
...
> + * syscall register convention is in Documentation/powerpc/syscall64-abi=
.txt
> + *
> + * For hypercalls, the register convention is as follows:
> + * r0 volatile
> + * r1-2 nonvolatile
> + * r3 volatile parameter and return value for status
> + * r4-r10 volatile input and output value
> + * r11 volatile hypercall number and output value
> + * r12 volatile
> + * r13-r31 nonvolatile
> + * LR nonvolatile
> + * CTR volatile
> + * XER volatile
> + * CR0-1 CR5-7 volatile
> + * CR2-4 nonvolatile
> + * Other registers nonvolatile
> + *
> + * The intersection of volatile registers that don't contain possible
> + * inputs is: r12, cr0, xer, ctr. We may use these as scratch regs
> + * upon entry without saving.

Except that they must surely be set to some known value on exit in order
to avoid leaking information to the guest.

	David
