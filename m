Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1219DB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 21:32:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E947DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 21:32:46 +1000 (EST)
Subject: Re: 85xx Address space query
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 25 Jun 2009 21:32:34 +1000
Message-Id: <1245929554.22312.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kernel mailz <kernelmailz@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > 1. User code executes ioctl
> > 2. interrupt goes to the kernel
> 
> On the interrupt the PR changes from 0 -> 1

The other way around actually :-)

> > 3. ioctl handler in driver gets invoked
> > The buffer pointer still contains 0x10000.
> >
> > How kernel code running in PR=0 accesses it and does the copy. I am  
> > not able to see a address space switch in the asm code of  
> > copy_tofrom_user.
> 
> There isn't a address space switch.  But address spaces exist at the  
> same time.  The user app is given 0..0xc000_0000 and the kernel uses  
> 0xc000_0000..0xffff_ffff.

You may want to add, to make things clearer, that the HW treats PID 0
specially. Translations in the TLB that have PID (we call it TID in the
TLB entry) 0 match any value of the PID register.

So kernel pages all have TID = 0, which means they are visible to all
processes, but have permissions set such that only the supervisor (ie.
PR = 0) can actually access them. MSR:PR is automatically switched to 0
by the processor when taking an interrupt, allowing the kernel thus to
access both its own pages and the pages of the current process.

Cheers,
Ben.
