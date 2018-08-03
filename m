Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hWFx29L4zF2FJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 12:29:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [resend] [PATCH 0/3] powerpc/pseries: use H_BLOCK_REMOVE
In-Reply-To: <20180801115514.441eecc8@roar.ozlabs.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180801115514.441eecc8@roar.ozlabs.ibm.com>
Date: Fri, 03 Aug 2018 12:29:20 +1000
Message-ID: <87tvocgp33.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Fri, 27 Jul 2018 15:51:30 +0200
> Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>> [Resending so everyone is getting the cover letter]
>> On very large system we could see soft lockup fired when a process is exiting
>> 
>> watchdog: BUG: soft lockup - CPU#851 stuck for 21s! [forkoff:215523]
>> Modules linked in: pseries_rng rng_core xfs raid10 vmx_crypto btrfs libcrc32c xor zstd_decompress zstd_compress xxhash lzo_compress raid6_pq crc32c_vpmsum lpfc crc_t10dif crct10dif_generic crct10dif_common dm_multipath scsi_dh_rdac scsi_dh_alua autofs4
>> CPU: 851 PID: 215523 Comm: forkoff Not tainted 4.17.0 #1
>> NIP:  c0000000000b995c LR: c0000000000b8f64 CTR: 000000000000aa18
>> REGS: c00006b0645b7610 TRAP: 0901   Not tainted  (4.17.0)
>> MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22042082  XER: 00000000
>> CFAR: 00000000006cf8f0 SOFTE: 0 
>> GPR00: 0010000000000000 c00006b0645b7890 c000000000f99200 0000000000000000 
>> GPR04: 8e000001a5a4de58 400249cf1bfd5480 8e000001a5a4de50 400249cf1bfd5480 
>> GPR08: 8e000001a5a4de48 400249cf1bfd5480 8e000001a5a4de40 400249cf1bfd5480 
>> GPR12: ffffffffffffffff c00000001e690800 
>> NIP [c0000000000b995c] plpar_hcall9+0x44/0x7c
>> LR [c0000000000b8f64] pSeries_lpar_flush_hash_range+0x324/0x3d0
>> Call Trace:
>> [c00006b0645b7890] [8e000001a5a4dd20] 0x8e000001a5a4dd20 (unreliable)
>> [c00006b0645b7a00] [c00000000006d5b0] flush_hash_range+0x60/0x110
>> [c00006b0645b7a50] [c000000000072a2c] __flush_tlb_pending+0x4c/0xd0
>> [c00006b0645b7a80] [c0000000002eaf44] unmap_page_range+0x984/0xbd0
>> [c00006b0645b7bc0] [c0000000002eb594] unmap_vmas+0x84/0x100
>> [c00006b0645b7c10] [c0000000002f8afc] exit_mmap+0xac/0x1f0
>> [c00006b0645b7cd0] [c0000000000f2638] mmput+0x98/0x1b0
>> [c00006b0645b7d00] [c0000000000fc9d0] do_exit+0x330/0xc00
>> [c00006b0645b7dc0] [c0000000000fd384] do_group_exit+0x64/0x100
>> [c00006b0645b7e00] [c0000000000fd44c] sys_exit_group+0x2c/0x30
>> [c00006b0645b7e30] [c00000000000b960] system_call+0x58/0x6c
>> Instruction dump:
>> 60000000 f8810028 7ca42b78 7cc53378 7ce63b78 7d074378 7d284b78 7d495378 
>> e9410060 e9610068 e9810070 44000022 <7d806378> e9810028 f88c0000 f8ac0008
>> 
>> This happens when removing the PTE by calling the hypervisor using the
>> H_BULK_REMOVE call. This call is processing up to 4 PTEs but is doing a
>> tlbie for each PTE it is processing. This could lead to long time spent in
>> the hypervisor (sometimes up to 4s) and soft lockup being raised because
>> the scheduler is not called in zap_pte_range().
>> 
>> Since the Power7's time, the hypervisor is providing a new hcall
>> H_BLOCK_REMOVE allowing processing up to 8 PTEs with one call to
>> tlbie. By limiting the amount of tlbie generated, this reduces the time
>> spent invalidating the PTEs.
>
> Oh that's a nice feature. I must have an ancient PAPR because I don't
> have it.

The only public document is LoPAPR, which is a stripped down version of
the 2012 PAPR.

cheers
