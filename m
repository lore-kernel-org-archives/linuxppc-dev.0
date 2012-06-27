Return-Path: <zch@az84smr01.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86CD3B7019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 20:09:30 +1000 (EST)
Received: from mail154-va3 (localhost [127.0.0.1])	by
 mail154-va3-R.bigfish.com (Postfix) with ESMTP id 241A01E0286	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 10:07:42 +0000 (UTC)
Received: from VA3EHSMHS044.bigfish.com (unknown [10.7.14.236])	by
 mail154-va3.bigfish.com (Postfix) with ESMTP id 7F8B2220257	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 10:07:39 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5RA9HPG026821	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 03:09:20 -0700
Date: Wed, 27 Jun 2012 18:10:25 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120627101025.GA10476@localhost.localdomain>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <AB6D43A9-FC54-40D2-A9B0-8B2E785124F9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <AB6D43A9-FC54-40D2-A9B0-8B2E785124F9@kernel.crashing.org>
Sender: <zch@az84smr01.freescale.net>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2012 at 09:03:42AM -0500, Kumar Gala wrote:
> 
> On Jun 26, 2012, at 5:25 AM, Zhao Chenhui wrote:
> 
> > Do hardware timebase sync. Firstly, stop all timebases, and transfer
> > the timebase value of the boot core to the other core. Finally,
> > start all timebases.
> > 
> > Only apply to dual-core chips, such as MPC8572, P2020, etc.
> > 
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Changes for v6:
> > * added 85xx_TB_SYNC
> > * added isync() after set_tb()
> > * removed extra entries from mpc85xx_smp_guts_ids
> 
> Why only on dual-core chips?  Is this because of something related to 2 cores, or related to corenet vs non-corenet SoCs and how turning on/off the timebase works in the SOC?
> 
> - k

I am working on a timebase sync patch for corenet SoCs which have more than 2 cores.
It is based on this patch.

-Chenhui
