Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 833952C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 18:12:30 +1000 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: SATA hang on 8315E triggered by heavy flash write?
From: Anthony Foiani <tkil@scrye.com>
Date: Wed, 15 May 2013 02:12:21 -0600
Message-ID: <gsj1oirve.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Greetings.

We're using a board derived from the MPC8315E.  Fairly regularly, the
SATA connection will freeze up while we are writing to flash memory:

  [  839.806884] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x6 frozen
  [  839.814201] ata2.00: failed command: WRITE DMA
  [  839.818814] ata2.00: cmd ca/00:08:58:95:21/00:00:00:00:00/e1 tag 0 dma 4096 out
  [  839.818838]          res 50/00:00:98:00:18/00:00:00:00:00/e1 Emask 0x10 (ATA bus error)
  [  839.834222] ata2.00: status: { DRDY }
  [  839.838046] ata2: hard resetting link
  [  839.867942] ata2: setting speed (in hard reset)
  [  849.959859] ata2: No Signature Update
  [  850.131872] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [  850.138219] ata2.00: link online but device misclassified
  [  855.143882] ata2.00: qc timeout (cmd 0xec)
  [  855.148144] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  [  855.154375] ata2.00: revalidation failed (errno=-5)
  [  855.159376] ata2: hard resetting link
  [  855.659847] ata2: Hardreset failed, not off-lined 0
  [  855.671839] ata2: setting speed (in hard reset)
  [  865.259851] ata2: No Signature Update
  ...

The previous times I saw this, it would eventually recover, and our
device would keep on working correctly.  

However, now that we're doing many more operations per second, it
seems that it doesn't have time to recover, and we get a permanent error:

  [  925.883824] ata2: No Signature Update
  [  926.055893] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [  926.062236] ata2.00: link online but device misclassified
  [  926.067846] ata2: EH complete
  [  926.071337] sd 1:0:0:0: [sda] Unhandled error code
  [  926.076283] sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
  [  926.082758] sd 1:0:0:0: [sda] CDB: cdb[0]=0x2a: 2a 00 01 21 95 58 00 00 08 00
  [  926.090150] end_request: I/O error, dev sda, sector 18978136
  [  926.096132] sd 1:0:0:0: [sda] Unhandled error code
  [  926.101037] sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
  [  926.107504] sd 1:0:0:0: [sda] CDB: cdb[0]=0x2a: 2a 00 01 22 2a 00 00 00 10 00
  [  926.114894] end_request: I/O error, dev sda, sector 19016192
  [  926.120811] sd 1:0:0:0: [sda] Unhandled error code
  [  926.125719] sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
  [  926.132225] sd 1:0:0:0: [sda] CDB: cdb[0]=0x2a: 2a 00 00 00 00 08 00 00 08 00
  [  926.139545] end_request: I/O error, dev sda, sector 8
  [  926.144690] Buffer I/O error on device sda1, logical block 0
  [  926.150437] lost page write due to I/O error on sda1
  [  926.155674] sd 1:0:0:0: [sda] Unhandled error code
  [  926.160614] sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
  [  926.167073] sd 1:0:0:0: [sda] CDB: cdb[0]=0x2a: 2a 00 01 18 00 18 00 00 08 00
  [  926.174451] end_request: I/O error, dev sda, sector 18350104

And eventually I get nothing but:

  [ 1177.852326] EXT2-fs (sda1): error: read_inode_bitmap: Cannot read inode bitmap - block_group = 70, inode_bitmap = 2293761
  [ 1177.871983] EXT2-fs (sda1): previous I/O error to superblock detected
  [ 1177.872016] 
  [ 1177.880192] EXT2-fs (sda1): error: read_inode_bitmap: Cannot read inode bitmap - block_group = 70, inode_bitmap = 2293761
  [ 1177.893731] EXT2-fs (sda1): previous I/O error to superblock detected
  [ 1177.893764] 

At this point, /dev/sda is pretty much unusable, and I have to do at
least a reboot to recover.  (I don't recall if I had to do a power
cycle at this point, though.)

I suspect that it is related to errata eLBC-A001 (from MPC8315E Chip
Errata, Rev. 3, 09/2011):

  eLBC-A001:

  Simultaneous FCM and GPCM or UPM operation may erroneously trigger
  bus monitor timeout

  Description: Devices: MPC8315E, MPC8314E
  When the FCM is in the middle of a long transaction, such as NAND
  erase or write, another transaction on the GPCM or UPM triggers the
  bus monitor to start immediately for the GPCM or UPM, even though
  the GPCM or UPM is still waiting for the FCM to finish and has not
  yet started its transaction. If the bus monitor timeout value is not
  programmed for a sufficiently large value, the local bus monitor may
  time out. This timeout corrupts the current NAND Flash operation and
  terminate the GPCM or UPM operation.

  Impact: Local bus monitor may time out unexpectedly and corrupt the
  NAND transaction.

  Workaround: Set the local bus monitor timeout value to the maximum
  by setting LBCR[BMT] = 0 and LBCR[BMTPS] = 0xF.

  Fix plan: No plans to fix

But it seems that erratum is already fixed:

  http://patchwork.ozlabs.org/patch/96339/
  (git patch d08e44570e)

Am I reading that correctly?  (I'm already writing only one flash
sector at a time, but it might be that even a single 0x10000-byte
sector takes long enough to trigger the issue.)  I also verified that
I have the relevant property in my device tree:

  localbus@e0005000 {
    ...
    compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";

So, my questions are:

1. Is anyone else seeing something like this?

2. Is there an obvious way for our code to detect that we're in the
   middle of error recovery, so we can not write to the disk until
   recovery is complete?

3. Is there any chance that the 1.5Gbps limiting code might have
   exacerbated the problems?

4. Should I open a support request with Freescale, or if someone from
   Freescale is already reading this, could you look to see if anyone
   else has reported it?

Kernel is 3.4.36, cpuinfo says:

  / # cat /proc/cpuinfo
  processor       : 0
  cpu             : e300c3
  clock           : 266.666664MHz
  revision        : 2.0 (pvr 8085 0020)
  bogomips        : 66.66
  timebase        : 33333333
  platform        : MPC831x RDB
  Memory          : 256 MB

device on that SATA link is an InnoDisk SSD:

  / # dmesg | grep 'ata2'
  [    7.729684] ata2: SATA max UDMA/133 irq 45
  [    7.973996] ata2: setting speed (in hard reset)
  [    7.984849] ata2: Signature Update detected @ 0 msecs
  [    8.390553] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [    8.471244] ata2.00: ATA-8: InnoDisk Corp. - mSATA D150Q, 110520B, max UDMA/133
  [    8.478690] ata2.00: 31277232 sectors, multi 16: LBA48 
  [    8.484562] ata2.00: configured for UDMA/133

As always, any further hints would be very welcome.

Best regards,
Anthony Foiani
