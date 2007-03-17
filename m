Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id F40C8DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 19:06:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
Date: Sat, 17 Mar 2007 09:09:13 +0100
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<e9c3a7c20703161100j70a52e5cg25ff3616a5cda8d5@mail.gmail.com>
In-Reply-To: <e9c3a7c20703161100j70a52e5cg25ff3616a5cda8d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703170909.13869.sr@denx.de>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan,

I just noticed that your patch "dmaengine: add the async_tx api":

@@ -22,6 +22,17 @@ config NET_DMA
 	  Since this is the main user of the DMA engine, it should be enabled;
 	  say Y here.
 
+config ASYNC_TX_DMA
+	tristate "Asynchronous Bulk Memory Transfers/Transforms API"
+	default y
+	---help---
+	  This enables the async_tx management layer for dma engines.
+	  Subsystems coded to this API will use offload engines for bulk
+	  memory operations where present.  Software implementations are
+	  called when a dma engine is not present or fails to allocate
+	  memory to carry out the transaction.
+	  Current subsystems ported to async_tx: MD_RAID4,5
+

adds ASYNC_TX_DMA unconditionally to _all_ platforms. You might what to bundle 
this with something like DMA_ENGINE.

Best regards,
Stefan
