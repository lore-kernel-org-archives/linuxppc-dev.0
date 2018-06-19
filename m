Return-Path: <axboe@kernel.dk>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419BwG1dNJzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 01:39:25 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id y127-v6so15052700itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 08:39:24 -0700 (PDT)
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
 <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
 <87sh5jxmif.fsf@concordia.ellerman.id.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f82edaa2-4b1a-c747-3d58-ec86ceb4ee7e@kernel.dk>
Date: Tue, 19 Jun 2018 09:39:18 -0600
MIME-Version: 1.0
In-Reply-To: <87sh5jxmif.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/19/18 1:29 AM, Michael Ellerman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> On 6/18/18 1:33 AM, Michael Ellerman wrote:
>>> Tejun Heo <tj@kernel.org> writes:
>>> ...
>>>> Jens Axboe (10):
>>>>       libata: introduce notion of separate hardware tags
>>>>       libata: convert core and drivers to ->hw_tag usage
>>>>       libata: bump ->qc_active to a 64-bit type
>>>>       libata: use ata_tag_internal() consistently
>>>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>>>       sata_nv: set host can_queue count appropriately
>>>>       libata: add extra internal command
>>>
>>> Replying here because I can't find the original mail.
>>>
>>> The above commit is causing one of my machines to constantly spew ata
>>> messages on the console, according to bisect:
>>>
>>> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
>>>
>>> To get it to boot I have to also apply:
>>>
>>>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
>>>
>>>
>>> The system boots OK and seems fine, except that it's just printing
>>> multiple of these per second:
>>>
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>   ata2.00: configured for UDMA/100
>>>   ata2: Signature Update detected @ 0 msecs
>>>
>>> And it never seems to stop.
>>>
>>> The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
>>> presumably. Any ideas?
>>
>> Hmm that's odd. Can you include the boot log from a working boot as
>> well? Would be nice to see what devices are on the sata adapter.
>> The above just looks like a hardreset loop.
> 
> Ah yep. I stupidly assumed it was working, because the machine booted,
> but that's because the root disk is on ata1.
> 
> Booting the good kernel:
> 
>   ba80c3a572f4 ("sata_nv: set host can_queue count appropriately")
> 
> I see:
> 
>   root@p5020ds:~# ls -l /sys/class/ata_port/
>   total 0
>   lrwxrwxrwx 1 root root 0 Jun 19 06:49 ata1 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/ata_port/ata1
>   lrwxrwxrwx 1 root root 0 Jun 19 17:06 ata2 -> ../../devices/platform/ffe000000.soc/ffe221000.sata/ata2/ata_port/ata2
> 
>   root@p5020ds:~# ls -l /sys/class/block/ | grep ata
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda1 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda1
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda2 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda2
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda5 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda5
>   lrwxrwxrwx 1 root root 0 Jun 19 17:11 sr0 -> ../../devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/block/sr0
> 
> So it's the DVD drive.
> 
>   root@p5020ds:/sys/devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0/device# cat vendor 
>   Optiarc 
>   root@p5020ds:/sys/devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0/device# cat model
>   DVD RW AD-7260S 
> 
> 
> Full boot log from a good boot attached if that's helpful.
> 
> All of the above looks the same when I boot with the broken setup, it
> just spams dmesg constantly.
> 
> One thing that is different, on the good kernel I see:
> 
>   root@p5020ds:~# mount /dev/sr0 /mnt
>   mount: no medium found on /dev/sr0
> 
> vs bad (88e10092f6a6):
> 
>   root@p5020ds:~# mount /dev/sr0 /mnt
>   mount: /dev/sr0 is already mounted or /mnt busy
> 
> cheers

Actually, just try this one on top of current -git.

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b8d9cfc60374..4007a9ae650d 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -395,12 +395,6 @@ static inline unsigned int sata_fsl_tag(unsigned int tag,
 {
 	/* We let libATA core do actual (queue) tag allocation */
 
-	/* all non NCQ/queued commands should have tag#0 */
-	if (ata_tag_internal(tag)) {
-		DPRINTK("mapping internal cmds to tag#0\n");
-		return 0;
-	}
-
 	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
 		DPRINTK("tag %d invalid : out of range\n", tag);
 		return 0;
@@ -1229,7 +1223,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 
 	/* Workaround for data length mismatch errata */
 	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
-		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		for (tag = 0; tag <= ATA_MAX_QUEUE; tag++) {
 			qc = ata_qc_from_tag(ap, tag);
 			if (qc && ata_is_atapi(qc->tf.protocol)) {
 				u32 hcontrol;

-- 
Jens Axboe
