Mime-Version: 1.0
Message-Id: <p05100300b9ebaedd46a7@[192.168.0.8]>
Date: Mon, 4 Nov 2002 00:00:57 -0500
To: <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: Sonnet G4 800 in 1st gen PCI mac + linux ...
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have installed the Sonnet G4/800 in my PTP (9500). Here's a
preliminary report, using BootX 1.2.2.

The PowerLogix G3/G4 cache utility will not work on this card, and
neither of course will BootX's GrabG3CacheSetting utility, so I used
GrabL2CacheSetting from the XPostFacto utilities (go to
OWC/XPostFacto) to find that my cache setting is 0x80000000. I used
ResEdit to change to this from the old G3 value in my BootX Settings.

I have tried 2 kernels: 2.4.20-pre9-ben0, and 2.4.20-rc1. On both I
note that I can no longer boot from MacOS. Launching Linux by
launching BootX after MacOS is booted yields a black screen with no
output and no disk activity. So apparently, unlike older setups, I
speculate that if the Sonnet driver has already loaded, BootX cannot
launch Linux. I note that part of the Sonnet installation is an nvram
patch. I'm not sure, but I think this is applied only once, not at
every boot. Can anyone confirm this?

However, I can boot Linux if it is done with the BootX extension at
boot time, which loads before the Sonnet extension. Things work best
with 2.4.20-rc1:

[root]#cat /proc/cpuinfo
cpu		: 7455, altivec supported
clock		: 195MHz
revision	: 2.1 (pvr 8001 0201)
bogomips	: 799.53
machine		: Power Macintosh
motherboard	: AAPL,9500 MacRISC
detected as	: 16 (PowerMac 9500/9600)
pmac flags	: 00000000
memory		: 336MB
l2cr override	: 0x80000000
pmac-generation	: OldWorld

[root]#dmesg |grep L2
L2CR overriden (0x80000000), backside cache is enabled

I have run so far only in console, but have noted no problems.



With 2.4.20-pre9-ben0, I note the following things:

1. Although cpuinfo still shows 'l2cr override : 0x80000000', there is
	not dmesg line stating that the cache is enabled.

Most of the time the ben0 kernel boots; however, not always:

2. Once so far I got a hang right after 'adb: finished probe task...'
	in the boot.

3. Twice (2 separate boots) I got the following repeated over and over
	in the boot (I wrote the message in the dark and my handwriting is
	so poor that I con no longer read the part in quotes; my best
	understanding is that I wrote "rset on" :-)

	floating point "rset on" kernel (task=c03a0000,pc=c00e6880)

On *one* of the times I had this happen, after that was repeated for
many times, I got a debugger break, with this backtrace:

c00e6870
c0127f58
c0128dd8
c00e8880
c00e89e0
c02a3f78
c028a464
c028a4b0
c00041cc
c0008ef8

 From System.map for 2.4.20-pre9-ben0:

c00e67b4 T scsi_initialize_queue
c00e6800 t scsi_wait_done
c00e6840 T scsi_allocate_request
c00e68c8 T scsi_release_request
c00e6910 T scsi_allocate_device
c00e6b54 T scsi_release_command

c01277e4 t sd_open
c0127aa0 t sd_release
c0127ba8 t rw_intr
c0127de8 t check_scsidisk_media_change
c0127efc t sd_init_onedisk
c0128718 t sd_init
c0128cf8 t sd_finish
c0128f30 t sd_detect
c0128f74 t sd_attach
c0129140 T revalidate_scsidisk


I'm running a Radeon 7000 board, and all attempts to get it to run
accelerated in either 2.4.20-pre9-ben0 or 2.4.20-pre5 have failed.
I'll get back to reporting on what I have done so far.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
