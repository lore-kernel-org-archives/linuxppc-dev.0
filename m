Return-Path: <SRS0+c0e06a779411090cd6fe+1290+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A505DDE39
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 12:18:23 +1100 (EST)
Subject: Re: PROBLEM: 2.6.20-1 not working on ibook g4 (BUG/Oops)
From: David Woodhouse <dwmw2@infradead.org>
To: francesco foresti <frafore@tiscali.it>
In-Reply-To: <200703051414.15802.frafore@tiscali.it>
References: <200703051414.15802.frafore@tiscali.it>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 01:18:14 +0000
Message-Id: <1173143894.3461.240.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-05 at 14:13 +0100, francesco foresti wrote:
> Hi,
> i'm having problems trying to use 2.6.20-1 (taken from kernel.org, not 
> patched) on my ibook g4 (debian testing/unstable): 
> i'm getting two errors while trying to boot up, and i can only report the 
> second one because the other slips offscreen before i can see what's going 
> on. However, this is what i have been able to hand-copy:
>  
> kernel BUG at mm/slab.c:610!
> Oops: Exception in kernel mode, sig: 5 [#2]
> 
> Modules linked in: snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa 
> snd_aoa_i2sbus snd_pcm_oss snd_mixer_oss snd_pcm appletouch
> snd_timer snd_page_alloc snd soundcore snd_aoa_soundbus uninorth_agp agpgart 
> eth1394 evdev ext3 jbd mbcache dm_mirror dm_snapshot
> dm_mod usbhid ff_memless ide_cd cdrom ide_disk sungem sungem_phy ohci1394 
> ieee1394 ehci_hcd ohci_hcd usbcore i2c_powermac
> NIP: C007B5A4 LR: C007B740 CTR: 00000000
> REGS: effc7e50 TRAP: 0700  Not tainted  (2.6.20.1-powerpc)
> MSR: 00021032 <ME,IR,DR>  CR: 42000048 XER: 00000000
> TASK effc0bf0[3] 'events/0' THREAD: effc6000
> GPR00: 00000001 EFFC7F00 EFFC0BF0 EFFEE6E0 C0B1E008 00000000 00000000 00000000
> GPR08: C1D093Bc 00004000 FFFFFFF4 C031E000 00000000 00000000 00000000 00000000
> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 0164B230 41400000
> GPR24: 00000000 00311000 EFFF6920 00000018 00000000 00000000 C1C96A10 EFFEE6E0
> NIP [C007b5a4] free_block+0x5c/0x160
> LR [C007B740] drain_array+0x98/0xd8
> Call Trace:
> [EFFC7F00] [00000001] 0x1 (unreliable)
> [EFFC7F20] [C007B740] drain_array+0x98/0xd8
> [EFFC7F40] [C007CE0C] cache_reap+0x40/0x128
> [EFFC7F50] [C003E2C8] run_workqueue+0xb4/0x15c
> [EFFC7F70] [C003EB10] worker_thread+0x124/0x15c
> [EFFC7FC0] [C00423FC] kthread+0xc4/0x100
> [EFFC7FF0] [C0013998] kernel_thread+0x44/0x60
> Instruction dump:
> 3d20c02e 81692688 3d254000 5529c9f4 7c09582e 7c895a14 70094000 41a20008
> 8084000c 80040000 5400cffe <0f000000> 80e4001c 5789103a 3c000010

I've been seeing very similar behaviour with 2.6.20 on all pmac32
hardware. I haven't yet tried hard to reproduce on non-pmac.

-- 
dwmw2
