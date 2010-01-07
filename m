Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id ABC13B6F07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 14:41:25 +1100 (EST)
Date: Wed, 6 Jan 2010 19:41:05 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c_powermac: Kernel access of bad area
In-Reply-To: <20100106173745.57207520@hyperion.delvare>
Message-ID: <alpine.DEB.2.01.1001061913310.3483@bogon.housecafe.de>
References: <alpine.DEB.2.01.0912281934170.3483@bogon.housecafe.de>
	<1262079255.2173.216.camel@pasglop>
	<20100106173745.57207520@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jean,

On Wed, 6 Jan 2010 at 17:37, Jean Delvare wrote:
> I think that sysfs files creation should be moved to the end of
> probe_thermostat() and sysfs files removal should be moved to the
> beginning of remove_thermostat(). Something like the totally untested
> patch below (no ppc machine at hand):

I applied your patch to 2.6.33-rc3, and was able to unload i2c-powermac and 
then reading the files left in /sys/devices/temperatures. I even tried to 
read the non-existant files (e.g. sensor1_fan_speed, etc...), but the 
kernel just wouldn't oops :)

So the initial oops is gone - yeah!

However, the "Badness" remains when I try to modprobe i2c-powermac again:

[  442.148222] PowerMac i2c bus pmu 2 registered
[  442.148792] PowerMac i2c bus pmu 1 registered
[  442.149299] PowerMac i2c bus mac-io 0 registered
[  442.163573] adt746x: ADT7467 initializing
[  442.170072] adt746x: Lowering max temperatures from 73, 80, 109 to 67, 47, 67
[  442.176559] PowerMac i2c bus uni-n 1 registered
[  442.227115] sysfs: cannot create duplicate filename '/devices/ams'
[  442.227697] ------------[ cut here ]------------
[  442.228176] Badness at fs/sysfs/dir.c:487
[  442.228642] NIP: c00eb71c LR: c00eb71c CTR: 00000000
[  442.229117] REGS: eea0fa50 TRAP: 0700   Not tainted  (2.6.33-rc3)
[  442.229592] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 42008444  XER: 00000000
[  442.230151] TASK = eea10000[2821] 'modprobe' THREAD: eea0e000
[  442.230191] GPR00: c00eb71c eea0fb00 eea10000 0000004c 000064c6 ffffffff ffffffff 00000000 
[  442.230758] GPR08: efa71740 c03e0000 00000000 000064c6 44008428 10020390 100e0000 100df49c 
[  442.231326] GPR16: 100b54c0 100df49c 100ddd20 1018fb08 100b5340 c03e674c c03e6720 c03ea044 
[  442.231902] GPR24: 00000000 24008422 ffffffea eea0fb58 ef0e9000 ef0e9000 ef0a9ea0 ffffffef 
[  442.233187] NIP [c00eb71c] sysfs_add_one+0x94/0xc0
[  442.233695] LR [c00eb71c] sysfs_add_one+0x94/0xc0
[  442.234363] Call Trace:

I've put the whole dmesg on:

   http://nerdbynature.de/bits/2.6.33-rc2/i2c_powermac/r1/

Thanks for your time,
Christian.
-- 
BOFH excuse #168:

le0: no carrier: transceiver cable problem?
