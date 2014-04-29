Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 6BE621400E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 08:57:56 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which is
 STANDBY or MEM
Date: Wed, 30 Apr 2014 01:07:44 +0200
Message-ID: <5757109.6HQDLpcWYD@vostro.rjw.lan>
In-Reply-To: <1398811632.24575.98.camel@snotra.buserror.net>
References: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
 <CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
 <1398811632.24575.98.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-pm@vger.kernel.org,
 Dongsheng Wang <dongsheng.wang@freescale.com>, Leo Li <pku.leo@gmail.com>,
 =?utf-8?B?5q2j6ZuEIOmHkQ==?= <jason.jin@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, April 29, 2014 05:47:12 PM Scott Wood wrote:
> On Mon, 2014-04-28 at 13:53 +0800, Leo Li wrote:
> > On Sat, Apr 26, 2014 at 5:45 AM, Scott Wood <scottwood@freescale.com> wrote:
> > > On Thu, 2014-04-24 at 14:11 +0800, Dongsheng Wang wrote:
> > >> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >>
> > >> Add set_pm_suspend_state & pm_suspend_state functions to set/get
> > >> suspend state. When system going to sleep or deep sleep, devices
> > >> can get the system suspend state(STANDBY/MEM) through pm_suspend_state
> > >> function and to handle different situations.
> > >>
> > >> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >> ---
> > >> *v2*
> > >> Move pm api from fsl platform to powerpc general framework.
> > >
> > > What is powerpc-specific about this?
> > 
> > Generally I agree with you.  But I had the discussion about this topic
> > a while ago with the PM maintainer.  He suggestion to go with the
> > platform way.
> > 
> > https://lkml.org/lkml/2013/8/16/505
> 
> If what he meant was whether you could do what this patch does, then you
> can answer him with, "No, because it got nacked as not being platform or
> arch specific."  Oh, and you're still using .valid as the hook to set
> the platform state, which is awful -- I think .begin is what you want to
> use.
> 
> If we did it in powerpc code, then what would we do on ARM?  Copy the
> code?  No.
> 
> Now, a more legitimate objection to putting it in generic code might be
> that "standby" and "mem" are loosely defined and the knowledge of how a
> driver should react to each is platform specific -- but your patch
> doesn't address that.  You still have the driver itself interpret what
> "standby" and "mem" mean.
> 
> As for "in analogy with ACPI suspend operations", can someone familiar
> with ACPI explain what is meant?

ACPI defines sleep states S3 and S1 which are mappend to "mem" and
"standby" currently, but that may change in the future.

Generally speaking the meaning of "mem" and "standby" is platform-specific
except that "mem" should be a deeper (lower-power) sleep state than "standby".

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
