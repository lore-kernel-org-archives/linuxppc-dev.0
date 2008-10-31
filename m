Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36AE3DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 22:32:15 +1100 (EST)
Subject: Re: 2.6.28-rc1: NVRAM being corrupted on ppc64 preventing boot
	(bisected)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18698.59790.393775.139313@cargo.ozlabs.ibm.com>
References: <alpine.LFD.2.00.0810232028500.3287@nehalem.linux-foundation.org>
	<20081030142632.GA15645@csn.ul.ie>
	<18698.7794.500191.189515@cargo.ozlabs.ibm.com>
	<20081031103646.GA24395@csn.ul.ie>
	<18698.59790.393775.139313@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 31 Oct 2008 22:31:37 +1100
Message-Id: <1225452697.8004.211.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-31 at 22:18 +1100, Paul Mackerras wrote:
> Mel Gorman writes:
> 
> > Yaboot in my case and I've heard it affected a DVD installation. I don't
> > know for sure if it affects netboot but as I think it's something the
> > kernel is doing, it probably doesn't matter how it gets loaded?
> 
> I do need to know whether it was the vmlinux or the zImage.pseries
> that you were loading with yaboot.  That commit you identified affects
> the contents of an ELF note in the zImage.pseries that firmware looks
> at, as well as a structure in the kernel itself that gets passed as an
> argument to a call to firmware.  If you were loading a vmlinux with
> yaboot when you saw the corruption occur then that narrows things down
> a bit.

Unless missed something, I think it's narrowed already. When loaded from
yaboot, there is no relevant difference between zImage and vmlinux here.
IE. yaboot parses the ELF header of the zImage itself and ignores the
special notes anyway so only the CAS firmware call is relevant in both
cases, no ?

Cheers,
Ben.
