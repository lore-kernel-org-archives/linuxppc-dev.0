Date: 2 Apr 2001 16:32:19 -0000
Message-ID: <20010402163219.21565.qmail@oz.iki.fi>
From: Janne Lintuala <birdie@iki.fi>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC855 PCMCIA & wvlan_cs
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: birdie@iki.fi
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I's trying to use wvlan_cs (from pcmcia-cs-3.1.25) with Lucent/IEEE
card in MPC855@80/40 and HHL kernel 2.2.14 with PCMCIA-patch from
Montavista and minor modifications for custom card.

PC Card is found and wvlan_cs module installed, but the
driver fails at initialization phase to timeout, presumably at
hcfio_string-function. Other cards (for example serial_cs or 3c589
seem to work). So, has anyone any ideas what could go wrong with this
one?

1. IO-space is initialized to base 0x80000100,size 0x3F and 16bit port
   size. (PBR5=0x80000100, POR5=0x28024659)

2. Interrupts are handled, but none occurs during initialization (in
   other drivers interrupts however work).

3. Accesses to IO-space go to correct area, ie. 0x80000100-0x8000013F.
   Writes to cards registers (for example at address 0x80000128) seem
   to work, ie. I can write a word and read it back later.

4. config.opts includes "include port 0x100-0xfff" and "include memory
   0x80000000-0x80ffffff".

