Message-Id: <200110081944.VAA00811@piglet.grunz.lu>
Date: Mon, 8 Oct 2001 21:44:12 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Crash with BenH's 2.4.10/2.4.11-pre on 7600
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011007230241.7484@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On   8 Oct, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>Loking closely at the kmalloc() code, it seems to crash in the first
>>test in kmem_cache_alloc_head(), where it accesses cachep->gfpflags.
>>That would mean it hit an unitialized entry in cache_sizes??
>
> Either that or there is some memory corruption going on. Could you
> try to compille without CONFIG_KTRAPS (see kernel hacking options) ?

Found it. Problem is with serial console. Here is the annotated
backtrace from a 2.4.10 kernel:

backtrace:
c023e324        find_OF_pci_device_filter
c0019cf0        __request_region
c023e618        request_OF_resource
c00f8470        chan_init
c00f88b0        probe_sccs
c020c2a8        serial_console_setup
c00145e4        register_console
c020ca54        mac_scc_console_init
c02031d0        console_init
c01f5674        start_kernel

The problem is that request_OF_resource (which calls kmalloc() ) is
called from probe_sccs, which in turn is called for the serial console,
i.e _very_ early in the boot process. At that time, the kmem system is
not yet initialized.

Here is the offending code out of macserial.c:

@@ -2401,6 +2368,11 @@
 #endif
        zss->dma_initted = 0;

+       zss->io_resource = request_OF_resource(ch, 0, NULL);
+       if (!zss->io_resource) {
+               printk(KERN_ERR "macserial: can't request IO resource !\n");
+               return -ENODEV;
+       }
        zs_chan->control = (volatile unsigned char *)
                ioremap(ch->addrs[0].address, 0x1000);
        zs_chan->data = zs_chan->control + 0x10;

Now up to others to find a solution ;-)

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
