Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67D6AB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 04:17:57 +1100 (EST)
Received: from mail32-va3 (localhost.localdomain [127.0.0.1])	by
	mail32-va3-R.bigfish.com (Postfix) with ESMTP id EFF537880EB	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 17:17:50 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.236])	by
	mail32-va3.bigfish.com (Postfix) with ESMTP id AB854CA804F	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 17:17:50 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9BHHlAf001781	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 10:17:47 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o9BHXuKi003193	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 12:33:56 -0500 (CDT)
Date: Mon, 11 Oct 2010 12:17:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101011121745.2e471fc0@udp111988uds.am.freescale.net>
In-Reply-To: <4CB2DEFB.90204@windriver.com>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>
	<4CB2DEFB.90204@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Oct 2010 17:55:07 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> david.hagood@gmail.com wrote:
> > OK, using 224 as the MPIC interrupt number, and attempting to map it via
> > irq_create_mapping(0,224) gives me a kernel seg fault:
> 
> This should not be correct without initialing MSI for MPIC host. As I comment on
> another email, please refer to the file, arch/powerpc/sysdev/fsl_msi.c.

The MSI driver is not going to do anything that would change whether
that call to irq_create_mapping() works or not.  fsl_msi.c would also
probably require some changes to be useful in endpoint mode.

> > Reading the source (since these calls don't seem to have any other
> > documentation), it *looks* like it ought to be valid to call
> > irq_create_mapping with a null irq_host *host - which is good, since I
> > can't see anything obvious that would give me some other irq_host (again,
> > since none of this seems to be documented anywhere).

There's mpic stuff in the call trace, so the NULL host was OK.

Look in arch/powerpc/platforms/86xx/pic.c.  What is the second-to-last
parameter of mpc86xx_init_irq() in your kernel tree?  It's 256 in
current upstream -- this is the number of IRQ sources the MPIC driver
will handle.

-Scott