5. How should the macros IN/OUT_PORT_WORD and IN/OUT_PORT_STRING in
   wvlan_hcfcfg.h be declared? I assume that as below, ie. all
   accesses non-swapping, or am i wrong? At least Lucent documentation
   says so...
   (http://bwrc.eecs.berkeley.edu/People/Grad_Students/jbeutel/wavelan_s0005-11-light.htm)

6. What else could go wrong?

Best Regards,
     Janne Lintuala

#define wvlan_inb(port)			in_8((unsigned char *)((port)+_IO_BASE))
#define wvlan_outb(val, port)		out_8((unsigned char *)((port)+_IO_BASE), (val))
#define wvlan_inw(port)			in_be16((unsigned short *)((port)+_IO_BASE))
#define wvlan_outw(val, port)		out_be16((unsigned short *)((port)+_IO_BASE), (val))
#define wvlan_insw(port, buf, ns)	_insw_ns((unsigned short *)((port)+_IO_BASE), (buf), (ns))
#define wvlan_outsw(port, buf, ns)	_outsw_ns((unsigned short *)((port)+_IO_BASE), (buf), (ns))

#define IN_PORT_BYTE(port)		((hcf_8)wvlan_inb((hcf_io)(port)))
#define IN_PORT_WORD(port)		((hcf_16)wvlan_inw((hcf_io)(port)))
#define IN_PORT_WORD_NO_DEBUG(port)	((hcf_16)wvlan_inw((hcf_io)(port)))
#define OUT_PORT_BYTE(port, value)	wvlan_outb((hcf_8)(value), (hcf_io)(port))
#define OUT_PORT_WORD(port, value)	wvlan_outw((hcf_16)(value), (hcf_io)(port))
#define IN_PORT_STRING			wvlan_insw
#define OUT_PORT_STRING			wvlan_outsw



---clip---
Apr  2 18:27:41 hp-02 kern.info Linux PCMCIA Card Services 18:11:51 3.1.25
Apr  2 18:27:41 hp-02 kern.info   kernel build: 2.2.14 #979 Mon Apr 2 16:43:30 EEST 2001
Apr  2 18:27:41 hp-02 kern.info   options:  none
Apr  2 18:27:41 hp-02 kern.debug cs.c 1.274 2001/03/05 04:01:49 (David Hinds)
Apr  2 18:27:42 hp-02 kern.info m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(GetCardServicesInfo, 0xc0c87d88, 0x0000003c)
Apr  2 18:27:42 hp-02 kern.info m8xx_pcmcia: HP $Revision: 1.1 $ using SLOT_A with IRQ 13.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: MemWin 0: Base 0xe0000000.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: MemWin 1: Base 0xe4000000.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: MemWin 2: Base 0xe8000000.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: MemWin 3: Base 0xec000000.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: MemWin 4: Base 0xf0000000.
Apr  2 18:27:42 hp-02 kern.debug cs: register_ss_entry(1, 0xc40141a0)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 4, 0xc0b8e808)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 0, Vpp 0, io_irq 0, csc_mask 0x80)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 6, 0xc0c87d08)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetIOMap(0, 0, 0x00, 0 ns, 0x0000-0x0001)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 6, 0xc0c87d08)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetIOMap(0, 1, 0x00, 0 ns, 0x0000-0x0001)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0c87cf8)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8011280.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0c87cf8)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 1 at 0xe4000000, OR = 0xb8011280.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0c87cf8)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 2 at 0xe8000000, OR = 0xb8011280.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0c87cf8)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 3 at 0xec000000, OR = 0xb8011280.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0c87cf8)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 4 at 0xf0000000, OR = 0xb8011280.
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 1, 0xc0b8e814)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 11, 0xc10958e0)
Apr  2 18:27:42 hp-02 kern.debug ds.c 1.109 2001/01/11 01:31:50 (David Hinds)
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(GetCardServicesInfo, 0xc0c87d98, 0xc00f0e58)
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(BindDevice, 0xc0c87db8, 0xc00f0e58)
Apr  2 18:27:42 hp-02 kern.debug cs: bind_device(): client 0xc01715c0, sock 0, dev Driver Services
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(RegisterClient, 0xc1c8ca40, 0xc0c87d68)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 0, 0xc0c87d18)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 2, 0xc0c87d20)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: GetStatus(0) = 0xb1
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 2, 0xc0c87c98)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: GetStatus(0) = 0xb1
Apr  2 18:27:42 hp-02 kern.debug cs: setup_socket(0): applying power
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: Service(0, 4, 0xc0b8e808)
Apr  2 18:27:42 hp-02 kern.debug m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
Apr  2 18:27:42 hp-02 kern.debug cs: register_client(): client 0xc01715c0, sock 0, dev Driver Services
Apr  2 18:27:42 hp-02 daemon.info cardmgr[95]: starting, version is 3.1.25
Apr  2 18:27:42 hp-02 kern.debug ds_open(socket 0)
Apr  2 18:27:42 hp-02 kern.debug ds_open(socket 1)
Apr  2 18:27:42 hp-02 kern.debug ds_open(socket 1)
Apr  2 18:27:42 hp-02 daemon.info cardmgr[95]: watching 1 sockets
Apr  2 18:27:42 hp-02 kern.debug ds_ioctl(socket 0, 0x40146401, 0x7ffffac8)
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(GetCardServicesInfo, 0xc0b71b98, 0xc00f0e58)
Apr  2 18:27:42 hp-02 kern.debug ds_ioctl(socket 0, 0xc0146402, 0x1002e058)
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(AdjustResourceInfo, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:42 hp-02 kern.debug ds_ioctl(socket 0, 0xc0146402, 0x1002e098)
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(AdjustResourceInfo, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:42 hp-02 kern.debug ds_ioctl(socket 0, 0xc0146402, 0x1002e078)
Apr  2 18:27:42 hp-02 kern.debug cs: CardServices(AdjustResourceInfo, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:42 hp-02 kern.debug ds_poll(socket 0)
Apr  2 18:27:42 hp-02 kern.debug ds_poll(socket 0)
Apr  2 18:27:43 hp-02 kern.debug cs: resetting socket 0
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 4, 0xc0b8e808)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetSocket(0, flags 0x240, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 4, 0xc0b8e808)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetSocket(0, flags 0x200, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 2, 0xc1ed3e18)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: GetStatus(0) = 0x1f1
Apr  2 18:27:43 hp-02 kern.debug cs: reset done on socket 0
Apr  2 18:27:43 hp-02 kern.debug cs: send_event(sock 0, event 4, pri 0)
Apr  2 18:27:43 hp-02 kern.debug ds: ds_event(0x000004, 0, 0xc01715c0)
Apr  2 18:27:43 hp-02 kern.debug ds_poll(socket 0)
Apr  2 18:27:43 hp-02 kern.debug ds_read(socket 0)
Apr  2 18:27:43 hp-02 daemon.info cardmgr[95]: initializing socket 0
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0x4004640b, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(ValidateCIS, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x0, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0x00000-0x00000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x01 0x03 0x65 0x2e ...
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc01715c0, 0xc0b71878)
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x5, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x17 0x04 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0xb, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x1d 0x05 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x12, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x15 0x50 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x64, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x20 0x04 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetTupleData, 0xc01715c0, 0xc0b71878)
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x66, 4)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x56 0x01 0x02 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(ParseTuple, 0xc01715c0, 0xc0b71878)
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x6a, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x21 0x02 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x6e, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x02 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x72, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x05 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x79, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x05 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x80, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x05 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x87, 2)
Apr  2 18:27:43 hp-02 kern.debug 0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x05 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x8e, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x02 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x92, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x08 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x9c, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x22 0x02 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0xa0, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x1a 0x07 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0xa9, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x1b 0x0f 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0xba, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0xff 0x00 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(0, 0x0, 5)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x01, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033781.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x01, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x00 0x00 0x00 0x00 ...
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc0206404, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc2946406, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetTupleData, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x6c, 2)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x06 0x00 0xef 0x58 ...
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc2946407, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(ParseTuple, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc0206404, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc2946406, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetTupleData, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc2946407, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(ParseTuple, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc0206404, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc2946406, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetTupleData, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug cs: read_cis_mem(1, 0x14, 80)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:43 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:43 hp-02 kern.debug cs:  0x05 0x00 0x4c 0x75 ...
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc2946407, 0x7ffff758)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(ParseTuple, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 kern.debug ds_ioctl(socket 0, 0xc0486403, 0x7ffff6a8)
Apr  2 18:27:43 hp-02 kern.debug cs: CardServices(GetConfigurationInfo, 0xc01715c0, 0xc0b71b98)
Apr  2 18:27:43 hp-02 daemon.info cardmgr[95]: socket 0: Lucent Technologies WaveLAN/IEEE Adapter
Apr  2 18:27:43 hp-02 daemon.info cardmgr[95]: executing: 'modprobe wvlan_cs pc_debug=5 irq_list=9'
Apr  2 18:27:44 hp-02 kern.debug -> init_module()
Apr  2 18:27:44 hp-02 kern.info wvlan_cs: WaveLAN/IEEE PCMCIA driver v1.0.6
Apr  2 18:27:44 hp-02 kern.info wvlan_cs: (c) Andreas Neuhaus <andy@fasta.fh-dortmund.de>
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetCardServicesInfo, 0xc0ac9dc8, 0x0000003a)
Apr  2 18:27:44 hp-02 kern.debug ds: register_pccard_driver('wvlan_cs')
Apr  2 18:27:44 hp-02 kern.debug <- init_module()
Apr  2 18:27:44 hp-02 kern.debug ds_ioctl(socket 0, 0xc050643c, 0x1002df50)
Apr  2 18:27:44 hp-02 kern.debug bind_request(0, 'wvlan_cs')
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(BindDevice, 0xc0b71b68, 0xc1c8c988)
Apr  2 18:27:44 hp-02 kern.debug cs: bind_device(): client 0xc0171380, sock 0, dev wvlan_cs
Apr  2 18:27:44 hp-02 kern.debug -> wvlan_attach()
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(RegisterClient, 0xc01714c4, 0xc0b71b08)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc0171380, 0xc0b71938)
Apr  2 18:27:44 hp-02 kern.debug cs: register_client(): client 0xc0171380, sock 0, dev wvlan_cs
Apr  2 18:27:44 hp-02 kern.debug -> wvlan_event(registration complete, 0, 0xc01713bc)
Apr  2 18:27:44 hp-02 kern.debug <- wvlan_event()
Apr  2 18:27:44 hp-02 kern.debug -> wvlan_event(card insertion, 0, 0xc01713bc)
Apr  2 18:27:44 hp-02 kern.debug -> wvlan_config(0xc01714a0)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc0171380, 0xc0b71648)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetTupleData, 0xc0171380, 0xc0b71648)
Apr  2 18:27:44 hp-02 kern.debug cs: read_cis_mem(1, 0xa2, 7)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:44 hp-02 kern.debug cs:  0x03 0x01 0xe0 0x03 ...
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(ParseTuple, 0xc0171380, 0xc0b71648)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetConfigurationInfo, 0xc0171380, 0xc0b71838)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetFirstTuple, 0xc0171380, 0xc0b71648)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(GetTupleData, 0xc0171380, 0xc0b71648)
Apr  2 18:27:44 hp-02 kern.debug cs: read_cis_mem(1, 0xab, 15)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:44 hp-02 kern.debug cs:  0xc1 0x01 0x19 0x76 ...
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(ParseTuple, 0xc0171380, 0xc0b71648)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(RequestIO, 0xc0171380, 0xc01714c8)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(RequestIRQ, 0xc0171380, 0xc01714dc)
Apr  2 18:27:44 hp-02 kern.warn pcmcia: request_irq(irq=9, irqflags=4000000, devname=wvlan_cs)
Apr  2 18:27:44 hp-02 kern.debug cs: CardServices(RequestConfiguration, 0xc0171380, 0xc01714f4)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Service(0, 4, 0xc0b8e808)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetSocket(0, flags 0x200, Vcc 50, Vpp 0, io_irq 0, csc_mask 0x80)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Service(0, 4, 0xc0b8e808)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetSocket(0, flags 0x220, Vcc 50, Vpp 0, io_irq 9, csc_mask 0x80)
Apr  2 18:27:44 hp-02 kern.debug cs: write_cis_mem(1, 0x1f0, 1)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Service(0, 8, 0xc0b8e86c)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8033791.
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetMemMap(0, 0, 0x21, 300 ns, 0xe0000000-0xe0000000, 0x00000)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Service(0, 6, 0xc0b715f0)
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: SetIOMap(0, 0, 0x03, 0 ns, 0x0100-0x013f)
Apr  2 18:27:44 hp-02 kern.warn m8xx_get_speed is_io=1 ns=255 psst=4 psht=2 psl=12 @@@
Apr  2 18:27:44 hp-02 kern.debug m8xx_pcmcia: Socket 0: Mapped io window 0 at 0x80000100, OR = 0x28024659.
Apr  2 18:27:44 hp-02 kern.info wvlan_cs: index 0x01: Vcc 5.0, irq 9, io 0x0100-0x013f
Apr  2 18:27:44 hp-02 kern.debug <> wvlan_get_stats(eth1)
Apr  2 18:27:44 hp-02 kern.info wvlan_cs: Registered netdevice eth1
Apr  2 18:27:44 hp-02 kern.debug <- wvlan_config()
Apr  2 18:27:44 hp-02 kern.debug -> wvlan_hw_config(eth1)
Apr  2 18:27:44 hp-02 kern.warn cmd_wait cmd_code=0 par_0=0
Apr  2 18:27:44 hp-02 kern.debug wvlan_cs: hcf_action(HCF_ACT_CARD_IN) returned 0x0
Apr  2 18:27:44 hp-02 kern.debug wvlan_cs: hcf_action(HCF_ACT_INT_ON) returned 0x0
Apr  2 18:27:44 hp-02 kern.warn hcf_get_info@@@ doHCMD_ACCESS(0x21)
Apr  2 18:27:44 hp-02 kern.debug hcfio_string @@@ fid=fc01 offset=0 pc_addr=c0b71998 word_len=1 tot_len=2 type=0
Apr  2 18:27:44 hp-02 kern.debug hcfio_string End, rc=4 @@@
Apr  2 18:27:44 hp-02 kern.debug hcfio_string @@@ fid=fc01 offset=2 pc_addr=c0b719d2 word_len=1 tot_len=0 type=0
Apr  2 18:27:44 hp-02 kern.debug hcfio_string End, rc=4 @@@
Apr  2 18:27:44 hp-02 kern.debug wvlan_cs: hcf_get_info(CFG_CNF_OWN_MAC_ADDR) returned 0x4
Apr  2 18:27:44 hp-02 kern.debug wvlan_cs: wvlan_hw_getmacaddr returned 0x4
Apr  2 18:27:44 hp-02 kern.info wvlan_cs: MAC address on eth1 is 00 00 00 00 00 00
Apr  2 18:27:44 hp-02 kern.debug wvlan_cs: wvlan_hw_getfirmware returned 0x4
Apr  2 18:27:44 hp-02 kern.info wvlan_cs: Found firmware 0xC000255C (vendor 268623696) - Firmware capabilities : 0-0-0-0-0
Apr  2 18:27:44 hp-02 kern.warn wvlan_cs: Initialization failed!
Apr  2 18:27:45 hp-02 kern.debug <- wvlan_hw_config()
Apr  2 18:27:45 hp-02 kern.debug <- wvlan_event()
Apr  2 18:27:45 hp-02 kern.debug <- wvlan_attach()
Apr  2 18:27:45 hp-02 kern.debug ds_ioctl(socket 0, 0xc050643d, 0x1002df50)
Apr  2 18:27:45 hp-02 kern.debug ds_ioctl(socket 0, 0xc050643e, 0x1002dfa8)
---clip---

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
