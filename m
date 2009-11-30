Return-Path: <albert_herranz@yahoo.es>
Received: from smtp102.mail.ukl.yahoo.com (smtp102.mail.ukl.yahoo.com
	[77.238.184.34]) by ozlabs.org (Postfix) with SMTP id 4BB3DB7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 16:50:59 +1100 (EST)
Message-ID: <4B135D3D.9030006@yahoo.es>
Date: Mon, 30 Nov 2009 06:50:53 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>	
	<1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>
	<1259536695.2076.40.camel@pasglop>
In-Reply-To: <1259536695.2076.40.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sat, 2009-11-28 at 21:43 +0100, Albert Herranz wrote:
>> +        * Prepare again the same BAT for MMU_init.
>> +        * This allows udbg I/O to continue working after the MMU is
>> +        * turned on for real.
>> +        *
>> +        * We are assuming here that exi_io_base is identity mapped.
>> +        */
>> +       addr = ((unsigned long)exi_io_base) & 0xffff0000;
>> +       setbat(1, addr, addr, 128*1024, PAGE_KERNEL_NCG); 
> 
> How do you prevent that from overlapping otherwise valid kernel
> mappings ?
> 

ug_udbg_init() is called from ppc_md.init_early.
It doesn't overlap any valid kernel mappings because exi_io_base is hardcoded to an i/o region not used yet by the kernel.
See udbg_early_grab_exi_io_base().

The setbat just prepares again, exactly in the same way, the same BAT that we got setup by setup_usbgecko_bat in head_32.S.

_start
__start
> early_init
> mmu_off
# mmu off
> clear_bats
> flush_tlbs
> initial_bats
> setup_usbgecko_bat <--- BAT1 setup here
> call_setup_cpu
> init_idle_6xx
! relocate_kernel
! turn_on_mmu
# mmu on
! start_here
> machine_init
>> udbg_early_init
>>> udbg_init_usbgecko <--- BAT1 prepared again here for after MMU_init
>> early_init_devtree
> __save_cpu_setup
> MMU_init
# mmu off
> load_up_mmu
# mmu on
! start_kernel

> You need to allocate the virtual space. For a debug thing like that, you
> could use the fixmap. In fact, I think we should create a fixmap entry
> or two always available for use by early debug.
> 

Or give us back ppc_md.setup_io_mappings :)

> Cheers,
> Ben.
> 

Thanks,
Albert
