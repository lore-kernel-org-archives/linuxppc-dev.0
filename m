Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 81BB82C0085
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2012 06:41:45 +1000 (EST)
Message-ID: <1345236056.11781.1.camel@pasglop>
Subject: Re: PPC64 & DMA zone
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 18 Aug 2012 06:40:56 +1000
In-Reply-To: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
References: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-17 at 23:04 +0300, Aaro Koskinen wrote:
> Hi,
> 
> Is there a way to reduce/limit DMA zone with PPC64 kernel (3.6-rcX)
> on G5 Mac? I have tried to search Kconfig or command line options,
> but can't find anything.

No.

> The problem I have is that b43 driver (wireless chip) insists a 30-bit
> DMA mask, but I have 1.5 GB physical memory. So the only way I can get
> the wireless connection to work is to boot with "mem=1024MB". And as a
> result my bloaty applications will loose much needed memory...

Or force the iommu to be enabled, it should be able to service
constrained DMA (iommu=force on the command line).

Cheers,
Ben.
