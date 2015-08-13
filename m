Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2C761A0671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 11:44:25 +1000 (AEST)
In-Reply-To: <1438917500-12100-4-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>, imunsie@au.ibm.com
Subject: Re: [4/4] cxl: sparse: Silence iomem warning in debugfs file creation
Message-Id: <20150813014424.F107A140663@ozlabs.org>
Date: Thu, 13 Aug 2015 11:44:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-08 at 03:18:20 UTC, Daniel Axtens wrote:
> An IO address, tagged with __iomem, is passed to debugfs_create_file
> as private data. This requires that it be cast to void *. The cast
> creates a sparse warning:
> /scratch/dja/linux-capi/drivers/misc/cxl/debugfs.c:51:57: warning: cast removes address space of expression
> 
> The address space marker is added back in the file operations
> (fops_io_u64).
> 
> Silence the warning with __force.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/83c3fee7e78f5a937b73

cheers
