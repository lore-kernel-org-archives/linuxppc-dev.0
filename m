Return-Path: <prodyuth@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by ozlabs.org (Postfix) with ESMTP id 1CFC7DE078
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 05:52:48 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so164589gvf.14
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 12:52:45 -0700 (PDT)
Message-ID: <49c0ff980807031252w2c01406dk63bd7d932db37720@mail.gmail.com>
Date: Thu, 3 Jul 2008 12:52:45 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: Support for low power mode for powerpc processors
In-Reply-To: <20080703151646.511ce9b6@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <49c0ff980807031154qa5541c7k7065bdc1054d686a@mail.gmail.com>
	<20080703151646.511ce9b6@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

But a lot of SoC like 440GT/EX support two modes of power save -
- Cut off power to other cores like PCIExpress/USB/MAC/UART etc
- Lower the CPU frequency

Is it possible to scale down CPU freq or cut off power to unused cores
while the CPU is idle? The ideal way would be that the SoC registers a
set of handlers to the Kernel that can power off/up the SoC components
or reduce/restore CPU frequency. Does any such framework exist for
PowerPC processors, because most PowerPC based SoC (FreeScale/AMCC
etc) support the above two modes of power save.

On 7/3/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Thu, 3 Jul 2008 11:54:33 -0700
> "prodyut hazarika" <prodyuth@gmail.com> wrote:
>
> > Hi all,
> > I would like to know whether Linux on PowerPC puts the processor on
> > low power mode during idle state. Most PowerPC processors support a
> > low power mode. I am looking to add support for low-power mode in
> > Linux for AMCC 4xx processors.
> >
> > My questions are the following:
> > 1) Is tickless kernel integrated into the PowerPC tree?
> > 2) Does Linux kernel puts the processor in low power mode if cpu is
> > idle, and takes it out of that state on wakeup (triggered by
> > interrupt/WOL etc)?
> >
> > Any suggestions/comments would be welcome.
>
> The 4xx cores themselves are designed to have power savings without
> explicit software management.  The only sort of "NAP/DOZE" possible
> from software on them is to use the Wait Enable state in the idle loop
> to stall the CPU pipelines and wait for an exception.  This is already
> done in more recent kernels, and it doesn't particularly save a lot of
> power as the clocks and other logic are still all active.
>
> Some chips may have an external clock and power management ASIC that
> can be leverage but it will be SoC specific.  You could start there for
> a particular board.
>
> josh
>
