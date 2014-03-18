Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6307B2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 09:42:33 +1100 (EST)
Message-ID: <1395182529.12479.223.camel@snotra.buserror.net>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Tue, 18 Mar 2014 17:42:09 -0500
In-Reply-To: <20140317111957.GD6204@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312104005.GH4706@localhost.localdomain>
 <1394839107.12479.154.camel@snotra.buserror.net>
 <20140317111957.GD6204@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-17 at 19:19 +0800, Chenhui Zhao wrote:
> On Fri, Mar 14, 2014 at 06:18:27PM -0500, Scott Wood wrote:
> > On Wed, 2014-03-12 at 18:40 +0800, Chenhui Zhao wrote:
> > > On Tue, Mar 11, 2014 at 08:10:24PM -0500, Scott Wood wrote:
> > > > On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> > > > > From: Zhao Chenhui <chenhui.zhao@freescale.com>
> > > > > 
> > > > > T1040 supports deep sleep feature, which can switch off most parts of
> > > > > the SoC when it is in deep sleep mode. This way, it becomes more
> > > > > energy-efficient.
> > > > > 
> > > > > The DDR controller will also be powered off in deep sleep. Therefore,
> > > > > the last stage (the latter part of fsl_dp_enter_low) will run without DDR
> > > > > access. This piece of code and related TLBs will be prefetched.
> > > > > 
> > > > > Due to the different initialization code between 32-bit and 64-bit, they
> > > > > have seperate resume entry and precedure.
> > > > > 
> > > > > The feature supports 32-bit and 64-bit kernel mode.
> > > > > 
> > > > > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > > > > ---
> > > > >  arch/powerpc/include/asm/booke_save_regs.h |    3 +
> > > > >  arch/powerpc/kernel/cpu_setup_fsl_booke.S  |   17 ++
> > > > >  arch/powerpc/kernel/head_fsl_booke.S       |   30 +++
> > > > >  arch/powerpc/platforms/85xx/Makefile       |    2 +-
> > > > >  arch/powerpc/platforms/85xx/deepsleep.c    |  201 +++++++++++++++++++
> > > > >  arch/powerpc/platforms/85xx/qoriq_pm.c     |   38 ++++
> > > > >  arch/powerpc/platforms/85xx/sleep.S        |  295 ++++++++++++++++++++++++++++
> > > > >  arch/powerpc/sysdev/fsl_soc.h              |    7 +
> > > > >  8 files changed, 592 insertions(+), 1 deletions(-)
> > > > >  create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
> > > > >  create mode 100644 arch/powerpc/platforms/85xx/sleep.S
> > > > > 
> > > > > diff --git a/arch/powerpc/include/asm/booke_save_regs.h b/arch/powerpc/include/asm/booke_save_regs.h
> > > > > index 87c357a..37c1f6c 100644
> > > > > --- a/arch/powerpc/include/asm/booke_save_regs.h
> > > > > +++ b/arch/powerpc/include/asm/booke_save_regs.h
> > > > > @@ -88,6 +88,9 @@
> > > > >  #define HIBERNATION_FLAG	1
> > > > >  #define DEEPSLEEP_FLAG		2
> > > > >  
> > > > > +#define CPLD_FLAG	1
> > > > > +#define FPGA_FLAG	2
> > > > 
> > > > What is this?
> > > 
> > > We have two kind of boards, QDS and RDB.
> > > They have different register map. Use the flag to indicate the current board is using which kind
> > > of register map.
> > 
> > CPLD versus FPGA is not a meaningful difference.  We don't care what
> > technology is used to implement programmable logic -- we care what
> > programming interface is exposed.  Customers will have their own boards
> > that will likely not imitate either of these programming interfaces, but
> > what they do have will still probably be implemented in a CPLD or FPGA.
> > Likewise, Freescale may have future reference boards whose CPLD/FPGA is
> > not compatible.
> 
> Will use a better name.
> 
> > 
> > So use better naming, and structure the code so it's easy to plug in
> > implementations for new or custom boards.
> >  
> > > > > diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> > > > > index 20204fe..3285752 100644
> > > > > --- a/arch/powerpc/kernel/head_fsl_booke.S
> > > > > +++ b/arch/powerpc/kernel/head_fsl_booke.S
> > > > > @@ -162,6 +162,19 @@ _ENTRY(__early_start)
> > > > >  #include "fsl_booke_entry_mapping.S"
> > > > >  #undef ENTRY_MAPPING_BOOT_SETUP
> > > > >  
> > > > > +#if defined(CONFIG_SUSPEND) && defined(CONFIG_FSL_CORENET_RCPM)
> > > > > +	/* if deep_sleep_flag != 0, jump to the deep sleep resume entry */
> > > > > +	LOAD_REG_ADDR(r4, deep_sleep_flag)
> > > > > +	lwz	r3, 0(r4)
> > > > > +	cmpwi	r3, 0
> > > > > +	beq	11f
> > > > > +	/* clear deep_sleep_flag */
> > > > > +	li	r3, 0
> > > > > +	stw	r3, 0(r4)
> > > > > +	b	fsl_deepsleep_resume
> > > > > +11:
> > > > > +#endif
> > > > 
> > > > Why do you come in via the normal kernel entry, versus specifying a
> > > > direct entry point for deep sleep resume?  How does U-Boot even know
> > > > what the normal entry is when resuming?
> > > 
> > > I wish to return to a specified point (like 64-bit mode), but the code in
> > > fsl_booke_entry_mapping.S only can run in the first page. Because it
> > > only setups a temp mapping of 4KB.
> > 
> > Why do you need the entry mapping on 32-bit but not 64-bit?
> 
> fsl_booke_entry_mapping.S is for 32-bit. 64-bit calls
> initial_tlb_book3e() in exceptions-64e.S.

The answer I was looking for is that __entry_deep_sleep calls
start_initialization_book3e which calls the code to handle it.

But why is it driven from sleep.S on 64-bit but not on 32-bit?  Why
can't you make it so that the 32-bit TLB setup can be called into in a
similar manner?

> > > > > +#define FSLDELAY(count)		\
> > > > > +	li	r3, (count)@l;	\
> > > > > +	slwi	r3, r3, 10;	\
> > > > > +	mtctr	r3;		\
> > > > > +101:	nop;			\
> > > > > +	bdnz	101b;
> > > > 
> > > > You don't need a namespace prefix on local macros in a non-header file.
> > > > 
> > > > Is the timebase stopped where you're calling this from?
> > > 
> > > No. My purpose is to avoid jump in the last stage of entering deep sleep.
> > > Jump may cause problem at that time.
> > 
> > "bdnz" is a jump.
> > 
> > What problems do you think a jump will cause?
> 
> I mean a far jump which can jump to an address which has not been prefetched in
> advance. I wish the code is executed in a restricted environment (predictable code
> and address).

Why would a timebase loop require a "far" jump?

> > > > You also probably want to do a "sync, readback, data dependency, isync"
> > > > sequence to make sure that the store has hit CCSR before you begin your
> > > > delay (or is a delay required at all if you do that?).
> > > 
> > > Yes. It is safer with a sync sequence.
> > > 
> > > The DDR controller need some time to signal the external DDR modules to
> > > enter self refresh mode.
> > 
> > Is it documented how much time it requires?
> > 
> > -Scott
> 
> No.

How do you know the current delay is adequate in all circumstances (e.g
clock speeds), much less on future chips?  Is it documented that a delay
is needed at all, or is this just something that appeared to make it
work?  If the latter, what happens if you put the synchronization in,
but leave out the delay?

-Scott
