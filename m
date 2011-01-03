Return-Path: <htejun@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by ozlabs.org (Postfix) with ESMTP id A8832B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 00:59:34 +1100 (EST)
Received: by bwz10 with SMTP id 10so6720669bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 05:59:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 3 Jan 2011 14:59:29 +0100
From: Tejun Heo <tj@kernel.org>
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
Message-ID: <20110103135929.GO18831@htj.dyndns.org>
References: <201101031445.47922.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201101031445.47922.roman.fietze@telemotive.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 03, 2011 at 02:45:47PM +0100, Roman Fietze wrote:
> Hello,
> 
> When merging more recent kernel versions, tried that using v2.6.35 and
> v2.6.36, into our tree (branched at v2.6.34), I detected, that MWDMA2
> on the HW listed in the subject does no longer work.
> 
> So I bisected that using the original, standard kernel tree using a
> minimum config using
> 
>    git bisect start v2.6.35 v2.6.34
> 
> The final result is:
> 
> 360ff7833098e944e5003618b03894251e937802 is the first bad commit
> commit 360ff7833098e944e5003618b03894251e937802
> Author: Tejun Heo <tj@kernel.org>
> Date:   Mon May 10 21:41:42 2010 +0200
> 
>     libata-sff: separate out BMDMA qc_issue
> 
> ...
> 
> 
> I double checked the failure with the latest torvalds/master as well
> (b518a64983cbf2ff31), still the same issue.
> 
> The HW is an own board very close to the original Freescale
> Lite5200/Lite5200B. The relevant part of the device tree source file
> contains "mwdma-mode = <2>;" inside the ata section.
> 
> In the bad case the log always shows (the exact drive or drive type
> doesn't matter, double checked):
> 
> [    1.553501] ata1.00: ATA-5: HEJ423020F9AT00, 00MJA0A0, max UDMA/100
> [    1.560003] ata1.00: 39070080 sectors, multi 0: LBA 
> [    1.581418] ata1.00: configured for MWDMA2
> [    1.586644] scsi 0:0:0:0: Direct-Access     ATA      HEJ423020F9AT00  00MJ PQ: 0 ANSI: 5
> [    1.597831] sd 0:0:0:0: [sda] 39070080 512-byte logical blocks: (20.0 GB/18.6 GiB)
> [    1.606876] sd 0:0:0:0: [sda] Write Protect is off
> [    1.611907] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.617627] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.629423]  sda:
> [    1.631702] ------------[ cut here ]------------
> [    1.636613] Badness at /home/fietze/src/linux-2.6-telemotive/drivers/ata/libata-sff.c:1466
> [    1.645047] NIP: c01ae650 LR: c01ae624 CTR: c01accbc
> [    1.650115] REGS: c7955b30 TRAP: 0700   Not tainted  (2.6.34-rc7-obelix)
> [    1.656948] MSR: 00021032 <ME,CE,IR,DR>  CR: 24008084  XER: 00000000
> [    1.663452] TASK = c78f2490[784] 'async/0' THREAD: c7954000
> [    1.668957] GPR00: 00000001 c7955be0 c78f2490 00000050 c904aa78 00000001 00000000 00000000 
> [    1.677497] GPR08: 00000000 c034ee50 00000000 00000000 44008082 1001a7f0 c7955f68 07fb2938 
> [    1.686037] GPR16: c78a8000 07fb2914 07f3f64c c0340000 c031ed00 c78a8000 00000000 c0010adc 
> [    1.694577] GPR24: c7842820 00000002 c7949428 c7948000 00000003 00000000 c7948000 c794809c 
> [    1.703321] NIP [c01ae650] ata_sff_qc_issue+0x74/0x248
> [    1.708564] LR [c01ae624] ata_sff_qc_issue+0x48/0x248
> [    1.713712] Call Trace:
> [    1.716211] [c7955be0] [c01ae624] ata_sff_qc_issue+0x48/0x248 (unreliable)

Which driver is it?  You probably now want to use ata_bmdma_qc_issue()
instead of ata_sff_qc_issue() (or inherit from ata_bmdma_port_ops
instead of ata_sff_port_ops) as sff doesn't deal with BMDMA anymore.
The commit you bisected to contains all those conversions too.  Take a
look at a similar driver and look at how it has been converted
recently.  Even better, just send the driver upstream.  :-)

Good luck.

-- 
tejun
