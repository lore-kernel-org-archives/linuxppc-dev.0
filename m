Message-ID: <3F8D85A5.8060300@vinesystech.com>
Date: Wed, 15 Oct 2003 10:36:37 -0700
From: Xiaoshan Zuo <xzuo@vinesystech.com>
MIME-Version: 1.0
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut PCI bridge can't be detected
References: <001d01c39133$20f088a0$2803050a@JackyLam> <3F8B7B3B.60302@vinesystech.com> <004e01c39217$4446ce60$2803050a@JackyLam>
In-Reply-To: <004e01c39217$4446ce60$2803050a@JackyLam>
Content-Type: text/plain; charset=Big5
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jacky,

Sure. I certainly don't want to see another person go through the pain I
had. The kernel from Montavista preview kit works on walnut board. I
tried Reltek 8139 card a little bit, it seem that it works fine. I want
to compile my own kernel to work on our customized board, so I picked up
2.4.22 from linux-ppc tree. Below is the instructions on how I made it
work on my board.

1. Download crosstool-0.24 and compile the tools-chain. There are
various gcc-glibc combinations, what I used is the gcc-3.2.3-glibc-2.2.5.

2. download u-boot-0.4. u-boot doesn't work with the walnut board I
have(it doens't take input from keyboard), I had to change the
configuration, besides the UART on our board uses internal clock. I
change the configuration below:

#undef CFG_EXT_SERIAL_CLOCK /* external serial clock */
#undef CFG_405_UART_ERRATA_59 /* 405GP/CR Rev. D silicon */
#ifdef CFG_EXT_SERIAL_CLOCK
#define CFG_BASE_BAUD 691200
#else
/* #define CFG_BASE_BAUD 201600 */
#define CFG_BASE_BAUD 892800
#endif

Depends on what kind of flash you use, you may need to add the chip to
board/walnut/flash.c, for example, I added the following
to flash.c
+ case (FLASH_WORD_SIZE)AMD_ID_LV040B:
case (FLASH_WORD_SIZE)AMD_ID_LV040B:
case (FLASH_WORD_SIZE)AMD_ID_F040B:
info->flash_id += FLASH_AM040;
info->sector_count = 8;
info->size = 0x0080000; /* => 512 ko */
break;

But if you use the same flash, you don't have to do this.

Use the following setting in walnut.h (I think they are the same as the
original settings)

#define PCI_HOST_ADAPTER 0 /* configure ar pci adapter */
#define PCI_HOST_FORCE 1 /* configure as pci host */
#define PCI_HOST_AUTO 2 /* detected via arbiter enable */

#define CONFIG_PCI /* include pci support */
#define CONFIG_PCI_HOST PCI_HOST_FORCE /* select pci host function */
#define CONFIG_PCI_PNP /* do pci plug-and-play */
/* resource configuration */

#define CFG_PCI_SUBSYS_VENDORID 0x0000 /* PCI Vendor ID: to-do!!! */
#define CFG_PCI_SUBSYS_DEVICEID 0x0000 /* PCI Device ID: to-do!!! */
#define CFG_PCI_PTM1LA 0x00000000 /* point to sdram */
#define CFG_PCI_PTM1MS 0x80000001 /* 2GB, enable hard-wired to 1 */
#define CFG_PCI_PTM1PCI 0x00000000 /* Host: use this pci address */
#define CFG_PCI_PTM2LA 0x00000000 /* disabled */
#define CFG_PCI_PTM2MS 0x00000000 /* disabled */
#define CFG_PCI_PTM2PCI 0x04000000 /* Host: use this pci address */

Also you need to remove the #ifndef line in the function pci_hose_scan_bus()
#ifndef CONFIG_405GP /* don't skip host bridge on ppc405gp */
/* Skip our host bridge */
if ( dev == PCI_BDF(hose->first_busno,0,0) )
continue;
#endif

It causes PCIC0_CMD[MA]=0 on the bridge, so it doens't respond to request.

Follow the instruction in the package to build u-boot.

2. Follow the instruction at http://penguinppc.org/dev/kernel.shtml to
get the 2.4.22 kernel ( it is 2.4.22 kerne with some ppc fixes as far as
I can tell from the log)
bk clone -rV2.4.22 bk://ppc.bkbits.net/linuxppc-2.4 linuxppc-2.4.22

Change the bd_t in file arch/ppc/platforms/walnut.h to

typedef struct board_info {
unsigned long bi_memstart; /* start of DRAM memory */
unsigned long bi_memsize; /* size of DRAM memory in bytes */
unsigned long bi_flashstart; /* start of FLASH memory */
unsigned long bi_flashsize; /* size of FLASH memory */
unsigned long bi_flashoffset; /* reserved area for startup monitor */
unsigned long bi_sramstart; /* start of SRAM memory */
unsigned long bi_sramsize; /* size of SRAM memory */

unsigned long bi_bootflags; /* boot / reboot flag (for LynxOS) */
unsigned long bi_ip_addr; /* IP Address */
unsigned char bi_enetaddr[6]; /* Ethernet adress */
unsigned short bi_ethspeed; /* Ethernet speed in Mbps */
unsigned long bi_intfreq; /* Internal Freq, in MHz */
unsigned long bi_busfreq; /* Bus Freq, in MHz */
unsigned long bi_baudrate; /* Console Baudrate */

unsigned char bi_s_version[4]; /* Version of this structure */
unsigned char bi_r_version[32]; /* Version of the ROM (IBM) */
unsigned int bi_procfreq; /* CPU (Internal) Freq, in Hz */
unsigned int bi_plb_busfreq; /* PLB Bus speed, in Hz */
unsigned int bi_pci_busfreq; /* PCI Bus speed, in Hz */
unsigned char bi_pci_enetaddr[6]; /* PCI Ethernet MAC address */
} bd_t;

Change the clock setting:

#ifdef CONFIG_PPC405GP_INTERNAL_CLOCK
#define BASE_BAUD 892800
#else
#define BASE_BAUD 691200
#endif

You need to define CONFIG_PPC405GP_INTERNAL_CLOCK in
include/linux/autoconf.h. I added the setting to config.in myself.
You need to enable CONFIG_PCI and disable CONFIG_SERIAL_TEXT_DEBUG.

I don't have time to test if the configuratin will work on the original
walnut board. Since our board is almost the same as walnut board, there
is very good chance this works on original walnut board.

Good luck,

Xiaoshan

Jacky Lam wrote:

>>I was puzzled by this for a while. Then I saw this code while debugging
>>PCI on my custom board:
>>In ppc405_pci.c, there is ppc4xx_exclude_device function:
>>
>>static int
>>ppc4xx_exclude_device(unsigned char bus, unsigned char devfn)
>>{
>>/* We prevent us from seeing ourselves to avoid having
>>* the kernel try to remap our BAR #1 and fuck up bus
>>* master from external PCI devices
>>*/
>>return (bus == 0 && devfn == 0);
>>}
>>
>>With this function there, there is no way you are going to see the
>>bridge, even your driver does the scan itself. I had to write my own
>>pci_read_config_<size> function to just to be able to read the bridge
>>configration.
>>
>>Cheers,
>>
>>Xiaoshan
>>
>>
>
>    Would you made any PCI card working on Walnut before? Do you know any
>code modification is needed before? Could you please give me some direction?
>Thanks.
>
>Best regards,
>Jacky
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
