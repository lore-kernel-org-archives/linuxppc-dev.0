Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB6E9B7CE7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 09:29:01 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix SMP when "cpu-release-addr" is in lowmem
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
References: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Jan 2010 16:28:55 -0600
Message-ID: <1264112935.31570.361.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "kumar.gala" <kumar.gala@freescale.com>, Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-18 at 16:50 -0600, Peter Tyser wrote:
> Recent U-Boot commit 5ccd29c3679b3669b0bde5c501c1aa0f325a7acb caused
> the "cpu-release-addr" device tree property to contain the physical RAM
> location that secondary cores were spinning at.  Previously, the
> "cpu-release-addr" property contained a value referencing the boot page
> translation address range of 0xfffffxxx, which then indirectly accessed
> RAM.
> 
> The "cpu-release-addr" is currently ioremapped and the secondary cores
> kicked.  However, due to the recent change in "cpu-release-addr", it
> sometimes points to a memory location in low memory that cannot be
> ioremapped.  For example on a P2020-based board with 512MB of RAM the
> following error occurs on bootup:
> 
>   <...>
>   mpic: requesting IPIs ...
>   __ioremap(): phys addr 0x1ffff000 is RAM lr c05df9a0
>   Unable to handle kernel paging request for data at address 0x00000014
>   Faulting instruction address: 0xc05df9b0
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   SMP NR_CPUS=2 P2020 RDB
>   Modules linked in:
>   <... eventual kernel panic>
> 
> Adding logic to conditionally ioremap or access memory directly resolves
> the issue.
> 
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> Reported-by: Dipen Dudhat <B09055@freescale.com>
> Tested-by: Dipen Dudhat <B09055@freescale.com>

Any chance this going to be picked up for 2.6.33?  The issue is
currently going to bite anyone using an MP-capable 85xx system that
doesn't use highmem.

Thanks,
Peter
