Return-Path: <kim.phillips@freescale.com>
Date: Tue, 9 Sep 2008 11:22:53 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Oliver Rutsch <orutsch@sympatec.com>
Subject: Re: TQM8349 and ARCH = powerpc
Message-Id: <20080909112253.c9c9617f.kim.phillips@freescale.com>
In-Reply-To: <48C68763.6030606@sympatec.com>
References: <48C68763.6030606@sympatec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 09 Sep 2008 16:25:39 +0200
Oliver Rutsch <orutsch@sympatec.com> wrote:

> U-Boot (1.3.4):
> Appended the file include/configs/TQM834x.h to support fdt:
> 
> #define CONFIG_OF_LIBFDT	1
> #define CONFIG_OF_BOARD_SETUP	1
> #define CONFIG_OF_STDOUT_VIA_ALIAS	1
> 
> Appended the file board/tqc/tqm834x/tqm834x.c:
> #if defined(CONFIG_OF_BOARD_SETUP)
> void ft_board_setup(void *blob, bd_t *bd)
> {
> 	ft_cpu_setup(blob, bd);
> #ifdef CONFIG_PCI
> 	ft_pci_setup(blob, bd);
> #endif
> }
> 
> U-Boot compiled fine and it looks good after flashing. In U-Boot 
> everything seems to work.
> 
> Kernel (Linux-2.6.27-rc5):
> I took arch/powerpc/boot/dts/mpc8349emitx.dts as a template
> for a tqm8349.dts and stripped the IDE interface from it.
> So for me the dts does not look board specific anymore and
> the network/console should work.

u-boot assigns the IMMR to 0xff400000 in TQM834x.h, whereas the device
tree you picked has it at 0xe0000000 (it's defined in the soc node).
Don't forget to match up the PCI addresses too.  patches welcome, of
course (we don't have tqm boards).

Kim
