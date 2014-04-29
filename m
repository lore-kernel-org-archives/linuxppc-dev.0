Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC4021400B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 08:47:25 +1000 (EST)
Message-ID: <1398811632.24575.98.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which
 is STANDBY or MEM
From: Scott Wood <scottwood@freescale.com>
To: Leo Li <pku.leo@gmail.com>
Date: Tue, 29 Apr 2014 17:47:12 -0500
In-Reply-To: <CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
References: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
 <1398462328.24575.20.camel@snotra.buserror.net>
 <CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-pm@vger.kernel.org,
 "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, Dongsheng Wang <dongsheng.wang@freescale.com>,
 =?UTF-8?Q?=E6=AD=A3=E9=9B=84_=E9=87=91?= <jason.jin@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-28 at 13:53 +0800, Leo Li wrote:
> On Sat, Apr 26, 2014 at 5:45 AM, Scott Wood <scottwood@freescale.com> wrote:
> > On Thu, 2014-04-24 at 14:11 +0800, Dongsheng Wang wrote:
> >> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >>
> >> Add set_pm_suspend_state & pm_suspend_state functions to set/get
> >> suspend state. When system going to sleep or deep sleep, devices
> >> can get the system suspend state(STANDBY/MEM) through pm_suspend_state
> >> function and to handle different situations.
> >>
> >> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >> ---
> >> *v2*
> >> Move pm api from fsl platform to powerpc general framework.
> >
> > What is powerpc-specific about this?
> 
> Generally I agree with you.  But I had the discussion about this topic
> a while ago with the PM maintainer.  He suggestion to go with the
> platform way.
> 
> https://lkml.org/lkml/2013/8/16/505

If what he meant was whether you could do what this patch does, then you
can answer him with, "No, because it got nacked as not being platform or
arch specific."  Oh, and you're still using .valid as the hook to set
the platform state, which is awful -- I think .begin is what you want to
use.

If we did it in powerpc code, then what would we do on ARM?  Copy the
code?  No.

Now, a more legitimate objection to putting it in generic code might be
that "standby" and "mem" are loosely defined and the knowledge of how a
driver should react to each is platform specific -- but your patch
doesn't address that.  You still have the driver itself interpret what
"standby" and "mem" mean.

As for "in analogy with ACPI suspend operations", can someone familiar
with ACPI explain what is meant?

-Scott
