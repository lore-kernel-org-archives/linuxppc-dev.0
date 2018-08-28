Return-Path: <srs0=hx+u=ll=linaro.org=ard.biesheuvel@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4209K71Fq6zDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 23:56:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4209K650qGz8tFt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 23:56:26 +1000 (AEST)
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4209K61GQ0z9s1x
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 23:56:24 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id 139-v6so2644997itf.0
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 06:56:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180828140632.593291cf@roar.ozlabs.ibm.com>
References: <87bm9n68gq.fsf@igel.home>
 <20180828140632.593291cf@roar.ozlabs.ibm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 28 Aug 2018 15:56:22 +0200
Message-ID: <CAKv+Gu8ROLamoxFZzbqrzSHq1cUQg5hn02HrKGB_0AT=EcBJpg@mail.gmail.com>
Subject: Re: Oops running iptables -F OUTPUT
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Jessica Yu <jeyu@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andreas, Nick,

On 28 August 2018 at 06:06, Nicholas Piggin <nicholas.piggin@gmail.com> wro=
te:
> On Mon, 27 Aug 2018 19:11:01 +0200
> Andreas Schwab <schwab@linux-m68k.org> wrote:
>
>> I'm getting this Oops when running iptables -F OUTPUT:
>>
>> [   91.139409] Unable to handle kernel paging request for data at addres=
s 0xd0000001fff12f34
>> [   91.139414] Faulting instruction address: 0xd0000000016a5718
>> [   91.139419] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   91.139426] BE SMP NR_CPUS=3D2 PowerMac
>> [   91.139434] Modules linked in: iptable_filter ip_tables x_tables bpfi=
lter nfsd auth_rpcgss lockd grace nfs_acl sunrpc tun af_packet snd_aoa_code=
c_tas snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm=
_oss snd_pcm snd_seq snd_timer snd_seq_device snd_mixer_oss snd sungem sr_m=
od firewire_ohci cdrom sungem_phy soundcore firewire_core pata_macio crc_it=
u_t sg hid_generic usbhid linear md_mod ohci_pci ohci_hcd ehci_pci ehci_hcd=
 usbcore usb_common dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log dm=
_mod sata_svw
>> [   91.139522] CPU: 1 PID: 3620 Comm: iptables Not tainted 4.19.0-rc1 #1
>> [   91.139526] NIP:  d0000000016a5718 LR: d0000000016a569c CTR: c0000000=
006f560c
>> [   91.139531] REGS: c0000001fa577670 TRAP: 0300   Not tainted  (4.19.0-=
rc1)
>> [   91.139534] MSR:  900000000200b032 <SF,HV,VEC,EE,FP,ME,IR,DR,RI>  CR:=
 84002484  XER: 20000000
>> [   91.139553] DAR: d0000001fff12f34 DSISR: 40000000 IRQMASK: 0
>> GPR00: d0000000016a569c c0000001fa5778f0 d0000000016b0400 00000000000000=
00
>> GPR04: 0000000000000002 0000000000000000 80000001fa46418e c0000001fa0d05=
c8
>> GPR08: d0000000016b0400 d00037fffff13000 00000001ff3e7000 d0000000016a6f=
b8
>> GPR12: c0000000006f560c c00000000ffff780 0000000000000000 00000000000000=
00
>> GPR16: 0000000011635010 00003fffa1b7aa68 0000000000000000 00000000000000=
00
>> GPR20: 0000000000000003 0000000010013918 00000000116350c0 c000000000b889=
90
>> GPR24: c000000000b88ba4 0000000000000000 d0000001fff12f34 00000000000000=
00
>> GPR28: d0000000016b8000 c0000001fa20f400 c0000001fa20f440 00000000000000=
00
>> [   91.139627] NIP [d0000000016a5718] .alloc_counters.isra.10+0xbc/0x140=
 [ip_tables]
>> [   91.139634] LR [d0000000016a569c] .alloc_counters.isra.10+0x40/0x140 =
[ip_tables]
>> [   91.139638] Call Trace:
>> [   91.139645] [c0000001fa5778f0] [d0000000016a569c] .alloc_counters.isr=
a.10+0x40/0x140 [ip_tables] (unreliable)
>> [   91.139655] [c0000001fa5779b0] [d0000000016a5b54] .do_ipt_get_ctl+0x1=
10/0x2ec [ip_tables]
>> [   91.139666] [c0000001fa577aa0] [c0000000006233e0] .nf_getsockopt+0x68=
/0x88
>> [   91.139674] [c0000001fa577b40] [c000000000631608] .ip_getsockopt+0xbc=
/0x128
>> [   91.139682] [c0000001fa577bf0] [c00000000065adf4] .raw_getsockopt+0x1=
8/0x5c
>> [   91.139690] [c0000001fa577c60] [c0000000005b5f60] .sock_common_getsoc=
kopt+0x2c/0x40
>> [   91.139697] [c0000001fa577cd0] [c0000000005b3394] .__sys_getsockopt+0=
xa4/0xd0
>> [   91.139704] [c0000001fa577d80] [c0000000005b5ab0] .__se_sys_socketcal=
l+0x238/0x2b4
>> [   91.139712] [c0000001fa577e30] [c00000000000a31c] system_call+0x5c/0x=
70
>> [   91.139716] Instruction dump:
>> [   91.139721] 39290040 7d3d4a14 7fbe4840 409cff98 81380000 2b890001 419=
d000c 393e0060
>> [   91.139736] 48000010 7d57c82a e93e0060 7d295214 <815a0000> 794807e1 4=
1e20010 7c210b78
>> [   91.139752] ---[ end trace f5d1d5431651845d ]---
>
> This is due to 7290d58095 ("module: use relative references for
> __ksymtab entries"). This part of kernel/module.c -
>
>    /* Divert to percpu allocation if a percpu var. */
>    if (sym[i].st_shndx =3D=3D info->index.pcpu)
>        secbase =3D (unsigned long)mod_percpu(mod);
>    else
>        secbase =3D info->sechdrs[sym[i].st_shndx].sh_addr;
>    sym[i].st_value +=3D secbase;
>
> Causes the distance to the target to exceed 32-bits on powerpc, so
> it doesn't fit in a rel32 reloc. Not sure how other archs cope.
>

Apologies for the breakage. It does indeed appear to affect all
architectures, and I'm a bit puzzled why you are the first one to spot
it.

I will try to find a clean way to special case the per-CPU variable
__ksymtab references in the generic module code, and if that is too
cumbersome, we can switch to 64-bit relative references (or rather,
native word size relative references) instead. Or revert the whole
thing ...
