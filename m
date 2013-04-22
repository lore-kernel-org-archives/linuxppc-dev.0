Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4EBF2C14E3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:57:53 +1000 (EST)
Date: Mon, 22 Apr 2013 18:57:28 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 06/15] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20130422105727.GB32331@localhost.localdomain>
References: <20130419110057.GC29421@localhost.localdomain>
 <1657553.UtlPcXdK4G@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1657553.UtlPcXdK4G@vostro.rjw.lan>
Cc: linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 01:43:29AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 19, 2013 07:00:57 PM Zhao Chenhui wrote:
> > ----- Forwarded message from Zhao Chenhui <chenhui.zhao@freescale.com> -----
> > 
> > Date: Fri, 19 Apr 2013 18:47:39 +0800
> > From: Zhao Chenhui <chenhui.zhao@freescale.com>
> > To: linuxppc-dev@lists.ozlabs.org
> > CC: linux-kernel@vger.kernel.org
> > Subject: [linuxppc-release] [PATCH v2 06/15] powerpc/85xx: add support to JOG feature using cpufreq interface
> > X-Mailer: git-send-email 1.7.3
> > 
> > From: chenhui zhao <chenhui.zhao@freescale.com>
> > 
> > Some 85xx silicons like MPC8536 and P1022 have a JOG feature, which provides
> > a dynamic mechanism to lower or raise the CPU core clock at runtime.
> > 
> > This patch adds the support to change CPU frequency using the standard
> > cpufreq interface. The ratio CORE to CCB can be 1:1(except MPC8536), 3:2,
> > 2:1, 5:2, 3:1, 7:2 and 4:1.
> > 
> > Two CPU cores on P1022 must not in the low power state during the frequency
> > transition. The driver uses a atomic counter to meet the requirement.
> > 
> > The jog mode frequency transition process on the MPC8536 is similar to
> > the deep sleep process. The driver need save the CPU state and restore
> > it after CPU warm reset.
> > 
> > Note:
> >  * The I/O peripherals such as PCIe and eTSEC may lose packets during
> >    the jog mode frequency transition.
> >  * The driver doesn't support MPC8536 Rev 1.0 due to a JOG erratum.
> >    Subsequent revisions of MPC8536 have corrected the erratum.
> > 
> > Signed-off-by: Dave Liu <daveliu@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > CC: Scott Wood <scottwood@freescale.com>
> 
> Well, I'd like someone from the PowerPC camp to comment on this before I take it.
> 
> Thanks,
> Rafael
> 

OK. Thanks.

-Chenhui
