Return-Path: <srs0=7bmb=lm=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420WLL6FHbzF2QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 13:28:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 420WLL4BSWz8wNc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 13:28:42 +1000 (AEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 420WLK1wnHz9s3C
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 13:28:40 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id b12-v6so1651989plr.8
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 20:28:40 -0700 (PDT)
Date: Wed, 29 Aug 2018 13:28:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Jessica Yu <jeyu@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, Ingo Molnar
 <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch
 <linux-arch@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: Oops running iptables -F OUTPUT
Message-ID: <20180829132827.6dbc4352@roar.ozlabs.ibm.com>
In-Reply-To: <20180828140632.593291cf@roar.ozlabs.ibm.com>
References: <87bm9n68gq.fsf@igel.home>
 <20180828140632.593291cf@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2018 14:06:32 +1000
Nicholas Piggin <nicholas.piggin@gmail.com> wrote:

> On Mon, 27 Aug 2018 19:11:01 +0200
> Andreas Schwab <schwab@linux-m68k.org> wrote:
> 
> > I'm getting this Oops when running iptables -F OUTPUT:
> > 
> > [   91.139409] Unable to handle kernel paging request for data at address 0xd0000001fff12f34
> > [   91.139414] Faulting instruction address: 0xd0000000016a5718
> > [   91.139419] Oops: Kernel access of bad area, sig: 11 [#1]
> > [   91.139426] BE SMP NR_CPUS=2 PowerMac
> > [   91.139434] Modules linked in: iptable_filter ip_tables x_tables bpfilter nfsd auth_rpcgss lockd grace nfs_acl sunrpc tun af_packet snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm_oss snd_pcm snd_seq snd_timer snd_seq_device snd_mixer_oss snd sungem sr_mod firewire_ohci cdrom sungem_phy soundcore firewire_core pata_macio crc_itu_t sg hid_generic usbhid linear md_mod ohci_pci ohci_hcd ehci_pci ehci_hcd usbcore usb_common dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_mod sata_svw
> > [   91.139522] CPU: 1 PID: 3620 Comm: iptables Not tainted 4.19.0-rc1 #1
> > [   91.139526] NIP:  d0000000016a5718 LR: d0000000016a569c CTR: c0000000006f560c
> > [   91.139531] REGS: c0000001fa577670 TRAP: 0300   Not tainted  (4.19.0-rc1)
> > [   91.139534] MSR:  900000000200b032 <SF,HV,VEC,EE,FP,ME,IR,DR,RI>  CR: 84002484  XER: 20000000
> > [   91.139553] DAR: d0000001fff12f34 DSISR: 40000000 IRQMASK: 0 
> > GPR00: d0000000016a569c c0000001fa5778f0 d0000000016b0400 0000000000000000 
> > GPR04: 0000000000000002 0000000000000000 80000001fa46418e c0000001fa0d05c8 
> > GPR08: d0000000016b0400 d00037fffff13000 00000001ff3e7000 d0000000016a6fb8 
> > GPR12: c0000000006f560c c00000000ffff780 0000000000000000 0000000000000000 
> > GPR16: 0000000011635010 00003fffa1b7aa68 0000000000000000 0000000000000000 
> > GPR20: 0000000000000003 0000000010013918 00000000116350c0 c000000000b88990 
> > GPR24: c000000000b88ba4 0000000000000000 d0000001fff12f34 0000000000000000 
> > GPR28: d0000000016b8000 c0000001fa20f400 c0000001fa20f440 0000000000000000 
> > [   91.139627] NIP [d0000000016a5718] .alloc_counters.isra.10+0xbc/0x140 [ip_tables]
> > [   91.139634] LR [d0000000016a569c] .alloc_counters.isra.10+0x40/0x140 [ip_tables]
> > [   91.139638] Call Trace:
> > [   91.139645] [c0000001fa5778f0] [d0000000016a569c] .alloc_counters.isra.10+0x40/0x140 [ip_tables] (unreliable)
> > [   91.139655] [c0000001fa5779b0] [d0000000016a5b54] .do_ipt_get_ctl+0x110/0x2ec [ip_tables]
> > [   91.139666] [c0000001fa577aa0] [c0000000006233e0] .nf_getsockopt+0x68/0x88
> > [   91.139674] [c0000001fa577b40] [c000000000631608] .ip_getsockopt+0xbc/0x128
> > [   91.139682] [c0000001fa577bf0] [c00000000065adf4] .raw_getsockopt+0x18/0x5c
> > [   91.139690] [c0000001fa577c60] [c0000000005b5f60] .sock_common_getsockopt+0x2c/0x40
> > [   91.139697] [c0000001fa577cd0] [c0000000005b3394] .__sys_getsockopt+0xa4/0xd0
> > [   91.139704] [c0000001fa577d80] [c0000000005b5ab0] .__se_sys_socketcall+0x238/0x2b4
> > [   91.139712] [c0000001fa577e30] [c00000000000a31c] system_call+0x5c/0x70
> > [   91.139716] Instruction dump:
> > [   91.139721] 39290040 7d3d4a14 7fbe4840 409cff98 81380000 2b890001 419d000c 393e0060 
> > [   91.139736] 48000010 7d57c82a e93e0060 7d295214 <815a0000> 794807e1 41e20010 7c210b78 
> > [   91.139752] ---[ end trace f5d1d5431651845d ]---  
> 
> This is due to 7290d58095 ("module: use relative references for
> __ksymtab entries"). This part of kernel/module.c -
> 
>    /* Divert to percpu allocation if a percpu var. */
>    if (sym[i].st_shndx == info->index.pcpu)
>        secbase = (unsigned long)mod_percpu(mod);
>    else
>        secbase = info->sechdrs[sym[i].st_shndx].sh_addr;
>    sym[i].st_value += secbase;
> 
> Causes the distance to the target to exceed 32-bits on powerpc, so
> it doesn't fit in a rel32 reloc. Not sure how other archs cope.

Any progress on this one? I had a bit of a look but can't see a really
trivial fix and don't have a lot of time to work on it. Maybe use 64
bit relative offsets for per-cpu exports, or better might be apply the
per-cpu fixup when linking against the symbol rather than when writing
the module symbol table.

Until then I'd like to just remove HAVE_ARCH_PREL32_RELOCATIONS from
powerpc/Kconfig, but if other archs are going to have issues too, we
could just revert

271ca788774aa ("arch: enable relative relocations for arm64, power and x86")

arm64, x86 -- can the distance between your module percpu data link
location -> module percpu runtime allocation location exceed 31 bits?

Thanks,
Nick
