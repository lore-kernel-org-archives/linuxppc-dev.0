Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id E1C1EDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 08:53:21 +1100 (EST)
Date: Thu, 20 Dec 2007 15:47:05 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: Oops: Kernel access of bad area
Message-ID: <20071220214705.GA28696@localdomain>
References: <alpine.DEB.0.99999.0712192301220.6696@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.0.99999.0712192301220.6696@sheep.housecafe.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Kujau wrote:
> Hi,
> 
> I started some x11 application (here: firefox) through an ssh connection 
> on a remote host and it crashed somehow. OK, no biggie, killed the 
> application and be done with it. However, I noticed that the load of the 
> machine is now constantly at 7. It's an iBook G4, has nothing to do, 
> disks, cpu, netwokr is idle and load is usually < 1. Now it's not
> slow to work or anyhow sluggish, but only the load is at 7 after the 
> application crashed. When I looked into dmesg I saw:
> 
> [84983.750977] Unable to handle kernel paging request for data at address 0x4815d000
> [84983.751046] Faulting instruction address: 0xc0012090
> [84983.751157] Oops: Kernel access of bad area, sig: 11 [#1]
> [84983.751178] PREEMPT PowerMac
> [84983.751214] Modules linked in: nls_iso8859_15 nls_cp850 vfat fat isofs nls_base zlib_inflate radeon drm snd_powermac snd_pcm snd_timer snd soundcore snd_page_alloc fuse firewire_ohci firewire_core crc_itu_t ide_cd cdrom ssb bcm43xx rng_core ieee80211softmac uninorth_agp ieee80211 ieee80211_crypt agpgart
> [84983.751750] NIP: c0012090 LR: c00165fc CTR: 00000080
> [84983.751786] REGS: cea65b30 TRAP: 0300   Not tainted  (2.6.24-rc5)
> [84983.751805] MSR: 00009032 <EE,ME,IR,DR>  CR: 24822282  XER: 00000000
> [84983.751946] DAR: 4815d000, DSISR: 40000000
> [84983.751965] TASK = ee372670[9138] 'firefox-bin' THREAD: cea64000
> [84983.751984] GPR00: e62b3a00 cea65be0 ee372670 4815d000 00000080 1bc0c181 4815d000 ffffffff
> [84983.752148] GPR08: 00010008 e62b3a00 00000000 c045f000 24822288 1002ea3c cea67690 ce954000
> [84983.752315] GPR16: c0420000 c03f6400 cea65cac cea65ca8 c0440000 ce974480 c07d7180 ceba2280
> [84983.752468] GPR24: e62b3a00 e62b3a50 4815d000 00000574 ceba2280 4815d000 1bc0c181 c07d7180
> [84983.752665] NIP [c0012090] __flush_dcache_icache+0x14/0x40
> [84983.752716] LR [c00165fc] update_mmu_cache+0x11c/0x120

Better to include the full stack trace in such reports, but here it
is:

 NIP [c0012090] __flush_dcache_icache+0x14/0x40
 LR [c00165fc] update_mmu_cache+0x11c/0x120
 Call Trace:
 [cea65be0] [ce8c1000] 0xce8c1000 (unreliable)
 [cea65c00] [c0075868] handle_mm_fault+0x39c/0x7f8
 [cea65c50] [c0075dec] get_user_pages+0x128/0x398
 [cea65ca0] [c00c5e18] elf_core_dump+0xb64/0xc28
 [cea65d40] [c0091e64] do_coredump+0x754/0x788
 [cea65e50] [c003cb20] get_signal_to_deliver+0x2dc/0x3fc
 [cea65e80] [c000a678] do_signal+0x48/0x28c
 [cea65f40] [c0012cb4] do_user_signal+0x74/0xc4
 --- Exception: c00 at 0xfd36ea4
     LR = 0x10012018
 Instruction dump:
 4d820020 7c8903a6 7c001bac 38630020 4200fff8 7c0004ac 4e800020 60000000
 54630026 38800080 7c8903a6 7c661b78 <7c00186c> 38630020 4200fff8 7c0004ac

So it looks like the kernel oopsed while firefox was dumping core,
yuck.

> This is the first time that this happened on this iBook, and it was not 
> reproducible so far (well, it happened just a few minutes ago). Is this 
> something to worry about? Or should I file this under "well, shit 
> happens"?

It's a real bug.  Hopefully someone on the list can help...
