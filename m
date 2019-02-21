Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C89FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:34:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FED420842
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FED420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444np115dHzDqPg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:34:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444nRh5kbQzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:18:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444nRh2v1Hz8smg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:18:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444nRh1XGVz9sBr; Thu, 21 Feb 2019 19:18:40 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=emerson.com
 (client-ip=162.253.133.57; helo=n7.nabble.com;
 envelope-from=sachin.gosavi@emerson.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 444nRg2PWYz9s1b
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 19:18:37 +1100 (AEDT)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id E516E9E23078
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 01:18:34 -0700 (MST)
Date: Thu, 21 Feb 2019 01:18:34 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1550737114935-0.post@n7.nabble.com>
In-Reply-To: <1550230073842-0.post@n7.nabble.com>
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
 <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
 <1550062386389-0.post@n7.nabble.com>
 <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
 <1550132231035-0.post@n7.nabble.com>
 <20190214191443.5f64bb56@kitsune.suse.cz>
 <1550230073842-0.post@n7.nabble.com>
Subject: Re: Kernel panic when loading the IDE controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,


I finally got the FLASH controller driver working and it is now successfully
reporting the presence of 2GB Flash in the board. I used the new "libata"
driver code present in the new kernel source under drivers/ata/. Also did
the required additions in the device tree to provide the IO port, IRQ and
PIO mode details to the driver. 

However now I am getting the below errors.


[    4.200145] scsi host0: pata_of_platform
[    4.236999] ata1: PATA max PIO4 mmio cmd 0xe0000000 ctl 0xe200000c irq 63
[    4.439985] ata1.01: ATA-7: 2GB ATA Flash Disk, C A254G4, max UDMA/133
[    4.463419] ata1.01: 3571344 sectors, multi 0: LBA48
[    4.483384] ata1.01: configured for PIO
[    4.512936] scsi 0:0:1:0: Direct-Access     ATA      2GB ATA Flash Di
54G4 PQ: 0 ANSI: 5
[    4.555994] sd 0:0:1:0: [sda] 3571344 512-byte logical blocks: (1.83
GB/1.70 GiB)
[    4.591975] sd 0:0:1:0: [sda] Write Protect is off
[    4.611307] sd 0:0:1:0: [sda] Mode Sense: 00 3a 00 00
[    4.629733] sd 0:0:1:0: [sda] Write cache: disabled, read cache: enabled,
doesn't support DPO or FUA
[    4.823702]
[    4.823702] AT THE START OF CPU_STARTUP_ENTRY FUNCTION
[    4.823734]
[    4.823734] *****INSIDE IDLE LOOP********
[   36.163139] ata1: drained 65536 bytes to clear DRQ
[   36.185451] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[   36.199598] ata1.01: cmd 20/00:08:00:00:00/00:00:00:00:00/f0 tag 0 pio
4096 in
[   36.199598]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[   36.229002] ata1: soft resetting link
[   36.559637] ata1.01: configured for PIO
[   36.567563] ata1.01: device reported invalid CHS sector 0
[   36.578396] ata1: EH complete
[   68.919134] ata1: drained 65536 bytes to clear DRQ
[   68.928530] ata1.01: limiting speed to UDMA7:PIO5
[   68.937856] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[   68.952487] ata1.01: cmd 20/00:08:00:00:00/00:00:00:00:00/f0 tag 0 pio
4096 in
[   68.952487]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[   68.981876] ata1: soft resetting link
[   69.311683] ata1.01: configured for PIO
[   69.319304] ata1.01: device reported invalid CHS sector 0
[   69.330274] ata1: EH complete
[  101.687134] ata1: drained 65536 bytes to clear DRQ
[  101.696646] ata1.01: limiting speed to PIO0
[  101.704921] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  101.719288] ata1.01: cmd 20/00:08:00:00:00/00:00:00:00:00/f0 tag 0 pio
4096 in
[  101.719288]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[  101.748593] ata1: soft resetting link
[  102.079594] ata1.01: configured for PIO
[  102.087204] ata1.01: device reported invalid CHS sector 0
[  102.098144] ata1: EH complete
[  132.407134] ata1: drained 65536 bytes to clear DRQ
[  132.416687] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  132.430752] ata1.01: cmd 20/00:08:00:00:00/00:00:00:00:00/f0 tag 0 pio
4096 in
[  132.430752]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[  132.460168] ata1: soft resetting link
[  132.791594] ata1.01: configured for PIO
[  132.799048] ata1.01: device reported invalid CHS sector 0
[  132.810076] ata1: EH complete
[  165.175163] ata1: drained 65536 bytes to clear DRQ
[  165.186023] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  165.200192] ata1.01: cmd 20/00:08:00:00:00/00:00:00:00:00/f0 tag 0 pio
4096 in
[  165.200192]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[  165.229531] ata1: soft resetting link


Can anyone suggest why I am getting the above errors?

Thanks,
Sachin.



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
