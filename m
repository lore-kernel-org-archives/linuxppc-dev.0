Message-ID: <3F4C9209.8050301@imc-berlin.de>
Date: Wed, 27 Aug 2003 13:12:09 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: "'LinuxPPC '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA Modem/Serial Cards and MPC8xx?
References: <20030827104436.2C91EC59E4@atlas.denx.de>
In-Reply-To: <20030827104436.2C91EC59E4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

 >>Did you have MPC8xx uarts _and_ a standard 16550 uart _and_ PCMCIA?
 >
 > Yes, we support MPX8xx UART, standard serial driver  including  16550
 > UART,  and  PCMCIA.  See our linux-2.4 kernel tree. It should be very
 > easy to extract the relevant patch and  to  apply  it  to  any  other
 > kernel.

I am getting closer though:

I changed
#define RS_TABLE_SIZE 3

and added a dummy line in my dab4k_serial.h:

#define SERIAL_PORT_DFNS \
          { 0, (UART_BASE_BAUD/16), UARTA_ADDR, SIU_IRQ3, STD_COM_FLAGS, \
            iomem_base: (u8 *) UARTA_ADDR, \
            iomem_reg_shift:0, \
            io_type: SERIAL_IO_MEM }, \
          { 0, (UART_BASE_BAUD/16), UARTB_ADDR, SIU_IRQ4, STD_COM_FLAGS, \
            iomem_base: (u8 *) UARTB_ADDR, \
            iomem_reg_shift:0, \
            io_type: SERIAL_IO_MEM }, \
          { 0, 0, 0, 0, STD_COM_FLAG}

Now I do get

CPM UART driver version 0.04
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SMC2 at 0x0380, BRG2
ttyS2 on SCC1 at 0x0000, BRG3

Serial driver version 5.05c (2001-07-08) with SHARE_IRQ enabled
ttyS00 at 0xc3071000 (irq = 6) is a ST16654
ttyS01 at 0xc3071080 (irq = 8) is a ST16654

And PCMCIA CS tells me

cardmgr[80]: socket 0: Serial or Modem
cardmgr[80]: BEEP_OK
cardmgr[80]:   product info: "Intelligent", "PCMCIA FAX+MODEM"
cardmgr[80]:   manfid: 0x0200, 0x0001  function: 2 (serial)
cardmgr[80]: executing: 'modprobe serial_cs'
cardmgr[80]: + Using /lib/modules/2.4.20/pcmcia/pcmcia_core.o
cardmgr[80]: + Using /lib/modules/2.4.20/pcmcia/ds.o
cardmgr[80]: + Using /lib/modules/2.4.20/pcmcia/serial_cs.o
ttyS02 at port 0x03f8 (irq = 9) is a 16550A
cardmgr[80]: executing: './serial start ttyS2'
cardmgr[80]: + Default modem setup
cardmgr[80]: BEEP_OK
cardmgr[80]: BEEP_OK

So why is it ttyS02. Why is it ./serial start ttyS2?
It's also ttyS2 if I don't enable SCC1 as UART!

 > See http://www.denx.de/twiki/bin/view/DULG/KernelConfigurationForPCMCIA

I read this. But where does the MAJOR number 240 come from???

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
