Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 51739B722D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2011 05:01:38 +1100 (EST)
Date: Fri, 18 Nov 2011 12:01:14 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Message-ID: <20111118180114.GB28562@schlenkerla.am.freescale.net>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <4EC40406.1030408@freescale.com>
 <54122A43-37D1-438B-A0DD-289B7AE2BA0B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <54122A43-37D1-438B-A0DD-289B7AE2BA0B@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2011 at 08:35:02AM -0600, Kumar Gala wrote:
> 
> On Nov 16, 2011, at 12:42 PM, Scott Wood wrote:
> 
> > On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> >> From: Li Yang <leoli@freescale.com>
> >> 
> >> The timebase sync is not only necessary when using KEXEC. It should also
> >> be used by normal boot up and cpu hotplug. Remove the ifdef added by
> >> the KEXEC patch.
> > 
> > Again, no it should not be used by normal boot up (whether KEXEC support
> > is enabled or not).  We should only do timebase sync when we actually
> > need to (when we've actually just reset a core), and we should do it the
> > way U-Boot does rather than with smp-tbsync.c.
> 
> 
> How can we do u-boot bases timebase sync after the system us up and
> running?  For example would we losing some ticks of time in the case
> that one core is up and we bring a second core online?

Yes, we'll lose a small handful of ticks relative to wall clock time --
but it'll be the same loss on all cores.  It's better than possibly
having the timebase be imperfectly synchronized, and should complete more
quickly.

This is only during intrusive events such as kexec or deep sleep (we only
need to reset the core for jog on mpc8536 which has only one core). 
During deep sleep all cores' timebases will be stopped.  Kexec is
resetting the kernel; it's not going to care what the old timebase was,
and should resync from RTC.

Even if we end up using this for some future power management mode where
we take down some CPUs to the point their timebase stops, but never take
down others, the time loss should be negligible (for comparison, what's
the error tolerance on the crystal frequency?) and acceptable for what is
still a fairly intrusive and rare event.

-Scott
