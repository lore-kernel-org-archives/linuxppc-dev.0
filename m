Message-ID: <39F552C8.91856B0C@wanadoo.fr>
Date: Tue, 24 Oct 2000 11:13:44 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> I'll be interested to hear how people go with it.  I'll check the
> changes into the bitkeeper linuxppc_2_2 tree within the next day or
> so.  If it goes OK I'll send the patch to Alan for inclusion in
> 2.2.18.

I have a hard time trying to compile this.

First of all, you don't use CONFIG_MAGIC_SYSRQ, do you? If you do, you
find that there is confusion over whether it is "ppc_md.kbd_sysrq_xlate"
or "ppc_md.ppc_kbd_sysrq_xlate", and then there are a couple of
"SYSRQ_KEY = 0x69" instead of "ppc_md.SYSRQ_KEY = 0x69".

Having fixed the corresponding 6 or 8 files, compilation went through to
the end, but in the final "ld ... -o vmlinux", there were dozens of
undefined symbols, like:

arch/ppc/kernel/head.o: In function `setup_disp_bat':
arch/ppc/kernel/head.o(.text+0x47ea): undefined reference to `disp_BATL'
arch/ppc/kernel/head.o(.text+0x47fa): undefined reference to `disp_BATU'
arch/ppc/kernel/kernel.o: In function `motopenpic_to_irq':
arch/ppc/kernel/kernel.o(.text+0x8a28): undefined reference to
`openpic_to_irq'

The latter is found at many places. Further:

arch/ppc/kernel/kernel.o: In function `pmac_pic_init':
arch/ppc/kernel/kernel.o(.text.init+0x7f96): undefined reference to
`open_pic_do_IRQ'
arch/ppc/kernel/kernel.o(__ksymtab+0x388): undefined reference to
`pci_dev_io_base'
arch/ppc/kernel/kernel.o(__ksymtab+0x390): undefined reference to
`pci_dev_mem_base'
arch/ppc/kernel/kernel.o: In function `sys_call_table':
arch/ppc/kernel/kernel.o(.data+0x3198): undefined reference to
`sys_pciconfig_read'
arch/ppc/kernel/kernel.o(.data+0x319c): undefined reference to
`sys_pciconfig_write'
drivers/macintosh/macintosh.o: In function `pmu_ioctl':
drivers/macintosh/macintosh.o(.text+0x2b14): undefined reference to
`get_backlight_level'
drivers/macintosh/macintosh.o: In function `via_pmu_init':
drivers/macintosh/macintosh.o(.text.openfirmware+0x5ec): undefined
reference to `register_backlight_controller'

I may have some weird config options (in particular, CONFIG_PMAC_PBOOK=y
when I don't have a Pbook), but they worked before in 2.2.17, and they
work in 2.4.0.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
