Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB42567C79
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 06:52:18 +1100 (EST)
Date: Wed, 22 Nov 2006 19:51:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: NTP time sync
Message-ID: <20061122195153.GC22601@flint.arm.linux.org.uk>
References: <20061122203633.611acaa8@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061122203633.611acaa8@inspiron>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@osdl.org, Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org, paulus@samba.org,
	davem@davemloft.net, kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 22, 2006 at 08:36:33PM +0100, Alessandro Zummo wrote:
> 
> 
>  wrto the in-kernel NTP synchronization,
>  as discussed before [1], my opinion
>  is that it should be done in userland.
> 
>  Keeping it in kernel implies subtle code
>  in each of the supported architectures.
> 
>  So, if the arch maintainers agree, 
>  I would suggest to schedule it for removal.
> 
> [1] http://lkml.org/lkml/2006/3/28/358

Fine, provided there's also a shell tool that can enquire whether the
kernel is sync'd or not.  (Currently the 11-minute update does not
occur when the kernel is desynced from a time source - the RTC itself
might be more accurate in this case.)

Throwing hwclock commands into crontab such that they do not take
note of the kernel's sync status is probably a very bad move in that
respect.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
