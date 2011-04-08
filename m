Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 3DEADB6F7E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2011 01:58:48 +1000 (EST)
Date: Fri, 8 Apr 2011 08:32:46 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: platform_driver/of_platform_driver compile warning in fsldma.c
Message-ID: <20110408153246.GA13834@ovro.caltech.edu>
References: <D4BE3D54-805B-4D4F-B8BC-EC1A860C8E84@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D4BE3D54-805B-4D4F-B8BC-EC1A860C8E84@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2011 at 04:12:13AM -0500, Kumar Gala wrote:
> Grant,
> 
> I'm being lazy, can you give any quick insight on the following compile warning:
> 
> drivers/dma/fsldma.c:1457:2: warning: initialization from incompatible pointer type
> drivers/dma/fsldma.c: In function 'fsldma_init':
> drivers/dma/fsldma.c:1468:2: warning: passing argument 1 of 'platform_driver_register' from incompatible pointer type
> include/linux/platform_device.h:124:12: note: expected 'struct platform_driver *' but argument is of type 'struct of_platform_driver *'
> drivers/dma/fsldma.c: In function 'fsldma_exit':
> drivers/dma/fsldma.c:1473:2: warning: passing argument 1 of 'platform_driver_unregister' from incompatible pointer type
> include/linux/platform_device.h:125:13: note: expected 'struct platform_driver *' but argument is of type 'struct of_platform_driver *'
> 

The "struct of_platform_driver" needs to be changed to a
"struct platform_driver". Just remove the "of_" prefix, the structure
initialization is correct. I sent a patch for this yesterday to LKML. The
title is: fsldma: fix build warning caused by of_platform_device changes

Ira
