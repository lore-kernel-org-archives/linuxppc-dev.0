Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 16:31:31 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/kernel/sysfs: disable writing to purr in
 non-powernv
Message-ID: <20131001063129.GF17966@concordia>
References: <1380281634-9921-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380281634-9921-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maddy,

On Fri, Sep 27, 2013 at 05:03:54PM +0530, Madhavan Srinivasan wrote:
> powerpc/kernel/sysfs.c exports purr with write permission.

PURR

> This is only valid for kernel in hypervisor mode.
> But writing to the file in PowerVM lpar causes crash.

In the kernel history/source we refer to it as "phyp". However in this
case it's not an issue with phyp, it's simply that you are not in
hypervisor mode, ie. the same crash would occur under KVM.

So you should just say "writing to the file in guest mode .."

> # echo 0 > purr
> cpu 0x0: Vector: 700 (Program Check) at [c000000000d072b0]
>     pc: c00000000001770c: .write_purr+0x1c/0x40
>     lr: c000000000017708: .write_purr+0x18/0x40
>     sp: c000000000d07530
>    msr: 8000000000049032
>   current = 0xc000000000c53de0
>   paca    = 0xc00000000ec70000	 softe: 0	 irq_happened: 0x01
>     pid   = 0, comm = swapper/0
> enter ? for help
> [c000000000d075b0] c0000000000fba64
> .generic_smp_call_function_single_interrupt+0x104/0x190
> [c000000000d07650] c000000000037748 .smp_ipi_demux+0xa8/0xf0
> [c000000000d076e0] c000000000035314 .doorbell_exception+0x74/0xb0
> [c000000000d07760] c000000000002950 doorbell_super_common+0x150/0x180
> --- Exception: a01 (Doorbell) at c000000000060904
> .plpar_hcall_norets+0x84/0xd4
> [link register   ] c00000000006dbd4 .check_and_cede_processor+0x24/0x40
> [c000000000d07a50] c000000001002558 (unreliable)
> [c000000000d07ac0] c00000000006dd0c .shared_cede_loop+0x2c/0x70
> [c000000000d07b40] c0000000006ae954 .cpuidle_enter_state+0x64/0x150
> [c000000000d07c00] c0000000006aeb30 .cpuidle_idle_call+0xf0/0x300
> [c000000000d07cb0] c000000000062fa0 .pseries_lpar_idle+0x10/0x50
> [c000000000d07d20] c000000000016d14 .arch_cpu_idle+0x64/0x150
> [c000000000d07da0] c0000000000e0060 .cpu_startup_entry+0x1a0/0x2c0
> [c000000000d07e80] c00000000000bca4 .rest_init+0x94/0xb0
> [c000000000d07ef0] c000000000b54530 .start_kernel+0x478/0x494
> [c000000000d07f90] c000000000009be0 .start_here_common+0x20/0x40
> 0:mon>
> 
> Changes:
> 
> 1)Changed the test for to hypervisor mode instead of platform

I think Ben's wrong about that.

Almost all existing code uses FW_FEATURE_LPAR to differentiate
hypervisor vs guest mode, so I think we should do the same here.

So it would be:

> +	if (cpu_has_feature(CPU_FTR_PURR)) {
> +		if (!firmware_has_feature(FW_FEATURE_LPAR))
> +			add_write_permission_dev_attr((void *)&dev_attr_purr);
>  		device_create_file(s, &dev_attr_purr);
> +	}


> +static void add_write_permission_dev_attr(void *ptr)
> +{
> +	struct device_attribute *attr = (struct device_attribute *)ptr;
> +
> +	attr->attr.mode |= (unsigned short) 0200;
> +}

Why does it take a void *, which then requires a cast at the call site?

And do you need the cast to short? If so shouldn't you use umode_t
directly?

cheers
