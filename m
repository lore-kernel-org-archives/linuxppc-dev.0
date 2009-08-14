Return-Path: <olivier.croset@actis-computer.com>
Received: from romulan2.deckpoint.ch (romulan3.deckpoint.ch [194.38.160.11])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 36B54B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 21:05:05 +1000 (EST)
Received: from Labo5 (47-254.104-92.cust.bluewin.ch [92.104.254.47])
	by romulan2.deckpoint.ch (DeckMail) with ESMTP id 2B2DA6CC3E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 12:49:51 +0200 (CEST)
From: "Olivier Croset" <olivier.croset@actis-computer.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [SATA] Does SATA work with kernel > v2.6.25.7?
Date: Fri, 14 Aug 2009 12:49:32 +0200
Message-ID: <AA253FF7C15741BCAE4B5D4B4FFF16B6@Labo5>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everybody,

I'm working on a custom board with a Freescale 8347 CPU and a Silicon Image
SIL3512 SATA controller, which is on the PCI bus.

SATA is working with 2.6.22 but no more with 2.6.30.4. I tried different
parameters in the kernel configuration with no success. I got the following
output when Linux boots:

<snip>
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 160086528 512-byte hardware sectors: (81.9 GB/76.3 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda:<6>ata2: SATA link down (SStatus 0 SControl 310)
IP-Config: Complete:
     device=eth1, addr=192.0.0.238, mask=255.255.255.0, gw=192.0.0.128,
     host=xcom9347, domain=, nis-domain=(none),
     bootserver=192.0.0.64, rootserver=192.0.0.64, rootpath=
PHY: mdio@e0024520:09 - Link is Up - 100/Half
ata1: lost interrupt (Status 0x50)
sd 0:0:0:0: [sda] Unhandled error code
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x06
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ata1: lost interrupt (Status 0x50)
sd 0:0:0:0: [sda] Unhandled error code
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x06
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
<snip>

Then, I can see /dev/sda but not /dev/sda1 (the partition actually exists).
I can get hard drive informations with hdparm -i and -I.

While browsing the web, I found the following message with the same kind of
errors:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-03/msg08159.html

It is said that "the sata is only supported up to 2.6.25.7". Is it true for
all PowerPCs or only for 460EX CPU?

If SATA should work with 2.6.30.4, may I ask you to take a look to my config
file? (http://pastebin.com/f16067607)


Thanks,

Olivier
