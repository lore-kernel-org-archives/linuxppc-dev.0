To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA support for 860
References: <0FSL00IBF9IGAS@pmdf-it.hasler.ascom.ch>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 06 Apr 2000 14:23:41 +0200
In-Reply-To: Ruedi.Hofer@ascom.ch's message of "Thu, 06 Apr 2000 11:39:11 +0100 (CED)"
Message-ID: <kfysnwzto36.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch writes:

> Hi
>
> Kernel boot problem:
> Obviousely the kernel was too large. When reduce its size and put some
> extensions into modules, it starts up fine.
>
> But there are 2 other problems:
>
> Ethernet Card:
>
> - When I insert a Xircom Ethernet card, it is detected and the modules are loaded.
> But somehow it affects the NFS connection in such a bad way, that it looses connection
> to the server. Everything gets very slow. When I plug the pc card out, NFS works fine again.

Try changing the PCMCIA configuration files so that it doesn't
bring the interface up automaticly.

> >sh-2.03# cardmgr[30]: initializing socket 0
> >cardmgr[30]: socket 0: Xircom CE3-10/100 Fast Ethernet
> >cardmgr[30]: executing: 'insmod /lib/modules/2.2.13/pcmcia/xirc2ps_cs.o'
> >xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
> >eth1: Xircom: port 0x300, irq 9, hwaddr 00:80:C7:86:E4:DF
> >cardmgr[30]: executing: './network start eth1'
> >sh-2.03# eth1: media 10BaseT, silicon revision 7
> >sh-2.03# cardmgr[30]: + SIOCADDRT: File exists
> >sh-2.03# lsmod
> >nfs: server 10.1.20.2 not responding, still trying
> >nfs: task 1574 can't get a request slot
>
> I guess that too many interrupts knock the system out.

We have had even more problems with xirc2ps_cs.c, for some reason our
cards generate interrupts before the interface is brought up. This
diff will prevent that from causing problems:

diff -u -r1.1.1.3 xirc2ps_cs.c
--- clients/xirc2ps_cs.c	2000/03/13 14:33:04	1.1.1.3
+++ clients/xirc2ps_cs.c	2000/04/04 14:36:00
@@ -1397,9 +1397,16 @@
 				  * is this something to worry about?
 				  * -- on a laptop?
 				  */
+    static int badints = 0;

-    if (!netif_device_present(dev))
-	return;
+    if (!netif_device_present(dev)) {
+	if (badints < 5) {
+	    badints++;
+	    return;
+	}
+    } else {
+	badints = 0;
+    }

     ioaddr = dev->base_addr;
     if (lp->mohawk) { /* must disable the interrupt */


> ATA Flash card:
>
> - Even worse with the flash card: The system crashes!
>
> >sh-2.03# cardmgr[42]: initializing socket 0
> >cardmgr[42]: socket 0: ATA/IDE Fixed Disk
> >cardmgr[42]: executing: 'insmod /lib/modules/2.2.13/pcmcia/ide_cs.o'
> >hda: SunDisk SDP3B-40, ATA DISK drive
> >Kernel panic: request_irq
> >Rebooting in 180 seconds..
>
> - Is the request_irq related to the loaded module or to the IDE stuff in the kernel?
>   ('Configure IDE for ATA on PCMCIA' is switched off!)
> - Is it right that every occurence of request_irq has to replaced with request_8xxirq?

Ah yes, when using serial or IDE cards the interrupt handler is
requested by drivers/char/serial.c and drivers/block/ide-probe.c
respectively, not by the PCMCIA modules.

You can either change include/asm-ppc/ide.h to use request_8xxirq(),
or you can do like we've done; change arch/ppc/kernel/ppc8xx_pic.c
so that request_irq() looks like this:

int request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
	unsigned long irqflags, const char * devname, void *dev_id)
{
#ifdef CONFIG_MBX
        irq += i8259_pic.irq_offset;
#endif
	return (request_8xxirq(irq, handler, irqflags, devname, dev_id));
}

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
