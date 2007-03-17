Return-Path: <dan.j.williams@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 20A31DDEE8
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 05:18:00 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so591100nfc
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 11:17:58 -0700 (PDT)
Message-ID: <e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
Date: Sat, 17 Mar 2007 11:17:58 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Stefan Roese" <sr@denx.de>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
In-Reply-To: <200703170909.13869.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<e9c3a7c20703161100j70a52e5cg25ff3616a5cda8d5@mail.gmail.com>
	<200703170909.13869.sr@denx.de>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/17/07, Stefan Roese <sr@denx.de> wrote:
> Dan,
>
> I just noticed that your patch "dmaengine: add the async_tx api":
>
> @@ -22,6 +22,17 @@ config NET_DMA
>           Since this is the main user of the DMA engine, it should be enabled;
>           say Y here.
>
> +config ASYNC_TX_DMA
> +       tristate "Asynchronous Bulk Memory Transfers/Transforms API"
> +       default y
> +       ---help---
> +         This enables the async_tx management layer for dma engines.
> +         Subsystems coded to this API will use offload engines for bulk
> +         memory operations where present.  Software implementations are
> +         called when a dma engine is not present or fails to allocate
> +         memory to carry out the transaction.
> +         Current subsystems ported to async_tx: MD_RAID4,5
> +
>
> adds ASYNC_TX_DMA unconditionally to _all_ platforms. You might what to bundle
> this with something like DMA_ENGINE.
>
Yes, defaulting to 'y' is not necessary, but ASYNC_TX_DMA=y &&
DMA_ENGINE=n is an explicit feature of the interface.  When DMA_ENGINE
is not selected all the asynchronous paths in the API are compiled
out.  This allows subsytems, like md-raid5, to be written in an
asynchronous fashion without regard for the architecture[1] or
availability of offload engines.

> Best regards,
> Stefan

Regards,
Dan

[1] The API implicitly handles channel switching depending on the
offload engine architecture.  Where an iop13xx engine can handle a
copy+xor sequence on one channel, a 440sp or iop3xx platform will need
to switch between copy and xor capable engines.  Resolving operation
dependencies and channel switching is handled behind the scenes.
