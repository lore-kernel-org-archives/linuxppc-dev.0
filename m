Subject: IDE interface driver on the 405gp 
Date: Wed, 14 Mar 2001 13:52:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49707F906@voyager.ops.infiniswitch.com>
From: "Curry, Diane" <dcurry@infiniswitch.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello -
  I'm running an IBM 405GP rev D walnut and Monta Vista's 2.4.2 port.  I
have a
PCI-to-PCMCIA adapter, a PCMCIA card reader/writer and an IBM
Microdrive.  I've
got a root filesystem on the Microdrive and a kernel image built with an
initial ram disk.
The kernel boots with the initrd image, my linuxrc scripts loads the
pcmcia modules and
switches roots to the microdrive.  This is all working fine, but I'm
questioning what I did
to get it working (it seemed too easy).  All of the changes, except some
endian issues
which I addressed in the pcmcia i82365.c module, were to ppc4xx_setup.c.
Essentially
all I did was initialize the ppc_ide_md structure with function names
and provide the
corresponding functions (using m8xx_setup.c as a reference).  If anyone
could tell me
whether this seems reasonable, I'd really appreciate it.  Thanks  in
advance.

Diane Curry
dcurry@Infiniswitch.com

diff ppc4xx_setup.c ppc4xx_setup.c.orig

257,323d256
< #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
<
< /*
<  * IDE stuff.
<  */
< void
< ppc4xx_ide_insw(ide_ioreg_t port, void *buf, int ns)
< {
<         ide_insw(port+_IO_BASE, buf, ns);
< }
<
< void
< ppc4xx_ide_outsw(ide_ioreg_t port, void *buf, int ns)
< {
<         ide_outsw(port+_IO_BASE, buf, ns);
< }
<
< int
< ppc4xx_ide_default_irq(ide_ioreg_t base)
< {
<         return 14;
< }
<
< ide_ioreg_t
< ppc4xx_ide_default_io_base(int index)
< {
< 	return 0;
< }
<
< int
< ppc4xx_ide_request_irq(unsigned int irq,
<                        void (*handler)(int, void *, struct pt_regs *),
<                        unsigned long flags,
<                        const char *device,
<                        void *dev_id)
< {
<         return request_irq(irq, handler, flags, device, dev_id);
< }
<
< /* We can use an external IDE controller or wire the IDE interface to
<  * the internal PCMCIA controller.
<  */
< void ppc4xx_ide_init_hwif_ports(ide_ioreg_t *p, ide_ioreg_t base,
ide_ioreg_t ctrl, int *irq)
< {
<         ide_ioreg_t port = base;
<         int i;
<
<         /* Just a regular IDE drive on some I/O port.
<         */
<         i = 8;
< /*
<  * I think this is initializing io_ports[IDE_DATA_OFFSET] to
<  * io_ports[IDE_STATUS_OFFSET]...
<  */
<         while (i--)
<                 *p++ = port++;
< /*
<  * And this is initializing io_ports[IDE_CONTROL_OFFSET], but
<  * we aren't using it, we are using what the caller passed in...
<         *p++ = base + 0x206;
<  */
< 	*p++ = ctrl;
<
<         if (irq != NULL)
<                 *irq = 0;
< }
< #endif
921,937d853
< #endif
<
< #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
<         ppc_ide_md.insw = ppc4xx_ide_insw;
<         ppc_ide_md.outsw = ppc4xx_ide_outsw;
<         ppc_ide_md.default_irq = ppc4xx_ide_default_irq;
<         ppc_ide_md.default_io_base = ppc4xx_ide_default_io_base;
<         ppc_ide_md.fix_driveid = ppc_generic_ide_fix_driveid;
<         ppc_ide_md.ide_init_hwif = ppc4xx_ide_init_hwif_ports;
<         ppc_ide_md.io_base = _IO_BASE;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
