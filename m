Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 310461A0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 07:23:03 +1000 (AEST)
Message-ID: <1438636971.2097.66.camel@freescale.com>
Subject: Re: [PATCH 3/4] powerpc: pm: add EPU FSM configuration for deep sleep
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Date: Mon, 3 Aug 2015 16:22:51 -0500
In-Reply-To: <1438603291.7515.4@remotesmtp.freescale.net>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
 <1438347186-8462-3-git-send-email-chenhui.zhao@freescale.com>
 <1438389711.19345.99.camel@freescale.com>
 <1438603291.7515.4@remotesmtp.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-03 at 20:01 +0800, Chenhui Zhao wrote:
> On Sat, Aug 1, 2015 at 8:41 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Fri, 2015-07-31 at 20:53 +0800, Chenhui Zhao wrote:
> > >  In the last stage of deep sleep, software will trigger a Finite
> > >  State Machine (FSM) to control the hardware precedure, such as
> > >  board isolation, killing PLLs, removing power, and so on.
> > > 
> > >  When the system is waked up by an interrupt, the FSM controls the
> > >  hardware to complete the early resume precedure.
> > > 
> > >  This patch configure the EPU FSM preparing for deep sleep.
> > > 
> > >  Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > >  ---
> > >   arch/powerpc/platforms/85xx/Makefile    |   2 +-
> > >   arch/powerpc/platforms/85xx/sleep_fsm.c | 256
> > >  ++++++++++++++++++++++++++++++++
> > >   arch/powerpc/platforms/85xx/sleep_fsm.h | 104 +++++++++++++
> > >   3 files changed, 361 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.c
> > >   create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.h
> > 
> > When I asked why this was in drivers/platform[1], you said it was to 
> > share
> > with LS1, and that the values used were the same -- so why did you 
> > move it to
> > arch/powerpc?
> 
> There are some changes. LS1 will use PSCI (Power State Coordination 
> Interface) to implement deep sleep. So these code just used by PowerPC.

Then remove the comment about the values being usable on ls1021.

-Scott
