Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B9A0E67BB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 16:51:34 +1000 (EST)
To: "Li Yang-r58472" <LeoLi@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: reboot on PQ2FADS board. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jul 2006 13:06:39 +0800."
	<4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net>
Date: Wed, 19 Jul 2006 08:33:17 +0200
Sender: wd@denx.de
Message-Id: <20060719063317.86A66352681@atlas.denx.de>
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

In message <4879B0C6C249214CBE7AB04453F84E4D050B0F@zch01exm20.fsl.freescale.net> you wrote:
>
> > command cause machine check and kernel ooops.  The problem seems in
> > the "m8260_gorom" in head.S.  The restart() function in m8260_setup.c
> > passed 2 parameters to that assembly code, r3 is the bd_info , r4 is
> > the warm start address,  I changed it to 0xFF800100, that's where the
> > u-boot's _start_warm lives, I have verified that address by typing "g
> > ff800100" in u-boot console, which cause the board reset.
> 
> Are you sure ff800100 is _start_warm lives?  In latest u-boot

Trying to jump to some boot rom address is IMHO always a bad approach
to reboot a system. You should always try to cause a reset  condition
for  the CPU, and thus for all the associated hardware. On 8xx / 8260
systems this is usually done by going through  a  machine  check.  We
have  the  following code in our linuxppc_2_4_devel tree, which works
on ALL 8260 systems, no matter whioch boot loder they use:

static void
m8260_restart(char *cmd)
{   
        __volatile__ unsigned char dummy;
        ulong msr;
    
        cli();
        volatile immap_t *immap = (immap_t *) IMAP_ADDR;
    
        immap->im_clkrst.car_rmr = 1;    /* Checkstop Reset enable */
    
        /* Interrupts and MMU off */
        __asm__ __volatile__ ("mfmsr    %0":"=r" (msr):);
    
        msr &= ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR);
        __asm__ __volatile__ ("mtmsr    %0"::"r" (msr)); 
    
        dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
    
        printk("Restart failed\n");
        for (;;);
}   


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If a group of N persons implements a COBOL compiler,  there  will  be
N-1 passes. Someone in the group has to be the manager. - T. Cheatham
