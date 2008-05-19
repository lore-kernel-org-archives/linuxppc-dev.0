Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 0A9B4DE59E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:16:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 16:16:34 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com>
In-Reply-To: <4831ECF0.5090101@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
	<4831ECF0.5090101@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Almost certainly the latter.  Is the disk interrupt shared with any
> other interrupts, that are marked IRQF_NODELAY?  The -rt
> patch doesn't seem to handle mixing the two well.

Disk is on a muxed PCI interrupt. None of the other interrupts on the
mux is fireing at the time.
Is is possible that the demuxer is not set up right? It is based loosely
on pq2-pci-pic.c

=20
> Oh, and just to be sure: you do have CONFIG_PREEMPT_RT turned on, and
> not just CONFIG_PREEMPT, right?  The non-preempt-rt versions in the
-rt
> patch don't look like they disable interrupts, though I may just be
> getting lost in a sea of underscores and ifdefs.

Full CONFIG_PREEMPT_RT. I was actually going to try CONFIG_PREEMPT to
see if anything helped.
