Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6140D1A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:34 +1100 (AEDT)
In-Reply-To: <1445475788-30348-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Fix M64 resource name in /proc/iomem
Message-Id: <20151217115733.D9CEE1402F0@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-22-10 at 01:03:08 UTC, Gavin Shan wrote:
> The name of PCI root bus's M64 resource isn't initialized properly.
> When dumping "/proc/iomem", "<BAD>" is seen for those M64 resources
> on PCI root buses.
> 
>    ~# cat /proc/iomem | grep -e "BAD"
>    3b0000000000-3b0fefffffff : <BAD>
>    3b1000000000-3b1fefffffff : <BAD>
>    3c0000000000-3c0fefffffff : <BAD>
>    3c1000000000-3c1fefffffff : <BAD>
>    3c2000000000-3c2fefffffff : <BAD>
> 
> This fixes the issue by setting the name of PCI root bus's M64
> resource to that of PHB's device node full name. With the patch,
> no "<BAD>" is seen from "/proc/iomem".
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e80c4e7ca5aed7d2fa766191bc

cheers
