Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id ED403DDEE9
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 05:41:12 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
Date: Sat, 17 Mar 2007 19:43:27 +0100
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
In-Reply-To: <e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703171943.27465.sr@denx.de>
Cc: linux-raid@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 17 March 2007 19:17, Dan Williams wrote:
> Yes, defaulting to 'y' is not necessary, but ASYNC_TX_DMA=y &&
> DMA_ENGINE=n is an explicit feature of the interface.  When DMA_ENGINE
> is not selected all the asynchronous paths in the API are compiled
> out.  This allows subsytems, like md-raid5, to be written in an
> asynchronous fashion without regard for the architecture[1] or
> availability of offload engines.

The current implementation builds on my embedded PPC4xx system without any 
disks the objects async_tx.o and xor.o into the kernel which I definitely 
don't need and want. And I get something like:

async_tx: api initialized (sync-only)
xor: measuring software checksumming speed
   8regs     :   145.000 MB/sec
   8regs_prefetch:   115.000 MB/sec
   32regs    :   176.000 MB/sec
   32regs_prefetch:   135.000 MB/sec
xor: using function: 32regs (176.000 MB/sec)

upon bootup.

Best regards,
Stefan
