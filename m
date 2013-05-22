Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16D132C017F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 14:17:04 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: SATA hang on 8315E triggered by heavy flash write?
From: Anthony Foiani <tkil@scrye.com>
References: <1369172643.1374.15@scott-Lenovo-G560>
Date: Tue, 21 May 2013 22:16:57 -0600
In-Reply-To: <1369172643.1374.15@scott-Lenovo-G560> (Scott Wood's message of
 "Tue\, 21 May 2013 16\:44\:03 -0500")
Message-ID: <gppwj3ayu.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Shaohui.Xie@freescale.com
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Scott --

Scott Wood <scottwood@freescale.com> writes:

> On 05/15/2013 03:12:21 AM, Anthony Foiani wrote:
>> At this point, /dev/sda is pretty much unusable, and I have to do
>> at least a reboot to recover.  (I don't recall if I had to do a
>> power cycle at this point, though.)

For whatever it's worth, a hard boot (full power cycle) is indeed
necessary at this point.

>> I suspect that it is related to errata eLBC-A001 (from MPC8315E
>> Chip Errata, Rev. 3, 09/2011):
>> ...
>> But it seems that erratum is already fixed:
>> 
>>   http://patchwork.ozlabs.org/patch/96339/
>>   (git patch d08e44570e)
>> 
>> Am I reading that correctly?
>
> Yes, that erratum has been worked around.

Ok, thanks for the confirmation.

>> (I'm already writing only one flash sector at a time, but it might
>> be that even a single 0x10000-byte sector takes long enough to
>> trigger the issue.)
>
> I don't think this erratum is relevant.  Unlike NAND, NOR flash does
> not involve holding the localbus for extended periods of time.

I wasn't sure about the mechanism of the erratum, and it seemed
awfully close, so I thought I'd go fishing.  Guess I missed.  :(

It is NOR writes, btw; I do both in my application, but the initial
error always seems to occur during a NOR write.  (In this device,
kernel + devtree go into NOR flash, ramdisk goes into NAND flash, and
data goes to SSD... stop laughing.)

Here's the most recent hang.  First, to compare the application log
timestamps with the kernel log timestamps:

  # mix of kernel and application log, note that kernel is about +12s.
  +0.537506 main.0 [0]: rc: fork took 9.376ms
  [   12.892323] PHY: mdio@e0024520:01 - Link is Up - 100/Full
  +1.603034 main.0 [0]: schs: ctor: done

The console output is:

  # console log
  [318334.294126] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
  [318334.301515] ata2.00: PHY RDY changed
  [318334.305301] ata2.00: failed command: WRITE DMA
  [318334.309991] ata2.00: cmd ca/00:08:b0:00:18/00:00:00:00:00/e1 tag 0 dma 4096 out
  [318334.310015]          res 50/00:00:08:61:25/00:00:00:00:00/e1 Emask 0x10 (ATA bus error)
  [318334.325689] ata2.00: status: { DRDY }
  [318334.329717] ata2: hard resetting link
  [318334.836038] ata2: Hardreset failed, not off-lined 0
  [318334.848407] ata2: setting speed (in hard reset)
  [318344.456050] ata2: No Signature Update
  [318344.631916] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [318344.638354] ata2.00: link online but device misclassified
  [318349.643897] ata2.00: qc timeout (cmd 0xec)
  [318349.648268] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  [318349.654562] ata2.00: revalidation failed (errno=-5)
  [318349.659667] ata2: hard resetting link
  [318350.163864] ata2: Hardreset failed, not off-lined 0
  [318350.175869] ata2: setting speed (in hard reset)
  [318359.771956] ata2: No Signature Update
  [318359.947901] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [318359.954342] ata2.00: link online but device misclassified
  [318369.959921] ata2.00: qc timeout (cmd 0xec)
  [318369.964279] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  [318369.970567] ata2.00: revalidation failed (errno=-5)
  [318369.975658] ata2: hard resetting link
  [318370.479933] ata2: Hardreset failed, not off-lined 0
  [318370.491880] ata2: setting speed (in hard reset)
  [318380.083892] ata2: No Signature Update

And my application log:

  # application log
  +318320.957019 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x180000 from buf[0x80000]; attempt 1/3
  +318322.498346 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x190000 from buf[0x90000]; attempt 1/3
  +318323.849995 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1a0000 from buf[0xa0000]; attempt 1/3
  +318325.262559 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1b0000 from buf[0xb0000]; attempt 1/3
  +318326.703213 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1c0000 from buf[0xc0000]; attempt 1/3

> I also don't see how it would interact with SATA, which is separate
> from the localbus.  

No idea.  Is there some other shared resource that might be taxed by
this type of load?

I do get a few other errors, usually just once or twice per boot:

  [ 4231.619368] NOHZ: local_softirq_pending 100
  [ 4232.249935] NOHZ: local_softirq_pending 100
  [ 4232.312241] NOHZ: local_softirq_pending 100
  [ 4232.424523] NOHZ: local_softirq_pending 100
  [ 4233.139146] NOHZ: local_softirq_pending 100
  [ 4233.328540] NOHZ: local_softirq_pending 100
  [ 4233.655909] NOHZ: local_softirq_pending 100
  [ 4234.106578] NOHZ: local_softirq_pending 100
  [ 4234.853966] NOHZ: local_softirq_pending 100
  [ 4235.375208] NOHZ: local_softirq_pending 100
  [11072.027818] hrtimer: interrupt took 126210 ns

They seem harmless, though, and (as the timestamps indicate) the
machine happily ran for 3-4 days after those issues.

> Are you seeing any errors on the localbus, or just on SATA?

I'm not seeing any errors in the console log -- but I'm not using the
LBC for anything other than flash writes, SFAIK.  (Unless I2C is
handled through the LBC, in which case, I have frequent (~50-100/s)
small transactions all the time -- but the hangs always coincide with
flash writes, and not with the I2C traffic that is going on all the
time...)

> Hopefully Shaohui (our SATA person) can answer these.  If you don't
> get an answer, go ahead and open an official support request.

I have a (lousy) workaround in hand: don't touch the disk during flash
updates.  (The flash writes are software updates, which will hopefully
be fairly rare once I'm done developing this thing.  Until then,
though, I'm updating it multiple times a day, and have hit this quite
a few times by now.)

So there's no great hurry.  If Shaohui can find something in the next
week or so, that'd be fantastic; otherwise, I'll open a request.

Thanks again!

Best regards,
Anthony Foiani
