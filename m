Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E841DDF65
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 05:20:35 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63JKHjt023190
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 15:20:17 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m63JK7dn189414
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 15:20:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m63JK6dv025243
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 15:20:06 -0400
Date: Thu, 3 Jul 2008 15:16:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re: Support for low power mode for powerpc processors
Message-ID: <20080703151646.511ce9b6@zod.rchland.ibm.com>
In-Reply-To: <49c0ff980807031154qa5541c7k7065bdc1054d686a@mail.gmail.com>
References: <49c0ff980807031154qa5541c7k7065bdc1054d686a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 3 Jul 2008 11:54:33 -0700
"prodyut hazarika" <prodyuth@gmail.com> wrote:

> Hi all,
> I would like to know whether Linux on PowerPC puts the processor on
> low power mode during idle state. Most PowerPC processors support a
> low power mode. I am looking to add support for low-power mode in
> Linux for AMCC 4xx processors.
> 
> My questions are the following:
> 1) Is tickless kernel integrated into the PowerPC tree?
> 2) Does Linux kernel puts the processor in low power mode if cpu is
> idle, and takes it out of that state on wakeup (triggered by
> interrupt/WOL etc)?
> 
> Any suggestions/comments would be welcome.

The 4xx cores themselves are designed to have power savings without
explicit software management.  The only sort of "NAP/DOZE" possible
from software on them is to use the Wait Enable state in the idle loop
to stall the CPU pipelines and wait for an exception.  This is already
done in more recent kernels, and it doesn't particularly save a lot of
power as the clocks and other logic are still all active.

Some chips may have an external clock and power management ASIC that
can be leverage but it will be SoC specific.  You could start there for
a particular board.

josh
