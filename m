Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22372DE4B5
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 04:59:59 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBAHxuM7013418
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 12:59:56 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBAHxuOb116002
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 10:59:56 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBAHxuYk018275
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 10:59:56 -0700
Date: Mon, 10 Dec 2007 11:59:26 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/25] powerpc: Reworking machine check handling and Fix
	440/440A
Message-ID: <20071210115926.20278214@weaponx>
In-Reply-To: <20071206080114.CDB13DDE33@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080114.CDB13DDE33@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 19:00:03 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This adds a cputable function pointer for the CPU-side machine
> check handling. The semantic is still the same as the old one,
> the one in ppc_md. overrides the one in cputable, though
> ultimately we'll want to change that so the CPU gets first.
> 
> This removes CONFIG_440A which was a problem for multiplatform
> kernels and instead fixes up the IVOR at runtime from a setup_cpu
> function. The "A" version of the machine check also tweaks the
> regs->trap value to differenciate the 2 versions at the C level.

This breaks ARCH=ppc builds.  Unfortunately, that tree shares the
cputable.[ch] files, but has it's own traps.c.  Which means you get
lots of nice undefined references like below for example:

arch/powerpc/kernel/built-in.o:(.init.data+0x44): undefined reference to `machine_check_4xx'
arch/powerpc/kernel/built-in.o:(.init.data+0x8c): undefined reference to `machine_check_4xx'
arch/powerpc/kernel/built-in.o:(.init.data+0xd4): undefined reference to `machine_check_4xx'

Because the cputable entries for the processors are setting the .machine_check function and it's never built.

I'm not sure which would be easier, making arch/ppc use traps.c from arch/powerpc, or adding similar functionality there.

josh
