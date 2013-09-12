Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1C4E2C03C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 04:06:43 +1000 (EST)
Message-ID: <1379009192.2536.19.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Thu, 12 Sep 2013 13:06:32 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010652F1@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
 <1378879004-2446-4-git-send-email-dongsheng.wang@freescale.com>
 <1378940642.12204.427.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010652F1@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 22:48 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, September 12, 2013 7:04 AM
> > To: Wang Dongsheng-B40534
> > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > On Wed, 2013-09-11 at 13:56 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Add a sys interface to enable/diable pw20 state or altivec idle, and
> > > control the wait entry time.
> > >
> > > Enable/Disable interface:
> > > 0, disable. 1, enable.
> > > /sys/devices/system/cpu/cpuX/pw20_state
> > > /sys/devices/system/cpu/cpuX/altivec_idle
> > >
> > > Set wait entry bit interface:
> > > bit value range 0~63, 0 bit is Mintime, 63 bit is Maxtime.
> > > /sys/devices/system/cpu/cpuX/pw20_wait_entry_bit
> > > /sys/devices/system/cpu/cpuX/altivec_idle_wait_entry_bit
> > 
> > I'm no fan of the way powerpc does bit numbering, but don't flip it
> > around here -- you'll just cause confusion.
> > 
> OK. 0 bit is maxtime, 63 bit is mintime.
> 
> > Better yet, this interface should take real time units rather than a
> > timebase bit.
> > 
> I think the real time is not suitable, because timebase bit does not correspond with
> real time.

It's a bit sloppy due to how the hardware works, but you could convert
it like you did in earlier patches.  Semantically it should probably be
the minimum time to wait before entering the low power state.
 
> > Also, you disable the power saving mode if the maximum interval is
> > selected, 
> It's not disable the pw20 state or altivec idle, just max-delay entry time.

No, the code checks for zero to set or clear the enabling bit (e.g.
PW20_WAIT).

> >but the documentation doesn't say that -- and the documentation
> > should be in the code (or other easily findable place), not just in the
> > commit message.
> > 
> Also add a comment in the 85xx/common.c ?

Yes.

> > > +_GLOBAL(has_pw20_altivec_idle)
> > > +	/* 0 false, 1 true */
> > > +	li	r3, 0
> > > +
> > > +	/* PW20 & AltiVec idle feature only exists for E6500 */
> > > +	mfspr	r0, SPRN_PVR
> > > +	rlwinm	r4, r0, 16, 16, 31
> > > +	lis	r12, 0
> > > +	ori	r12, r12, PVR_VER_E6500@l
> > > +	cmpw	r4, r12
> > > +	bne	2f
> > > +	li	r3, 1
> > > +2:
> > > +	blr
> > 
> > Why is this in asm?  And shouldn't this go in the cputable somehow?
> > 
> Not a special reason for this, just asm...

Asm shouldn't be used without a good reason.

-Scott
