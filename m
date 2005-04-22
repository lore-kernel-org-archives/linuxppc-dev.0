Return-Path: <p_gortmaker@yahoo.com>
Received: from web60507.mail.yahoo.com (web60507.mail.yahoo.com
	[216.109.116.128]) by ozlabs.org (Postfix) with SMTP id AD8CB67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 05:46:40 +1000 (EST)
Message-ID: <20050422194638.56637.qmail@web60507.mail.yahoo.com>
Date: Fri, 22 Apr 2005 12:46:38 -0700 (PDT)
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Warm reboot on 826x targets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I should have asked what version of U-Boot you were using.  I've had
U-Boot 1.1.1 on this thing from the beginning, but I've heard that some
people are sticking with 1.0 on production stuff.

I've found that I can't use the watchdog timer for a reboot, since it is
"write once" (SYCPR) and I'm guessing U-Boot writes to it at boot.

As a different twist, I tried doing a reset like the m8xx does, as shown
below, but that just caused a hang as well, so I'm wondering if the
problem is more low level (board isn't set up properly, etc.)

Paul.

/*
 *This is a tweaked version of the m8xx_restart.
 */
static void
sbc82xx_restart(char *cmd)
{
        __volatile__ unsigned char dummy;
        unsigned long msr;

        volatile car_cpm2_t *cc = &cpm2_immr->im_clkrst;

        msr = mfmsr();
        mtmsr(msr & ~MSR_EE);
        __asm__ __volatile__("": : :"memory");

        /* Checkstop reset enable -- Sec. 5.3 of MPC8260UM.pdf */
        cc->car_rmr = 0x80000000;

        msr = mfmsr();
        mtmsr(msr & ~MSR_ME);

        dummy = cc->res[0];
        BUG();
}



--- Eugene Surovegin <ebs@ebshome.net> wrote:
> On Tue, Apr 12, 2005 at 11:14:35AM -0700, Paul Gortmaker wrote:
> > I've been trying to get a WRS 8265 to do a warm reboot, and found some
> > things that I am wondering about.
> > 
> > Firstly, is anyone having success on having "reboot" restart the
> machine
> > on a similar platform?
> > 
> > Secondly, the default BOOTROM_RESTART_ADDR is 0x40000104 (sbc82xx.h)
> and I
> > was wondering if this matches any platforms out there.  On this board,
> the
> > place where U-Boot lives is 0xFFF00104 -- and I've verified this by
> typing
> > "g fff00104" at the U-Boot prompt which causes U-Boot to simply
> restart.
> > 
> > I've changed the value in sbc82xx.h and now at the reboot, instead of
> a
> > register dump, it simply hangs.  Looking at m8260_gorom (in
> kernel/head.S)
> > it clears the MSR_EE (ext int. enable) bit in the MSR before jumping
> --
> > but I was wondering if there are other bits in MSR that need to be
> > cleared; e.g. instruction relocation enable and data relocation enable
> > (MSR_IR and MSR_DR). The register bits are on p76 of MPCFPE32B.pdf
> from
> > Freescale.
> > 
> > I guess if somebody even said "it works for me" then I'd have a better
> > feeling thinking that what is done to the MSR currently is sufficient.
> 
> I don't have any problems using reboot() on 8248 based board. 
> Kernel.org-based 2.4.29 tree.
> 
> I have U-Boot at 0xfe00'0000, and I use 0xfe00'0104 as a second 
> parameter for m8260_gorom. Also make sure that first parameter is also 
> correct:
> 
> 	m8260_gorom(__pa(__res), 0xfe000104);
> 
> -- 
> Eugene
> 
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
