Message-ID: <398DD9BB.30521791@rochcivictheatre.org>
Date: Sun, 06 Aug 2000 16:33:47 -0500
From: Tom Gall <gall@rochcivictheatre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: request region in the wrong spot?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,

  I've been working to get the Power3 work up and rolling with
2.4.0-test5.

  In arch/ppc/kernel/chrp_setup.c there is the following:

    236 void __init
    237 chrp_setup_arch(void)
    238 {
    239     extern char cmd_line[];
    240     struct device_node *device;
    241
    242     /* init to some ~sane value until calibrate_delay() runs */
    243     loops_per_sec = 50000000;
    244
    245 #ifdef CONFIG_BLK_DEV_INITRD
    246     /* this is fine for chrp */
    247     initrd_below_start_ok = 1;
    248
    249     if (initrd_start)
    250         ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
    251     else
    252 #endif
    253         ROOT_DEV = to_kdev_t(0x0802); /* sda2 (sda1 is for the
kernel) */
    254     printk("Boot arguments: %s\n", cmd_line);
    255
    256     request_region(0x20,0x20,"pic1");
    257     request_region(0xa0,0x20,"pic2");
    258     request_region(0x00,0x20,"dma1");
    259     request_region(0x40,0x20,"timer");
    260     request_region(0x80,0x10,"dma page reg");
    261     request_region(0xc0,0x20,"dma2");

This is evil as request region does:

217 struct resource * __request_region(struct resource *parent, unsigned
long start, unsigned long n, const char *name)
218 {
219         struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  Yes that's right a kmalloc. At this point if I am correct the kernel
is not ready to be doing kmallocs. This tanked my kernel.

  I propose moving this 6 request region calls to

  arch/ppc/kernel/setup.c in ppc_init()

  which is called by init/main do_basic_setup() fairly early.

  Is this a reasonable fix?

--
Regards,

Tom

-----------------------------------------------------------
Linux Guy          "My heart is human, my blood is boiling,
tgall@uswest.net    my brain IBM" -- Mr Roboto, Styxx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
