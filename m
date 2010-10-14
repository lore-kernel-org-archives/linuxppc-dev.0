Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 941CAB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 03:32:53 +1100 (EST)
Received: from mail19-tx2 (localhost.localdomain [127.0.0.1])	by
	mail19-tx2-R.bigfish.com (Postfix) with ESMTP id A36356A0149	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 16:32:43 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.242])	by
	mail19-tx2.bigfish.com (Postfix) with ESMTP id A1E7347805D	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 16:32:34 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9EGWVon020932	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 09:32:31 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9EGWVvQ004255	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 11:32:31 -0500 (CDT)
Date: Thu, 14 Oct 2010 11:32:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: <david.hagood@gmail.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101014113230.051b967a@udp111988uds.am.freescale.net>
In-Reply-To: <dccb3790f1fbb04a8df74bd920e57580.squirrel@localhost>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>
	<4CB2DEFB.90204@windriver.com>
	<20101011121745.2e471fc0@udp111988uds.am.freescale.net>
	<942ea2f3464025464521511c32355782.squirrel@localhost>
	<20101012162152.5246744a@udp111988uds.am.freescale.net>
	<4CB5088D.4090201@windriver.com>
	<20101013102815.2959fcb6@udp111988uds.am.freescale.net>
	<4CB65F6F.1090103@windriver.com> <4CB6788D.60705@windriver.com>
	<20101014105126.08da9dd7@udp111988uds.am.freescale.net>
	<dccb3790f1fbb04a8df74bd920e57580.squirrel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "tiejun.chen" <tiejun.chen@windriver.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Oct 2010 11:22:45 -0500
<david.hagood@gmail.com> wrote:

> As I read the code:
>         /* Read feature register, calculate num CPUs and, for non-ISU
> 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
> 	 * as ISUs are added
> 	 */
> 	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
> 	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
> 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
> 	if (isu_size == 0)
> 		mpic->num_sources =
> 			((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
> 			 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
> So it would seem to me that the "greg_feature" is saying I have 88
> interrupts.
> 
> I've tried setting the ISU size to 256:
> mpic1 = mpic_alloc(np, res.start,
> 	MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN ,
> 	256, 256,
> 	" MPIC     ");
> And that kills the kernel as we init the mpic.
> 
> SO, I guess the question in, what sets "greg_feature", as it would seem to
> be incorrect.

It comes from FRR[NIRQ].  It seems that this chip takes a
less-than-useful interpretation of what that field means -- it gives
the actual number of sources, not the size of the sparsely populated
array.

If you look at current kernels, you'll find an MPIC_BROKEN_FRR_NIRQS
flag to work around this.

It's not very clear to me what distinction the MPIC code is
trying to make between irq_count and num_sources in the first place,
though.

-Scott
