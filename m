Return-Path: <mans@mansr.com>
Received: from unicorn.mansr.com (unicorn.mansr.com
 [IPv6:2001:8b0:ca0d:8d8e::2])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r2zGw4gfGzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 07:31:36 +1000 (AEST)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH v2 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160508194112.GL4775@htj.duckdns.org>
Date: Sun, 08 May 2016 22:25:39 +0100
In-Reply-To: <20160508194112.GL4775@htj.duckdns.org> (Tejun Heo's message of
 "Sun, 8 May 2016 15:41:12 -0400")
Message-ID: <yw1xtwi8i6ng.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tejun Heo <tj@kernel.org> writes:

> On Tue, Apr 26, 2016 at 12:03:04PM +0300, Andy Shevchenko wrote:
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>> index 7f95389..aee8873 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht =3D=
 {
>>  	 */
>>  	.sg_tablesize		=3D LIBATA_MAX_PRD,
>>  	/* .can_queue		=3D ATA_MAX_QUEUE, */
>> -	.dma_boundary		=3D ATA_DMA_BOUNDARY,
>> +	/*
>> +	 * Make sure a LLI block is not created that will span 8K max FIS
>> +	 * boundary. If the block spans such a FIS boundary, there is a chance
>> +	 * that a DMA burst will cross that boundary -- this results in an
>> +	 * error in the host controller.
>> +	 */
>> +	.dma_boundary		=3D 0x1fff /* ATA_DMA_BOUNDARY */,
>
> The host controller can't cross 8k boundary?  Is this for real?

>From the manual:

  DMA block and burst transaction sizes are critical for DMA operation.
  (Also see the definition of "DMA transfer".)  These sizes should be
  selected properly to ensure error-free bus transfers. It is required
  that the DMA write burst transfer does not cross the 8192-byte Data
  FIS boundary, because the Transport Layer maintains the DMA state for
  the duration of the Data FIS transmission.

--=20
M=E5ns Rullg=E5rd
