Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8BCA2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 07:09:40 +1000 (EST)
Message-ID: <1379365769.2536.169.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 16 Sep 2013 16:09:29 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F154392590107C5F0@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
 <1378879004-2446-4-git-send-email-dongsheng.wang@freescale.com>
 <1378940642.12204.427.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010652F1@039-SN2MPN1-023.039d.mgd.msft.net>
 <1379009192.2536.19.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590107C5F0@039-SN2MPN1-021.039d.mgd.msft.net>
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

On Thu, 2013-09-12 at 21:53 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 13, 2013 2:07 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; galak@kernel.crashing.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > On Wed, 2013-09-11 at 22:48 -0500, Wang Dongsheng-B40534 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, September 12, 2013 7:04 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state
> > > > and altivec idle
> > > >
> > > > On Wed, 2013-09-11 at 13:56 +0800, Dongsheng Wang wrote:
> > > > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > > >
> > > > > Add a sys interface to enable/diable pw20 state or altivec idle,
> > > > > and control the wait entry time.
> > > > >
> > > > > Enable/Disable interface:
> > > > > 0, disable. 1, enable.
> > > > > /sys/devices/system/cpu/cpuX/pw20_state
> > > > > /sys/devices/system/cpu/cpuX/altivec_idle
> > > > >
> > > > > Set wait entry bit interface:
> > > > > bit value range 0~63, 0 bit is Mintime, 63 bit is Maxtime.
> > > > > /sys/devices/system/cpu/cpuX/pw20_wait_entry_bit
> > > > > /sys/devices/system/cpu/cpuX/altivec_idle_wait_entry_bit
> > > >
> > > > I'm no fan of the way powerpc does bit numbering, but don't flip it
> > > > around here -- you'll just cause confusion.
> > > >
> > > OK. 0 bit is maxtime, 63 bit is mintime.
> > >
> > > > Better yet, this interface should take real time units rather than a
> > > > timebase bit.
> > > >
> > > I think the real time is not suitable, because timebase bit does not
> > > correspond with real time.
> > 
> > It's a bit sloppy due to how the hardware works, but you could convert it
> > like you did in earlier patches.  Semantically it should probably be the
> > minimum time to wait before entering the low power state.
> > 
> But there has a problem, we can't convert bit to the real time when user read this sysfs.
> Like:
> echo 1000(us) > /sys/*/pw20_wait_entry_bit, after convert we get bit is 49.
> cat /sys/*/pw20_wait_entry_bit, after convert the time is 1598(us).
> 
> The read out of the time is not real time. Unless we define a variable to save the real time.

It's not the end of the world if the value is different when read back.
It just gets rounded up when you write it.

> > > > Also, you disable the power saving mode if the maximum interval is
> > > > selected,
> > > It's not disable the pw20 state or altivec idle, just max-delay entry
> > time.
> > 
> > No, the code checks for zero to set or clear the enabling bit (e.g.
> > PW20_WAIT).
> > 
> There has pw20_state/altivec_idle sys interface to control "enable/disable",
> There is only to control wait bit. Did you mean remove "pw20_state/altivec_idle"
> sys interface, and reuse "pw20_wait_entry_bit/altivec_idle*" sys interface?
> When echo zero into "pw20_wait_entry_bit" we just to disable pw20 state, I think that is reasonable. :)

Sorry, I misread the patch and didn't realize these were separate
interfaces.

-Scott
