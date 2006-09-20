Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A881C67BB2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 09:57:20 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8KNvHZU029192
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 19:57:17 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8KNvHpH273254
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 17:57:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8KNvGLO001754
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 17:57:16 -0600
Date: Wed, 20 Sep 2006 18:57:16 -0500
To: "Peter N. Andreasen" <peterarbejde@gmail.com>
Subject: Re: Linux on custom Xilinx board with PPC405 hangs on boot
Message-ID: <20060920235716.GV29167@austin.ibm.com>
References: <36468a5c0609120706i6c7e32efke7d8901d9ce4ae9b@mail.gmail.com>
	<4506D7DE.9070800@ru.mvista.com>
	<36468a5c0609140713pb42f3f8n3578151b50a488f@mail.gmail.com>
	<36468a5c0609200216n753d69b0hdf8ff2cb53714f90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36468a5c0609200216n753d69b0hdf8ff2cb53714f90@mail.gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 20, 2006 at 11:16:53AM +0200, Peter N. Andreasen wrote:
> I have a custom Xilinx FPGA board which is similar to ML300 but uses
> Uartllite and does not have disk or display.
> When I start the Linux kernel I end up with an exception during the probe
> for Flash - I think.

Well, its not just "an exception" its a machine check.

> (after get_mtd_chip_driver) drivers/mtd/chips/chipreg.c: do_map_probe
> (start) drivers/mtd/chips/gen_probe.c: mtd_do_chip_probe
> (start) drivers/mtd/chips/gen_probe.c: genprobe_ident_chips
> Instruction machine check in kernel mode.
> Oops: machine check, sig: 7
> NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS: c04d9ce0 TRAP:
> 0200    Not tainted
> MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

Machine checks happen when some hunk of hardware is wired to the 
machine-check pin of the cpu chip, and that bit of hardware decides to
raise the wire.  I'd say the first step is to figure ou what hardware
is wired up this way, and what would make it unhappy enough to assert a
machine check.

SRR1 has bits that state what caused he machine check. -- e.g partity
error on data or address bus, "transfer error", or MC signal.

--linas
