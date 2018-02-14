Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cl51JrzDqpP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:51 +1100 (AEDT)
In-Reply-To: <1518474848-3158-2-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [2/2] powerpc/pseries: Declare optional dummy function for
 find_and_online_cpu_nid
Message-Id: <3zh7ch49bHz9t6D@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-02-12 at 22:34:08 UTC, Guenter Roeck wrote:
> Commit e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with
> memoryless nodes") adds an unconditional call to find_and_online_cpu_nid(),
> which is only declared if CONFIG_PPC_SPLPAR is enabled. This results in
> the following build error if this is not the case.
> 
> arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
> arch/powerpc/platforms/pseries/hotplug-cpu.c:369:
> 			undefined reference to `.find_and_online_cpu_nid'
> 
> Follow the guideline provided by similar functions and provide a dummy
> function if CONFIG_PPC_SPLPAR is not enabled. This also moves the external
> function declaration into an include file where it should be.
> 
> Fixes: e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with ...")
> Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/82343484a2d4c97a03bfd81303b549

cheers
