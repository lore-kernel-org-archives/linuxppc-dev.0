Return-Path: <axboe@kernel.dk>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418YVV3nhlzF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 00:33:20 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id m194-v6so12312082itg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 07:33:20 -0700 (PDT)
Subject: Re: Constant ata messages on console with commit 28361c403683
 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes
 for v4.18-rc1)
To: Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
 <20180605191525.GF1351649@devbig577.frc2.facebook.com>
 <87bmc8a6qi.fsf@concordia.ellerman.id.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
Date: Mon, 18 Jun 2018 08:33:15 -0600
MIME-Version: 1.0
In-Reply-To: <87bmc8a6qi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/18/18 1:33 AM, Michael Ellerman wrote:
> Tejun Heo <tj@kernel.org> writes:
> ...
>> Jens Axboe (10):
>>       libata: introduce notion of separate hardware tags
>>       libata: convert core and drivers to ->hw_tag usage
>>       libata: bump ->qc_active to a 64-bit type
>>       libata: use ata_tag_internal() consistently
>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>       sata_nv: set host can_queue count appropriately
>>       libata: add extra internal command
> 
> Replying here because I can't find the original mail.
> 
> The above commit is causing one of my machines to constantly spew ata
> messages on the console, according to bisect:
> 
> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
> 
> To get it to boot I have to also apply:
> 
>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
> 
> 
> The system boots OK and seems fine, except that it's just printing
> multiple of these per second:
> 
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
> 
> And it never seems to stop.
> 
> The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
> presumably. Any ideas?

Hmm that's odd. Can you include the boot log from a working boot as
well? Would be nice to see what devices are on the sata adapter.
The above just looks like a hardreset loop.

-- 
Jens Axboe
