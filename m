To: govindan@india.tejasnetworks.com
Cc: svacca@valcom.com,
	"LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	govindan@tejasnetworks.com
Subject: Re: Execute Reset via CheckStop approach 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Jul 2002 10:49:39 +0530."
             <NEBBINFJMPEFJBMDGBGMAEOGFAAA.govindan@india.tejasnetworks.com>
Date: Wed, 24 Jul 2002 17:46:20 +0200
Message-Id: <20020724154625.05E4310875@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NEBBINFJMPEFJBMDGBGMAEOGFAAA.govindan@india.tejasnetworks.com> you wrote:
>
> Here is something we found working:
...
>       addr = 0x10000000;  // This should be a non-accessible memory
> location.

The big disadvantage of this approach is that it works on one  board,
and fails on another - or even on the same board after you added some
more RAM, etc.

We solved this problem in our version (see the  CVS)  by  explicitely
invalidating the mapping in the memory controller:

        /* Get base address mapped by BR0/OR0
         */
        bad_addr = ((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 & 0xFFFF8000;
        cli();

        /* Enable CheckStop Reset
         */
        ((immap_t *)IMAP_ADDR)->im_clkrst.car_rmr |= 0x00000001;

        /* Invalidate BR0 mapping
         */
        ((immap_t *)IMAP_ADDR)->im_memctl.memc_br0 = 0;

        /* Set MSR and cause reset
         */
        __asm__("mfmsr %0" : "=r" (msr) );
        msr &= ~0x1000;
        __asm__("mtmsr %0" : "=r" (msr) );
        dummy = * (unsigned char *) bad_addr;
        printk("Restart failed\n");
        while(1);


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Microsoft Compatibility:
     your old Windows 3.11 application crash exactly as the new ones.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
