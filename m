Return-Path: <david.hagood@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id 661F8B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 03:22:52 +1100 (EST)
Received: by yws5 with SMTP id 5so2713312yws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 09:22:50 -0700 (PDT)
Message-ID: <dccb3790f1fbb04a8df74bd920e57580.squirrel@localhost>
In-Reply-To: <20101014105126.08da9dd7@udp111988uds.am.freescale.net>
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
Date: Thu, 14 Oct 2010 11:22:45 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: "tiejun.chen" <tiejun.chen@windriver.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I may have a clue (you might not think so, but...):

I've configured the init thusly:
mpic1 = mpic_alloc(np, res.start,
	MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN ,
	0, 256,
	" MPIC     ");

Which, as I read the code, should disable the ISU stuff.

I've seeing this on boot:
mpic: Setting up MPIC " MPIC     " version 1.2 at e0040000, max 2 CPUs
mpic: ISU size: 88, shift: 7, mask: 7f
mpic: Initializing for 88 sources

Now, since the interrupt number I want is 224, which, last time I checked,
was > 88, this may be the root cause.

As I read the code:
        /* Read feature register, calculate num CPUs and, for non-ISU
	 * MPICs, num sources as well. On ISU MPICs, sources are counted
	 * as ISUs are added
	 */
	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
	if (isu_size == 0)
		mpic->num_sources =
			((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
			 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
So it would seem to me that the "greg_feature" is saying I have 88
interrupts.

I've tried setting the ISU size to 256:
mpic1 = mpic_alloc(np, res.start,
	MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN ,
	256, 256,
	" MPIC     ");
And that kills the kernel as we init the mpic.

SO, I guess the question in, what sets "greg_feature", as it would seem to
be incorrect.

Or, am I on the wrong trail?
