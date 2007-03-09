Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8622CDDEA2
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 07:14:01 +1100 (EST)
Date: Fri, 9 Mar 2007 20:13:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Complain about missing system calls.
Message-ID: <20070309201308.GB8444@flint.arm.linux.org.uk>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de>
	<20070309163805.GV18564@lug-owl.de> <45F1B818.4090007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F1B818.4090007@zytor.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2007 at 11:40:08AM -0800, H. Peter Anvin wrote:
> Jan-Benedict Glaw wrote:
> >
> >Not everybody has a simple indexed list of pointers :)  For example,
> >for vax-linux, we use a struct per syscall with the expected number of
> >on-stack longwords for the call.
> >
> >So if something "new" is coming up, please keep in mind that it should
> >be flexible enough to represent that. :)
> >
> 
> I discussed with Al Viro a while ago about using something like the 
> SYSCALLS.def file from klibc as the source format for the system calls. 
>  That would deal very flexibly with almost all kinds of stub generation.

Hopefully with this idea in place, we can spot new syscalls before
the final release of the kernel (maybe kautobuild can help there)
and fix any silly system call argument ordering which requires
different architectures to have different syscall prototypes (eg,
sys_arm_fadvise64_64 vs sys_fadvise64_64, sys_arm_sync_file_range vs
sys_sync_file_range).

Otherwise the SYSCALLS.def file will probably end up being full of
ifdefs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
