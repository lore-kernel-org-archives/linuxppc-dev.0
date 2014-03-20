Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 206602C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 10:33:25 +1100 (EST)
Message-ID: <1395358390.12479.350.camel@snotra.buserror.net>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Thu, 20 Mar 2014 18:33:10 -0500
In-Reply-To: <20140319005607.GB9735@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312104005.GH4706@localhost.localdomain>
 <1394839107.12479.154.camel@snotra.buserror.net>
 <20140317111957.GD6204@localhost.localdomain>
 <1395182529.12479.223.camel@snotra.buserror.net>
 <20140319005607.GB9735@localhost.localdomain>
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

On Wed, 2014-03-19 at 08:56 +0800, Chenhui Zhao wrote:
> On Tue, Mar 18, 2014 at 05:42:09PM -0500, Scott Wood wrote:
> > On Mon, 2014-03-17 at 19:19 +0800, Chenhui Zhao wrote:
> > > On Fri, Mar 14, 2014 at 06:18:27PM -0500, Scott Wood wrote:
> > > > Why do you need the entry mapping on 32-bit but not 64-bit?
> > > 
> > > fsl_booke_entry_mapping.S is for 32-bit. 64-bit calls
> > > initial_tlb_book3e() in exceptions-64e.S.
> > 
> > The answer I was looking for is that __entry_deep_sleep calls
> > start_initialization_book3e which calls the code to handle it.
> > 
> > But why is it driven from sleep.S on 64-bit but not on 32-bit?  Why
> > can't you make it so that the 32-bit TLB setup can be called into in a
> > similar manner?
> 
> Yes. I also wish to do like this. As I mentioned, the problem in 32-bit
> is that the TLB setup code in fsl_booke_entry_mapping.S only setups a temp
> mapping of 4KB, so these code only can run in this 4KB address space. But the
> code in sleep.S is outside of the 4KB space. So can't put the TLB setup
> code in sleep.S. There are two method to solve it.
> 1) The current method is running the TLB setup code of fsl_booke_entry_mapping.S in the 4KB
> space, then jump to the code of sleep.S.
> 2) extend the temp mapping space in the TLB setup code to cover kernel, say 4MB or 8MB. But
> not sure if there are any side effects.

fsl_booke_entry_mapping.S creates a 64M entry.  The 4K entry is only
temporary while in AS1 -- it shouldn't matter if the address you return
to when leaving fsl_booke_entry_mapping.S is outside the 4K, as long as
it's within the 64M entry.

Or am I missing something?

> > > > > > > +#define FSLDELAY(count)		\
> > > > > > > +	li	r3, (count)@l;	\
> > > > > > > +	slwi	r3, r3, 10;	\
> > > > > > > +	mtctr	r3;		\
> > > > > > > +101:	nop;			\
> > > > > > > +	bdnz	101b;
> > > > > > 
> > > > > > You don't need a namespace prefix on local macros in a non-header file.
> > > > > > 
> > > > > > Is the timebase stopped where you're calling this from?
> > > > > 
> > > > > No. My purpose is to avoid jump in the last stage of entering deep sleep.
> > > > > Jump may cause problem at that time.
> > > > 
> > > > "bdnz" is a jump.
> > > > 
> > > > What problems do you think a jump will cause?
> > > 
> > > I mean a far jump which can jump to an address which has not been prefetched in
> > > advance. I wish the code is executed in a restricted environment (predictable code
> > > and address).
> > 
> > Why would a timebase loop require a "far" jump?
> 
> I mean there is far jump in udely().
> 
> Do you mean using a timebase loop in the macro FSLDELAY? If so, I agree.

Yes, I meant a timebase loop, not udelay().

> > > > > > You also probably want to do a "sync, readback, data dependency, isync"
> > > > > > sequence to make sure that the store has hit CCSR before you begin your
> > > > > > delay (or is a delay required at all if you do that?).
> > > > > 
> > > > > Yes. It is safer with a sync sequence.
> > > > > 
> > > > > The DDR controller need some time to signal the external DDR modules to
> > > > > enter self refresh mode.
> > > > 
> > > > Is it documented how much time it requires?
> > > > 
> > > > -Scott
> > > 
> > > No.
> > 
> > How do you know the current delay is adequate in all circumstances (e.g
> > clock speeds), much less on future chips?  Is it documented that a delay
> > is needed at all, or is this just something that appeared to make it
> > work?  If the latter, what happens if you put the synchronization in,
> > but leave out the delay?
> > 
> > -Scott
> 
> The code controls external parts (FPGA/CPLD, DDR module) to act, and
> the sequent code must wait until external parts complete. We can't get
> an ack from external parts, so use delay to make sure the sequence and
> insert enough time to wait.

It would be good if you could get the hardware designers to provide an
upper bound for how long we need to wait.

-Scott
