Return-Path: <hollisb@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEC62DDFAF
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 04:07:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3HI4D94004009
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 14:04:13 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3HI7noR198080
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 14:07:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3HI66WR018604
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 14:06:06 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 13:07:46 -0500
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
In-Reply-To: <625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904171307.47734.hollisb@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 April 2009 12:22:37 Josh Boyer wrote:
> On Fri, Apr 17, 2009 at 11:46 AM, John Linn <John.Linn@xilinx.com> wrote:
> > Josh, any thoughts on putting this into head_44x.S?
> 
> The code in the fsl file looks like the right solution.  I do have an
> odd question though, in that it's hard for the
> kernel to really know if something like a BDI is running.  Namely,
> that config option doesn't cover RiscWatch in an obvious manner.

Yeah, setting DBCR0 would interfere with all JTAG probes. The ifdef meands you 
can't support both a JTAG debugger and hardware breakpoints in the same 
binary? Now that's an annoying restriction.

> I also wonder if it's possible to have a host system be setting those
> registers in a guest KVM system so the guest could be debugged with
> gdb...  Hollis, any idea on that?

You mean is KVM currently doing that, and would this patch conflict with that 
behavior?

Right now KVM (on 440) context switches the necessary DB* registers for out-
of-band debugging. That is, qemu sends a "set breakpoint in guest" ioctl to 
KVM, and then when switching from host to guest mode, KVM will save the old 
DB* values, put in some new ones, and swap them back again when re-entering 
the host. So I *think* the answer to your question is "yes, KVM messes with 
these registers to enable software breakpoints when debugging a guest with 
gdb." That code path isn't heavily tested, but the values put into DB* by 
other host code shouldn't matter.

However, KVM doesn't support in-band breakpoints, i.e. it doesn't emulate the 
setting of those registers from within the guest. It's basically a no-op. So 
whether the kernel sets them or not, in-band debugging won't work with the 
current KVM code.

-- 
Hollis Blanchard
IBM Linux Technology Center
