Message-ID: <3CD9560E.9000909@pacbell.net>
Date: Wed, 08 May 2002 09:45:02 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: 4xx change to core files
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have changed the way the paddrs are used in the 4xx specifically in
the manner they are used in the core.c files.  This eliminates the need
for "externs struct *_ADDR[]" , IIC_PORT_DFNS and in most cases the need
for *_NUMS.  The ocp API's have changed to take advantage of this new
core_ocp[].  All the ocp drivers have been affected in a minor way as
well as most core.h files.

The core_ocp[] is don ein the following:

new struct in asm-ppc/ocp.h

struct ocp_def {
	enum ocp_type type;
	int paddr;
	int irq;
};


each 4xx core file now contains something simulary to this ( ibm405gp.c)

struct ocp_def core_ocp[] = {
	{UART, UART0_IO_BASE, UART0_INT},
	{UART, UART1_IO_BASE, UART1_INT},
	{IIC, IIC0_BASE, IIC0_IRQ},
	{GPIO, GPIO0_BASE, OCP_IRQ_NA},
	{PCI, PCIL0_BASE, OCP_IRQ_NA},
	{OPB, OPB0_BASE, OCP_IRQ_NA},
	{EMAC, EMAC0_BASE, OCP_IRQ_NA},
	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA},

};


new ocp APIs:

unsigned long get_ocp_paddr(int type, int dev_num);
  returns the physical address for a given ocp type for the nth one.
  this is used when the mmu is not completely up such as during pci
bring up.

int ocp_get_max(int type);
   returns the max number of ocp device type


  This affects the 405gp, np405l, np405h, 440gp , stb03xxx, stb04xxx and
np4gs cores.


the following drivers have been altered, ibm_ocp_enet.c, ibm_ocp_zmii.c,
ppc405_pci.c, ibm_ocp_gpio.c, i2c-adapt-ibm_ocp.c

I expect to be done soon.

Armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
