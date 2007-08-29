Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0B93DDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 08:39:01 +1000 (EST)
In-Reply-To: <20070828201929.GH24329@ld0162-tx32.am.freescale.net>
References: <20070828201929.GH24329@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <66A3DBEB-412D-4229-88DA-B47F3256CEF6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/9] mpc82xx: Update mpc8272ads,
	and factor out PCI and reset.
Date: Wed, 29 Aug 2007 17:41:17 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 28, 2007, at 3:19 PM, Scott Wood wrote:

> 1. PCI and reset are factored out into pq2.c.  I renamed them from  
> m82xx
> to pq2 because they won't work on the Integrated Host Processor  
> line of
> 82xx chips (i.e. 8240, 8245, and such).
>
> 2. The PCI PIC, which is nominally board-specific, is used on multiple
> boards, and thus is used into pq2ads-pci-pic.c.
>
> 3. The new CPM binding is used.
>
> 4. General cleanup.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/Kconfig                         |    2 +-
>  arch/powerpc/boot/dts/mpc8272ads.dts         |  321 +++++++------
>  arch/powerpc/configs/mpc8272_ads_defconfig   |  380 ++++++++-------
>  arch/powerpc/platforms/82xx/Kconfig          |    5 +
>  arch/powerpc/platforms/82xx/Makefile         |    2 +
>  arch/powerpc/platforms/82xx/mpc8272_ads.c    |  671 ++++ 
> +---------------------
>  arch/powerpc/platforms/82xx/pq2.c            |   93 ++++
>  arch/powerpc/platforms/82xx/pq2.h            |   20 +
>  arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |  202 ++++++++
>  arch/powerpc/platforms/82xx/pq2ads.h         |    2 -
>  10 files changed, 816 insertions(+), 882 deletions(-)
>  create mode 100644 arch/powerpc/platforms/82xx/pq2.c
>  create mode 100644 arch/powerpc/platforms/82xx/pq2.h
>  create mode 100644 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c

NACK.

I don't want pq2 to be the only platform that has the PCI bus  
separate from the PCI controller.

- k
