Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58F8AB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 12:58:31 +1000 (EST)
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20100909025214.GA21846@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Sep 2010 12:58:16 +1000
Message-ID: <1284001096.6515.33.camel@pasglop>
Mime-Version: 1.0
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-08 at 19:52 -0700, Ira W. Snyder wrote:
> 
> I will attempt to get the debugger to stop at start_kernel. I'm having
> trouble driving the JTAG debugger (a BDI2000). I have used Denx's
> guide
> [1] in the past, but the section on debugging the kernel itself is now
> missing.
> 
> [1] http://www.denx.de/wiki/view/DULG/DebuggingLinuxKernel
> 
> I'll keep trying. 

start_kernel might be too late...

You can also hack thing :-) Like in the asm, before machine_init(),
stick something in the DABR and put a HW breakpoint with the BDI2000 on
the Data Access exception handler to "catch" when it faults.

Ben.
