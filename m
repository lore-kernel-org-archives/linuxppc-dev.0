Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A21A967B8C
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 11:30:58 +1000 (EST)
Date: Sun, 20 Aug 2006 03:31:21 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060820013121.GA2732@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E6D634.3000207@s5r6.in-berlin.de>
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Stefan

Thanks a lot for your very detailed explanations of the 1394
et al. drivers. It helps me a lot ...    

On Sat, Aug 19, 2006 at 11:13:24AM +0200, Stefan Richter wrote:


                        [ ... ]
> 
> If you have got the TiBook around, you could connect it with the AlBook 
> and look what gscanbus or OS X's system profiler have to say about it. 
> If possible, also try the TiBook in target disk mode and see if it 
> appears as a disk for Linux' sbp2 or under OS X.

I tested this, not on OSX, but Linux:
Target disk mode works excellent on the new Powerbook5,8 (alubook): I
booted the old TitaniumIV (tibook) -- connected via the FW cable to
the alubook -- in target disk mode. Very quickly after the tibook
started I was asked by KDE on the alubook what to do with the newly
detected disks. And some news icons appeared on the KDE desktop, 2 of
them correctly representing the 2 main partitions on the tibook.


Here's /var/log/kern.log on the alubook, at about the time when I
started the tibook in target disk mode


------------------------------------
Aug 20 02:04:18 debby1-6 kernel: [ 8644.941230] ieee1394: Node changed: 0-01:1023 -> 0-00:1023
Aug 20 02:04:18 debby1-6 kernel: [ 8644.941295] ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[000393fffecde4c4]
Aug 20 02:04:27 debby1-6 kernel: [ 8653.484415] ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[000393fffecde4c4]
Aug 20 02:04:27 debby1-6 kernel: [ 8653.484580] ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Aug 20 02:05:53 debby1-6 kernel: [ 8740.212617] PM: Removing info for ieee1394:000393fffecde4c4-0
Aug 20 02:06:00 debby1-6 kernel: [ 8746.315023] PM: Adding info for ieee1394:000393fffecde4c4-0
Aug 20 02:06:00 debby1-6 kernel: [ 8746.315180] scsi1 : SBP-2 IEEE-1394
Aug 20 02:06:00 debby1-6 kernel: [ 8746.315199] PM: Adding info for No Bus:host1
Aug 20 02:06:01 debby1-6 kernel: [ 8747.416987] ieee1394: sbp2: Logged into SBP-2 device
Aug 20 02:06:01 debby1-6 kernel: [ 8747.417194] ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
Aug 20 02:06:01 debby1-6 kernel: [ 8747.417232] PM: Adding info for No Bus:target1:0:0
Aug 20 02:06:01 debby1-6 kernel: [ 8747.417738]   Vendor: AAPL      Model: FireWire Target   Rev: 0000
Aug 20 02:06:01 debby1-6 kernel: [ 8747.417767]   Type:   Direct-Access-RBC                  ANSI SCSI revision: 03
Aug 20 02:06:01 debby1-6 kernel: [ 8747.417791] PM: Adding info for scsi:1:0:0:0
Aug 20 02:06:01 debby1-6 kernel: [ 8747.485838] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
Aug 20 02:06:01 debby1-6 kernel: [ 8747.486345] sda: Write Protect is off
Aug 20 02:06:01 debby1-6 kernel: [ 8747.486354] sda: Mode Sense: 00 00 00 00
Aug 20 02:06:01 debby1-6 kernel: [ 8747.486774] sda: asking for cache data failed
Aug 20 02:06:01 debby1-6 kernel: [ 8747.486781] sda: assuming drive cache: write through
Aug 20 02:06:01 debby1-6 kernel: [ 8747.487400] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
Aug 20 02:06:01 debby1-6 kernel: [ 8747.487721] sda: Write Protect is off
Aug 20 02:06:01 debby1-6 kernel: [ 8747.487728] sda: Mode Sense: 00 00 00 00
Aug 20 02:06:01 debby1-6 kernel: [ 8747.488150] sda: asking for cache data failed
Aug 20 02:06:01 debby1-6 kernel: [ 8747.488156] sda: assuming drive cache: write through
Aug 20 02:06:01 debby1-6 kernel: [ 8747.488437]  sda: [mac] sda1 sda2 sda3 sda4 sda5
Aug 20 02:06:01 debby1-6 kernel: [ 8747.492435] sd 1:0:0:0: Attached scsi disk sda
--------------------------------------

So at least it looks now as if the Firewire 400 Hardware on the
alubook is not broken. Correct? Would be a great relief as I hate it
to have it away at the repair service.

I could mount the 2 tibook partitions easily on the alubook.

On the alubook:
-----------------------------------------
# mount
/dev/hda7 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda6 on /home type ext3 (rw)
/dev/hda5 on /var type ext3 (rw)
tmpfs on /dev type tmpfs (rw,size=10M,mode=0755)
nfsd on /proc/fs/nfsd type nfsd (rw)
rpc_pipefs on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
/dev/sda4 on /media/usbdisk type ext3 (rw,noexec,nosuid,nodev)
/dev/sda5 on /media/usbdisk-1 type ext3 (rw,noexec,nosuid,nodev)
-------------------------------- 

sd4/sda5 must be the 2 main partitions on the tibook ..

I mounted them, and a few seconds after unmounting them this must have
been the corresponding kern.log:

-------------------------------------------  
Aug 20 03:05:20 debby1-6 kernel: [12306.976988] ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
Aug 20 03:05:20 debby1-6 kernel: [12306.977004] ieee1394: sbp2: Failed to reconnect to sbp2 device!
Aug 20 03:05:20 debby1-6 kernel: [12306.977410] PM: Removing info for scsi:1:0:0:0
Aug 20 03:05:20 debby1-6 kernel: [12306.977482] PM: Removing info for No Bus:target1:0:0
Aug 20 03:05:20 debby1-6 kernel: [12306.977558] PM: Removing info for No Bus:host1
Aug 20 03:05:20 debby1-6 kernel: [12307.233256] ieee1394: Node changed: 0-01:1023 -> 0-00:1023
Aug 20 03:05:20 debby1-6 kernel: [12307.233324] ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[000393fffecde4c4]
--------------------------------------------


OTOH: Connecting the alubook and tibook with Linux up and running on
both machines did not create a working (FW) connection between them ..
I'll try the latter later again -- even perhaps with OSX on the
alubook and Linux on the tibook ...

> 
> The fact that Linux on the AlBook gets at least as far as "ieee1394: 
> Error parsing configrom for node 0-00:1023" indicates that not all hope 
> is lost. If you have got the time, compile the 1394 drivers for verbose 
> logging and send the log. Don't crosspost the log if it gets too big.

I'll compile a fresh git kernel next week, Tuesday or Wednesday, with
verbose logging for the 1394 drivers. And I'll put the corresponding
logs for the 1394 tests on my homepage instead of sending them via
email anywhere, only the URL's for the logs will be sent in my
messages. Please let me know if you disagree ...

BTW: Do you know how to switch off verbose logging for the 1394
drivers once they're compiled into the kernel, via some
echo  "<some-value>" to /sys/*/* ?
I didn't find any entry there until now for that purpose ...

Until then, and thanks a lot for your time.

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
