Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6786CDDF8A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 00:12:33 +1100 (EST)
Message-Id: <D846801F-AA6B-4238-9FA4-A712EABFE800@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080213.004120.22092044.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
Date: Wed, 13 Feb 2008 07:12:26 -0600
References: <20080213.004120.22092044.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2008, at 2:41 AM, David Miller wrote:

>
> As I mentioned to a few ppc folks at LCA08 I plan to use
> the LMB code from powerpc as a basis for NUMA support on
> sparc64.
>
> There are two changes.
>
> 1) Move arch/powerpc/mm/lmb.c to lib/lmb.c, put the main
>   interface bits in include/linux/lmb.h, put arch-specific
>   bits in asm/lmb.h and add Kconfig machinery to build this
>   stuff on sparc64.
>
> 2) Fix a bug in lmb_alloc() wherein the size was not aligned
>   so we could easily run out of reserve blocks because
>   every aligned allocation would create a tiny hole, and
>   secondly the lmb_reserve() call there did not have it's
>   return value checked.
>
> Powerpc folks, if there are no objections please pull, thanks!
>
> The following changes since commit  
> 96b5a46e2a72dc1829370c87053e0cd558d58bc0:
>  Linus Torvalds (1):
>        WMI: initialize wmi_blocks.list even if ACPI is disabled
>
> are available in the git repository at:
>
>  master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git master
>
> David S. Miller (2):
>      [LIB]: Make PowerPC LMB code generic so sparc64 can use it too.
>      [LMB]: Fix bug in __lmb_alloc_base().

Does sparc have the concept of a phys_addr_t?  We are in the process  
of expanding the lmb support to deal with 36-bit physical addresses on  
32-bit machines.

- k
