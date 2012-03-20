Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30AEFB6ED0
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 04:25:27 +1100 (EST)
Message-ID: <4F68BD6F.2090008@freescale.com>
Date: Tue, 20 Mar 2012 12:25:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com> <20120319160452.B57D13E05A5@localhost>
 <4F677E51.8030905@freescale.com> <20120320170942.0C4143E2834@localhost>
In-Reply-To: <20120320170942.0C4143E2834@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Does a driver bind against "fsl,eloplus-dma"?  If so, then I would
> call of_platform_populate() from within the fsl,eloplus-dma driver's
> probe method.

Well, there are two "DMA" drivers.

The one in drivers/dma binds on fsl,eloplus-dma, and then manually scans
for children with the "fsl,eloplus-dma-channel" compatible.  This driver
works today because the fsl,eloplus-dma nodes are children of the SOC
node, which is already probed.

The other is in sound/soc/fsl and binds on "fsl,ssi-dma-channel".  These
are also children of the fsl,eloplus-dma node.  This driver does NOT work
today, because the fsl,eloplus-dma is not probed.

I do not want the two drivers to depend on each other.  They are
completely separate.  So I don't want to call of_platform_populate() from
the drivers/dma driver.  I could call it from the sound/soc/fsl driver,
however.  I will try to see if that works.

They only problem I see with this is that I am thinking about modifying
the drivers/dma driver to probe on "fsl,eloplus-dma-channel" channels
directly.  If I do that, then who should call of_platform_populate()?

-- 
Timur Tabi
Linux kernel developer at Freescale
