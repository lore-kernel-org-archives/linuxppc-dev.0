Message-ID: <38E38C39.F5E50F40@adc.com>
Date: Thu, 30 Mar 2000 11:17:45 -0600
From: Darin Smith <darin_smith@adc.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ncr scsi byte ordering & irq stuff
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howdy!

I have a 750-based board that has been running a (somewhat hacked)
2.0.30 kernel for some time, which I am now upgrading to 2.2.14.

After a lot of help from Cort, I've now got it mostly booting.  What
I've run across now is
a) with the ncr53c8xx driver
  In the 2.0.x series, we kept continuing forward with a rather old
ncr53c8xx driver (I think from pre 2.0.27).  Attempts to upgrade to the
new driver failed with
  CACHE TEST FAILED
  ncr wrote 2, host read 0
  ncr wrote 2, read back 0

which I see in the 2.2.14 kernel (I'm new to the project and just found
out about the history with the scsi driver).  Diffing through the code
(lots of changes!), it appears that the old code used a macro
_LE_to_BE_long which was defined to do byte reordering if __powerpc__
was defined, and not reorder if otherwise.  It appears that in August of
97, Cort went in and cleaned this up substantially, also supporting the
possibility of the NCR being in big endian mode on the PCI bus.  I
suspect that the whole cause of our problems is a #define not getting
set somewhere, and our driver is the wrong endianness.  Has anyone had
any experience along these same lines?  The start of my autoconf.h looks
like:

/*
 * Platform support
 */
#define CONFIG_ADC 1   /* our system */
#define CONFIG_NMIC 1  /* our specific hardware */
#define CONFIG_PPC 1
#define CONFIG_6xx 1
#undef  CONFIG_8xx
#undef  CONFIG_PMAC
#undef  CONFIG_PREP
#undef  CONFIG_CHRP
#define CONFIG_ALL_PPC 1
#undef  CONFIG_APUS
#undef  CONFIG_GEMINI
#undef  CONFIG_MBX
#undef  CONFIG_SMP
#define CONFIG_6xx 1

which I would think might set __BIG_ENDIAN somewhere?

b) arch/ppc/kernel/irq.c  appears to have been cleaned up significantly
since the 2.0.x series (again, thanks Cort!).  Our hardware, or
specifically our firmware, has some kludgy nature with interrupts.  At
this point, I'm not sure of the history or why, or even the specifics,
but basically the old code (post hack) looked like:

static void
reset_int_controllers(void)
{
    /* Initialize interrupt controllers */
    outb(0x11, 0x20); /* Start init sequence */
    outb(0x40, 0x21); /* Vector base */
    outb(0x04, 0x21); /* Cascade (slave) on IRQ2 */
    outb(0x01, 0x21); /* Select 8086 mode */
    outb(0xFF, 0x21); /* Mask all */
    outb(0x11, 0xA0); /* Start init sequence */
    outb(0x48, 0xA1); /* Vector base */
    outb(0x02, 0xA1); /* Cascade (slave) on IRQ2 */
    outb(0x01, 0xA1); /* Select 8086 mode */
    outb(0xFF, 0xA1); /* Mask all */

#ifdef CONFIG_NMIC
    /* ??? CONFIG_NMIC  boot firmware ppcbug supposed to set it right.
*/
    /* don't know why not. temporary fix until ppcbug solve it */
    outb(0xe0, 0x4D0); /* IRQ 7/6/5 are level */
    outb(0x8e, 0x4D1); /* IRQ 15/11/10/9 are level */
#endif
#ifndef CONFIG_ADC
printk("IRQ Edge = %x/%x, Processor = %d\n", inb(0x4D0), inb(0x4D1),
 _Processor);
#endif
#if 0
    outb(0x00, 0x4D0); /* All edge triggered */
    outb(0xCA, 0x4D1); /* Trigger mode */
#endif
    outb(cache_A1, 0xA1);
    outb(cache_21, 0x21);
    enable_irq(2);  /* Enable cascade interrupt */
}

we know that we have to have this functionality for our board to work
right...another team using VxWorks had to incorporate the same patch.

My only problem is that this functionality seems to have moved sometime
during 2.1.x, and I'm not quite sure where.  Does anyone know where this
is?  It looks like a lot of stuff like this got carved out to
platform-specific files (prep, chrp, pmac, etc.) but I can't find any
use of outb anywhere...did this get moved to assembly-code?

TIA,

Darin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
