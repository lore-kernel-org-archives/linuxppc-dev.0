Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5842FB70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 02:51:42 +1100 (EST)
Received: from mail21-tx2 (localhost.localdomain [127.0.0.1])	by
	mail21-tx2-R.bigfish.com (Postfix) with ESMTP id 49D74A40337	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 15:51:32 +0000 (UTC)
Received: from TX2EHSMHS008.bigfish.com (unknown [10.9.14.249])	by
	mail21-tx2.bigfish.com (Postfix) with ESMTP id 03789F0004E	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 15:51:32 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9EFpmbx011576	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 08:51:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9EG6cPT018944	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 11:06:38 -0500 (CDT)
Date: Thu, 14 Oct 2010 10:51:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101014105126.08da9dd7@udp111988uds.am.freescale.net>
In-Reply-To: <4CB6788D.60705@windriver.com>
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

On Thu, 14 Oct 2010 11:27:09 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> tiejun.chen wrote:
> > Scott Wood wrote:
> >> On Wed, 13 Oct 2010 09:17:01 +0800
> >> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> >>
> >>> Scott Wood wrote:
> >>>> The crash is happening somewhere in mpic_set_irq_type():
> >>> Agreed. That is just where I pointed out on my email replied for OOPS. To enable
> >>> DBG to figure out 'src' and 'mpic->irq_count' from the file,
> >>> arch/powerpc/sysdev/mpic.c,    .
> >>> ======
> >>> int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
> >>> {
> >>> 	......
> >>> 	if (src >= mpic->irq_count)
> >>> 		return -EINVAL;
> >>> 			^
> >>> 			I think this OOPS may be from here.
> >> No, it's after that.  His board code is using the mpic's "isu" remapping
> > 
> > I means OOPS is *from* here. According to David's call trace,
> > mpic_set_irq_type() is the last issued function. And that corresponding return
> > value, R3, is '0xffffffea', -22, and also '-EINVAL'.

Just because that value is in r3 doesn't mean that src >=
mpic->irq_count.

Consider something like:

cmplw	r4, r5
li	r3, -EINVAL
bgelr
...


-Scott
