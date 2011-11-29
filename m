Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D1A13B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 03:19:16 +1100 (EST)
Message-ID: <4ED5058F.90004@freescale.com>
Date: Tue, 29 Nov 2011 10:17:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
 <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
 <38BAFE03-DB17-4442-8CC2-E386E46FEB19@kernel.crashing.org>
In-Reply-To: <38BAFE03-DB17-4442-8CC2-E386E46FEB19@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> I don't think this is working.  I need to investigate some more to be
>> sure, but it looks like this is not picking up "fsl,eloplus-dma".
>> None of the DMA channels are being probed in the audio driver
>> (sound/soc/fsl_dma.c).
> 
> Hmm, that's odd.  Should see if the issues exists before the change.

If I move the "fsl,eloplus-dma" into mpc85xx_common_ids[], then everything works.

I suspect there's some kind of state machine in of_platform_bus_probe() that allows it to find the DMA channel nodes if it's scanned everything else first.  I'm trying to debug it now.

-- 
Timur Tabi
Linux kernel developer at Freescale
