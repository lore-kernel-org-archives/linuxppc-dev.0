Return-Path: <leisun124@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id DECCD67B32
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 00:12:54 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so328566ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 07:12:51 -0700 (PDT)
Message-ID: <f9a7e7a80607190712v362c3e1ei7e85003041a25e35@mail.gmail.com>
Date: Wed, 19 Jul 2006 10:12:51 -0400
From: "Lei Sun" <leisun124@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: reboot on PQ2FADS board.
In-Reply-To: <20060719063317.86A66352681@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net>
	<20060719063317.86A66352681@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi :
  I  tried your approach last ight, (in fact I copied part of the
do_reboot() code from u-boot and put it in m8260_restart() function in
the kernel).  The only difference is the first line,
     volatile immap_t *immap = (immap_t *) IMAP_ADDR;
in my case it is
     volatile immap_t * immap = cpm2_immr;
I am using different source tree.
it simply hangs, rather then reset.

On 7/19/06, Wolfgang Denk <wd@denx.de> wrote:
> In message <4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net> you wrote:
> >
> > > command cause machine check and kernel ooops.  The problem seems in
> > > the "m8260_gorom" in head.S.  The restart() function in m8260_setup.c
> > > passed 2 parameters to that assembly code, r3 is the bd_info , r4 is
> > > the warm start address,  I changed it to 0xFF800100, that's where the
> > > u-boot's _start_warm lives, I have verified that address by typing "g
> > > ff800100" in u-boot console, which cause the board reset.
> >
> > Are you sure ff800100 is _start_warm lives?  In latest u-boot
>
> Trying to jump to some boot rom address is IMHO always a bad approach
> to reboot a system. You should always try to cause a reset  condition
> for  the CPU, and thus for all the associated hardware. On 8xx / 8260
> systems this is usually done by going through  a  machine  check.  We
> have  the  following code in our linuxppc_2_4_devel tree, which works
> on ALL 8260 systems, no matter whioch boot loder they use:
>
> static void
> m8260_restart(char *cmd)
> {
>        __volatile__ unsigned char dummy;
>        ulong msr;
>
>        cli();
>        volatile immap_t *immap = (immap_t *) IMAP_ADDR;
>
>        immap->im_clkrst.car_rmr = 1;    /* Checkstop Reset enable */
>
>        /* Interrupts and MMU off */
>        __asm__ __volatile__ ("mfmsr    %0":"=r" (msr):);
>
>        msr &= ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR);
>        __asm__ __volatile__ ("mtmsr    %0"::"r" (msr));
>
>        dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
>
>        printk("Restart failed\n");
>        for (;;);
> }
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> If a group of N persons implements a COBOL compiler,  there  will  be
> N-1 passes. Someone in the group has to be the manager. - T. Cheatham
>
