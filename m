From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 19 Nov 2003 18:17:23 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5xxx code issues
Message-ID: <20031120011723.GA1287@zenos.farnsworth.org>
References: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net> <20031118150406.GB8092@zenos.farnsworth.org> <20031119155834.GB935@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031119155834.GB935@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 19, 2003 at 03:58:34PM +0000, Tom Rini wrote:
> On Tue, Nov 18, 2003 at 08:04:06AM -0700, Dale Farnsworth wrote:
> >
> > On Mon, Nov 17, 2003 at 08:29:44PM +0000, Tom Rini wrote:
> > > Must clean: These files need some sort of rewrite to look less like a
> > > drop of commerical code into the kernel and more like working the
> > > commercial code into the kernel:
> > > arch/ppc/5xxx_io/bestcomm/capi/Makefile
> > > arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/Makefile
> > > arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos2/Makefile
> > > arch/ppc/5xxx_io/bestcomm/include/dummy files (should these be needed?)
> >
> > The code beneath the arch/ppc/5xxx_io/bestcomm directory is supplied
> > by Motorola.  To ease the adoption of later revisions of this code,
> > we made minimal modifications.  Stupidly, the bestcomm code references
> > stdio.h, stdlib.h, string.h, but doesn't use their contents, so we
> > added empty files with these names.
>
> .. but those files _should_ be OK anyhow, if I recall all of the include
> magic correctly.
>
> > The Makefiles are also supplied by Motorola and are not used by Linux
> > at all.  We can safely omit them to reduce confusion.
>
> Can you give me a list of all of the files we don't actually need?
> Thanks.

Well, here are the files under arch/ppc/5xxx_io/bestcomm that we do use:
Makefile
capi/bestcomm_api.c
capi/bestcomm_api.h
capi/load_task.c
capi/ppctypes.h
capi/task_api/bestcomm_api_mem.h
capi/task_api/bestcomm_cntrl.h
capi/task_api/tasksetup_bdtable.c
capi/task_api/tasksetup_bdtable.h
capi/task_api/tasksetup_general.c
capi/tasksetup.c
capi/tasksetup.h
code_dma/image_rtos1/dma_image.c
code_dma/image_rtos1/dma_image.capi.c
code_dma/image_rtos1/dma_image.capi.h
code_dma/image_rtos1/dma_image.h
code_dma/image_rtos1/dma_image.reloc.c
code_dma/image_rtos1/task_capi/tasksetup_ata.c
code_dma/image_rtos1/task_capi/tasksetup_crc16_dp_0.c
code_dma/image_rtos1/task_capi/tasksetup_crc16_dp_1.c
code_dma/image_rtos1/task_capi/tasksetup_fec_rx_bd.c
code_dma/image_rtos1/task_capi/tasksetup_fec_tx_bd.c
code_dma/image_rtos1/task_capi/tasksetup_gen_dp_0.c
code_dma/image_rtos1/task_capi/tasksetup_gen_dp_1.c
code_dma/image_rtos1/task_capi/tasksetup_gen_dp_2.c
code_dma/image_rtos1/task_capi/tasksetup_gen_dp_3.c
code_dma/image_rtos1/task_capi/tasksetup_gen_dp_bd_0.c
code_dma/image_rtos1/task_capi/tasksetup_gen_dp_bd_1.c
code_dma/image_rtos1/task_capi/tasksetup_gen_rx_bd.c
code_dma/image_rtos1/task_capi/tasksetup_gen_tx_bd.c
code_dma/image_rtos1/task_capi/tasksetup_lpc.c
code_dma/image_rtos1/task_capi/tasksetup_pci_rx.c
code_dma/image_rtos1/task_capi/tasksetup_pci_tx.c
include/mgt5200/mgt5200.h
include/mgt5200/sdma.h
include/stdio.h
include/stdlib.h
include/string.h

So, it looks like we can get rid of:
capi/Makefile
capi/taskinfo_initiators.c
code_dma/image_rtos1/Makefile
code_dma/image_rtos1/dma_image.hex
code_dma/image_rtos2/Makefile
code_dma/image_rtos2/dma_image.c
code_dma/image_rtos2/dma_image.capi.c
code_dma/image_rtos2/dma_image.capi.h
code_dma/image_rtos2/dma_image.h
code_dma/image_rtos2/dma_image.hex
code_dma/image_rtos2/dma_image.reloc.c
code_dma/image_rtos2/task_capi/tasksetup_ata.c
code_dma/image_rtos2/task_capi/tasksetup_crc16_dp.c
code_dma/image_rtos2/task_capi/tasksetup_crc16_dp_bd.c
code_dma/image_rtos2/task_capi/tasksetup_fec_rx_bd.c
code_dma/image_rtos2/task_capi/tasksetup_fec_tx_bd.c
code_dma/image_rtos2/task_capi/tasksetup_gen_dp_0.c
code_dma/image_rtos2/task_capi/tasksetup_gen_dp_1.c
code_dma/image_rtos2/task_capi/tasksetup_gen_dp_2.c
code_dma/image_rtos2/task_capi/tasksetup_gen_dp_3.c
code_dma/image_rtos2/task_capi/tasksetup_gen_rx_bd_0.c
code_dma/image_rtos2/task_capi/tasksetup_gen_rx_bd_1.c
code_dma/image_rtos2/task_capi/tasksetup_gen_tx_bd_0.c
code_dma/image_rtos2/task_capi/tasksetup_gen_tx_bd_1.c
code_dma/image_rtos2/task_capi/tasksetup_lpc.c
code_dma/image_rtos2/task_capi/tasksetup_pci_rx.c
code_dma/image_rtos2/task_capi/tasksetup_pci_tx.c
include/ppctypes.h

-Dale Farnsworth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
