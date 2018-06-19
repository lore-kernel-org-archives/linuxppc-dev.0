Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419PV10sR3zF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:35:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Constant ata messages on console with commit 28361c403683
 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes
 for v4.18-rc1)
In-Reply-To: <f82edaa2-4b1a-c747-3d58-ec86ceb4ee7e@kernel.dk>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
 <20180605191525.GF1351649@devbig577.frc2.facebook.com>
 <87bmc8a6qi.fsf@concordia.ellerman.id.au>
 <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
 <87sh5jxmif.fsf@concordia.ellerman.id.au>
 <f82edaa2-4b1a-c747-3d58-ec86ceb4ee7e@kernel.dk>
Date: Wed, 20 Jun 2018 09:35:51 +1000
Message-ID: <87r2l2wdrc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jens Axboe <axboe@kernel.dk> writes:
> On 6/19/18 1:29 AM, Michael Ellerman wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>> On 6/18/18 1:33 AM, Michael Ellerman wrote:
>>>> Tejun Heo <tj@kernel.org> writes:
>>>> ...
>>>>> Jens Axboe (10):
>>>>>       libata: introduce notion of separate hardware tags
>>>>>       libata: convert core and drivers to ->hw_tag usage
>>>>>       libata: bump ->qc_active to a 64-bit type
>>>>>       libata: use ata_tag_internal() consistently
>>>>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>>>>       sata_nv: set host can_queue count appropriately
>>>>>       libata: add extra internal command
>>>>
>>>> Replying here because I can't find the original mail.
>>>>
>>>> The above commit is causing one of my machines to constantly spew ata
>>>> messages on the console, according to bisect:
>>>>
>>>> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
>>>>
>>>> To get it to boot I have to also apply:
>>>>
>>>>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
>>>>
>>>>
>>>> The system boots OK and seems fine, except that it's just printing
>>>> multiple of these per second:
>>>>
>>>>   ata2: Signature Update detected @ 0 msecs
>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>   ata2.00: configured for UDMA/100
>>>>   ata2: Signature Update detected @ 0 msecs
>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>   ata2.00: configured for UDMA/100
>>>>   ata2: Signature Update detected @ 0 msecs
>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>   ata2.00: configured for UDMA/100
>>>>   ata2: Signature Update detected @ 0 msecs
>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>   ata2.00: configured for UDMA/100
>>>>   ata2: Signature Update detected @ 0 msecs
...
>
> Actually, just try this one on top of current -git.

Yep that fixes it.

No more message spam, and when I try to mount sr0 it says "no medium".

I'll have to go into the office to actually put a disc in the drive
to check it's really working, but it seems likely.

Thanks for debugging it, here's a tested-by if you like:

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index b8d9cfc60374..4007a9ae650d 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -395,12 +395,6 @@ static inline unsigned int sata_fsl_tag(unsigned int tag,
>  {
>  	/* We let libATA core do actual (queue) tag allocation */
>  
> -	/* all non NCQ/queued commands should have tag#0 */
> -	if (ata_tag_internal(tag)) {
> -		DPRINTK("mapping internal cmds to tag#0\n");
> -		return 0;
> -	}
> -
>  	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
>  		DPRINTK("tag %d invalid : out of range\n", tag);
>  		return 0;
> @@ -1229,7 +1223,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  
>  	/* Workaround for data length mismatch errata */
>  	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> -		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> +		for (tag = 0; tag <= ATA_MAX_QUEUE; tag++) {
>  			qc = ata_qc_from_tag(ap, tag);
>  			if (qc && ata_is_atapi(qc->tf.protocol)) {
>  				u32 hcontrol;
>
> -- 
> Jens Axboe
