Message-ID: <3D66375C.2046CFA9@ardistech.com>
Date: Fri, 23 Aug 2002 15:23:40 +0200
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: govindan@india.tejasnetworks.com, svacca@valcom.com,
	"LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	govindan@tejasnetworks.com
Subject: Re: Execute Reset via CheckStop approach
References: <20020823113326.5A43F11822@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

> The DER should be set by your formware. Fix this!
>
I cleared CFG_DER in ppcboot to clear the CHSTP bit. After that I needed to
map in the br0 range and to make the asm's volatile and set the input/output
parameters of the asm to get the HRESET_N pulse. So this is the version
which works (on a MPC823e) in the context of the Linux kernel:

        /* Get base address mapped by BR0/OR0 and map it in */
        val = ((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 & 0xFFFF8000;
	val = (int) ioremap( retval, 0x4000 );
        cli();

        /* Enable CheckStop Reset */
        ((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;

        /* Invalidate BR0 mapping */
        ((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 &= ~0x1;

        /* Clear ME in MSR and cause CheckStop */
        __asm__ volatile("mfmsr %0" : "=r" (msr) );
        msr &= ~0x1000;
        __asm__ volatile("mtmsr %0": : "r" (msr) );
        val = * (unsigned char *) val;
        printk("Restart failed\n");
        while(1)
	   ;

Cheers,
	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
