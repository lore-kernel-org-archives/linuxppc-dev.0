Message-ID: <3BBC1AAC.AAA004C@staubli.com>
Date: Thu, 04 Oct 2001 10:15:41 +0200
From: Pierre AUBERT <p.aubert@staubli.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	Mailing list Embedded linux on PowerPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: simple access to mem mapped peripheral
References: <B25E2E5A003CD311B61E00902778AF2A02637AB3@SERVER1> <3BBC179A.394FFD71@esd-electronics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias Fuchs wrote:

> Subodh Nijsure wrote:
> >
> > Hello,
> >
> > May be try this?
> >
> >         chip_registerbase = (unsigned
> > long)ioremap_nocache(CHIP_PHYSICAL_ADDRESS,
> >                         CHIP_MEM_SIZE);
> >         printk("Linux kernel Memory mapped base register %lX \n",
> > chip_registerbase);
> >
> > Then you can read and write to your chip via *chip_registerbase
> >
>
> Sorry, but I forgot to say that I need a way to access the peripheral
> from userspace without writing a
> kernel module. I need it only for a simple test and therefore it does
> not make sense to me to write a driver.
>
> Of course, writing a driver is not htat dirty :-)
>
> Matthias
>

I think that you can try the mmap function :


    int mmap_fd;

    /* Open the memory device and mmap the chip registers     */
    if ((mmap_fd = open("/dev/mem", O_RDWR)) < 0 ) {
        perror("open(/dev/mem)");
        exit(1);
    }
    ptr = (chip_register *)mmap(NULL, CHIP_MEM_SIZE,
                          (PROT_READ|PROT_WRITE),
                          MAP_SHARED, mmap_fd, CHIP_PHYSICAL_ADDRESS);
    if ( ((int)ptr) < 0 ) {
        perror("mmap()");
        close(mmap_fd);
        exit(1);
    }
    else {

        /* Read and write your chip registers ... */

        munmap (ptr, CHIP_MEM_SIZE);
        close(mmap_fd);
    }

--
------------------------------------------------------------------------------
Pierre Aubert                   |   Phone:  +33 4 50 65 62 88
                                |   Fax:    +33 4 50 65 62 08
STÄUBLI Faverges                |
Place Robert STÄUBLI            |   Mailto:p.aubert@staubli.com
74210 Faverges FRANCE           |   http://www.staubli.com
------------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
