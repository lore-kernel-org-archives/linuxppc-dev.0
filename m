Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74D80DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 18:01:20 +1100 (EST)
Message-Id: <71AAAC27-C150-4C3D-B065-BC15196BED2B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <11854393771067-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 5/5 v3] Add the memory management driver to RapidIO.
Date: Thu, 24 Jan 2008 01:01:07 -0600
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
	<11854393741899-git-send-email-wei.zhang@freescale.com>
	<11854393753986-git-send-email-wei.zhang@freescale.com>
	<11854393763547-git-send-email-wei.zhang@freescale.com>
	<11854393771067-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2007, at 3:42 AM, Zhang Wei wrote:

> This patch adds the memory management driver to RapidIO.
> The RapidIO system size is changed to automatically detection.
> Add the memory mapping driver to RapidIO basic driver.
> Multi master ports are supported.
> Add a simple Bitmap RapidIO space allocator driver.

Can we break up the functionality here into separate patches.  I'm  
seeing 4 logical patches:
* system size is changed to automatic detection
* support for multi master ports
* bitmap allocator
* memory map driver


> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
> drivers/net/rionet.c                |   17 +-
> drivers/rapidio/Kconfig             |   18 +-
> drivers/rapidio/Makefile            |    1 +
> drivers/rapidio/rio-access.c        |   10 +-
> drivers/rapidio/rio-scan.c          |   53 +++--
> drivers/rapidio/rio-sysfs.c         |    3 +-
> drivers/rapidio/rio.c               |  479 ++++++++++++++++++++++++++ 
> ++++++++-
> drivers/rapidio/rio.h               |    9 +-
> drivers/rapidio/sallocator/Kconfig  |    9 +
> drivers/rapidio/sallocator/Makefile |   12 +
> drivers/rapidio/sallocator/bitmap.c |  382 ++++++++++++++++++++++++++ 
> ++
> include/linux/rio.h                 |   71 +++++-
> include/linux/rio_drv.h             |   41 +++-
> 13 files changed, 1046 insertions(+), 59 deletions(-)
> create mode 100644 drivers/rapidio/sallocator/Kconfig
> create mode 100644 drivers/rapidio/sallocator/Makefile
> create mode 100644 drivers/rapidio/sallocator/bitmap.c

[snip]

> +config RAPIDIO_PROC_FS
> +	bool "I/O and Memory resource debug"
> +	depends on RAPIDIO && PROC_FS
> +	default y
> +	---help---
> +	  Enable this option, it will create a /proc/riores node for
> +	  monitoring the RapidIO I/O and Memory resource.
> +

This isn't going to be acceptable.  You should use sysfs or debugfs  
not proc.

- k
