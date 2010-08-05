Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76FB31007DB
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 01:16:42 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: gregkh@suse.de
Subject: [PATCH 0/3] driver core: Add ability for arch code to setup
	pdev_archdata
Date: Thu,  5 Aug 2010 10:15:44 -0500
Message-Id: <1281021347-1278-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC we need to set the dma_mask pointer for platform_devices to point to
the pdev_archdata.  We can't wait for a bus_notifier as we need the dma_mask
setup before the platform_device_add happens so that the bus_notifiers can
check the dma_mask to determine if we need things like the SWIOTLB dma_ops.

The patch series introduces an arch specific call out (arch_setup_pdev_archdata)
and provide an implementation on PPC to handle our specific issue.

- k
