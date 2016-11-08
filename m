Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD5Lc1kXQzDvQF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 10:36:56 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so21215792pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 15:36:56 -0800 (PST)
Subject: Re: [PATCH] powerpc/powernv: Initialise nest mmu
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1471243919-18362-1-git-send-email-alistair@popple.id.au>
 <35949087.yEIrgECls7@new-mexico>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <010187f5-a26d-1d5c-0bdd-50695598d4ff@gmail.com>
Date: Wed, 9 Nov 2016 10:36:49 +1100
MIME-Version: 1.0
In-Reply-To: <35949087.yEIrgECls7@new-mexico>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/09/16 15:02, Alistair Popple wrote:
> On Mon, 15 Aug 2016 04:51:59 PM Alistair Popple wrote:
>> POWER9 contains an off core mmu called the nest mmu (NMMU). This is
>> used by other hardware units on the chip to translate virtual
>> addresses into real addresses. The unit attempting an address
>> translation provides the majority of the context required for the
>> translation request except for the base address of the partition table
>> (ie. the PTCR) which needs to be programmed into the NMMU.
>>
>> This patch adds a call to OPAL to set the PTCR for the nest mmu in
>> opal_init().
>>
>> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>> ---
>>
>> This patch depends on a new OPAL call which has yet to be added to
>> skiboot, although the patch to do so has been posted to
>> http://patchwork.ozlabs.org/patch/659106/
> 
> This has now gone into skiboot with the same OPAL call number :-
> https://github.com/open-power/skiboot/commit/84e63a8d4fd9eb3efc872099d579c49fef6a5810
> 
>>  arch/powerpc/include/asm/opal-api.h            | 3 ++-
>>  arch/powerpc/include/asm/opal.h                | 1 +
>>  arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
>>  arch/powerpc/platforms/powernv/opal.c          | 3 +++
>>  4 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index 0e2e57b..a0aa285 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -167,7 +167,8 @@
>>  #define OPAL_INT_EOI				124
>>  #define OPAL_INT_SET_MFRR			125
>>  #define OPAL_PCI_TCE_KILL			126
>> -#define OPAL_LAST				126
>> +#define OPAL_NMMU_SET_PTCR			127
>> +#define OPAL_LAST				127
>>
>>  /* Device tree flags */
>>
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index ee05bd2..433df5e 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -228,6 +228,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
>>  int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
>>  			     uint32_t pe_num, uint32_t tce_size,
>>  			     uint64_t dma_addr, uint32_t npages);
>> +int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
>>
>>  /* Internal functions */
>>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> index 3d29d40..a955649 100644
>> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
>> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> @@ -308,3 +308,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
>>  OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
>>  OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
>>  OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
>> +OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 8b4fc68..b533245 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -762,6 +762,9 @@ static int __init opal_init(void)
>>  	/* Initialise OPAL kmsg dumper for flushing console on panic */
>>  	opal_kmsg_init();
>>
>> +	/* Update partition table control register on all Nest MMUs */
>> +	opal_nmmu_set_ptcr(-1UL, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
>> +
>>  	return 0;
>>  }
>>  machine_subsys_initcall(powernv, opal_init);
>> --
>> 2.1.4
> 

We might need some kexec changes as well, but for this patch

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
