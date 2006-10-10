Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3DD5A67A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 03:16:22 +1000 (EST)
Date: Tue, 10 Oct 2006 12:15:19 -0500
From: Olof Johansson <olof@lixom.net>
To: Andrew Morton <akpm@osdl.org>
Subject: BUG() in copy_fdtable() with 64K pages (2.6.19-rc1-mm1)
Message-ID: <20061010121519.447d62f8@localhost.localdomain>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Vadim Lobanov <vlobanov@speakeasy.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I keep hitting this on -rc1-mm1. The system comes up but I can't login
since login hits it.

Bisect says that fdtable-implement-new-pagesize-based-fdtable-allocator.patch is at fault.

CONFIG_PPC_64K_PAGES=y is required for it to fail, with 4K pages it's fine.

(Hardware is a Quad G5, 1GB RAM, g5_defconfig + CONFIG_PPC_64K_PAGES, defaults 
on all new options)



kernel BUG in copy_fdtable at fs/file.c:138!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=4 
Modules linked in: snd_pcm_oss snd_mixer_oss joydev snd_pcm snd_page_alloc snd_timer snd soundcore
NIP: C0000000000B926C LR: C0000000000B9210 CTR: C0000000000ADA34
REGS: c00000000f80ba60 TRAP: 0700   Not tainted  (2.6.19-rc1-mm1)
MSR: 9000000000029032 <EE,ME,IR,DR>  CR: 22002428  XER: 200FFFFF
TASK = c00000000fe38ba0[2022] 'dhclient-script' THREAD: c00000000f808000 CPU: 2
GPR00: 0000000000000001 C00000000F80BCE0 C0000000006CDCC8 C00000003F8CF880 
GPR04: 00000000000000D0 0000000042002428 0000000000004000 000000000FEC1950 
GPR08: C000000000585480 0000000000000000 C00000003FFD0480 C000000001E04200 
GPR12: 100000000000F032 C000000000585480 0000000010000000 0000000010010000 
GPR16: 0000000010002790 000000001001819D 00000000FCCDF818 0000000000000000 
GPR20: 0000000000000000 00000000FCCDF828 0000000010018790 0000000010018760 
GPR24: 00000000F7FDE6F0 C00000003F8CF800 0000000000000000 C00000003F8CF810 
GPR28: 0000000000000040 0000000000000000 C0000000005B4B00 C00000000FB511C0 
NIP [C0000000000B926C] .expand_files+0x1d4/0x34c
LR [C0000000000B9210] .expand_files+0x178/0x34c
Call Trace:
[C00000000F80BCE0] [C0000000000B91D0] .expand_files+0x138/0x34c (unreliable)
[C00000000F80BD90] [C0000000000ADAD8] .sys_dup2+0xa4/0x1ec
[C00000000F80BE30] [C00000000000871C] syscall_exit+0x0/0x40
Instruction dump:
60000000 4800000c 4bfd3609 60000000 7fe3fb78 4bfdf125 60000000 48000150 
835f0000 7f9ae040 7c101026 5400effe <0b000000> 2fbc0000 419e00a4 7b9d1828 



-Olof
