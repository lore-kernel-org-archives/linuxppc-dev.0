Message-ID: <40C9EA31.2070408@ru.mvista.com>
Date: Fri, 11 Jun 2004 21:21:53 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Configure tweaks for SystemACE without CONFIG_XILINX_OCP
References: <27972-80808@sneakemail.com> <19720-17858@sneakemail.com>
In-Reply-To: <19720-17858@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch is OK for me.

Thanks,
Andrei

Stephen Williams wrote:
>
> Stephen Williams 612dlag102-at-sneakemail.com |PPC Linux Embedded| wrote:
>
>> In order to get CONFIG_XILINX_SYSACE to define, the unmodified
>> source requries that CONFIG_XILINX_OCP is defined. I created this
>> patch to alloc SYSACE on by board:
>
>
> I've made a patch that demonstrates what I have in mind, and
> should work in general. With this patch, a configuration can
> enable CONFIG_XILINX_OCP and enable CONFIG_XILINX_SYSACE and
> not have ppc405gpr pci setup or PIC setup messed with.
>
> Patch is relative the ppc.bkbits.net linuxppc-2.4 tree. I'm
> guessing Andrei is the authority for this aspect.
>
> --
> Steve Williams                "The woods are lovely, dark and deep.
> steve at XXXXXXXXXX           But I have promises to keep,
> http://www.XXXXXXXXXX         and lines to code before I sleep,
> http://www.picturel.com       And lines to code before I sleep."
>
>
> ------------------------------------------------------------------------
>
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/06/10 18:45:08-07:00 steve@wing.XXXXXXXXXX
> #   Condition Xilinx on-chip processor config with
> #   CONFIG_VIRTEX_II_PRO
> #
> # arch/ppc/kernel/ppc405_pci.c
> #   2004/06/10 18:45:06-07:00 steve@wing.XXXXXXXXXX +1 -1
> #   Condition Xilinx on-chip processor support with
> #   CONFIG_VIRTEX_II_PRO
> #
> # arch/ppc/kernel/Makefile
> #   2004/06/10 18:45:06-07:00 steve@wing.XXXXXXXXXX +1 -1
> #   Condition Xilinx on-chip processor support with
> #   CONFIG_VIRTEX_II_PRO
> #
> # BitKeeper/etc/ignore
> #   2004/06/10 18:45:06-07:00 steve@wing.XXXXXXXXXX +4 -0
> #   Added arch/ppc/boot/images/uImage arch/ppc/boot/images/vmlinux.UBoot arch/ppc/boot/images/vmlinux.gz arch/ppc/kernel/ppc_defs.h to the ignore list
> #
> diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
> --- a/arch/ppc/kernel/Makefile	2004-06-10 19:57:40 -07:00
> +++ b/arch/ppc/kernel/Makefile	2004-06-10 19:57:40 -07:00
> @@ -61,7 +61,7 @@
>  obj-$(CONFIG_PPC_OCP)		+= ocp.o
>  obj-$(CONFIG_40x)		+= ppc4xx_setup.o
>  obj-$(CONFIG_4xx)		+= todc_time.o idle_4xx.o
> -ifeq ($(CONFIG_XILINX_OCP),y)
> +ifeq ($(CONFIG_XILINX_OCP)$(CONFIG_VIRTEX_II_PRO),yy)
>  obj-$(CONFIG_40x)		+= xilinx_pic.o
>  else
>  obj-$(CONFIG_40x)		+= ppc4xx_pic.o
> diff -Nru a/arch/ppc/kernel/ppc405_pci.c b/arch/ppc/kernel/ppc405_pci.c
> --- a/arch/ppc/kernel/ppc405_pci.c	2004-06-10 19:57:40 -07:00
> +++ b/arch/ppc/kernel/ppc405_pci.c	2004-06-10 19:57:40 -07:00
> @@ -132,7 +132,7 @@
>  	setup_indirect_pci(hose_a, PPC405_PCI_CONFIG_ADDR,
>  			   PPC405_PCI_CONFIG_DATA);
>
> -#ifdef CONFIG_XILINX_OCP
> +#if defined(CONFIG_XILINX_OCP) && defined(CONFIG_VIRTEX_II_PRO)
>  	/* Eliminate "unused variable" warning for pcip.  Optimizer removes. */
>  	pcip = NULL;
>  	new_pmm_min = PPC405_PCI_LOWER_MEM;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
