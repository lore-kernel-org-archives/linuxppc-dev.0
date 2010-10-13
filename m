Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 638FEB70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 06:57:03 +1100 (EST)
Received: from mail110-tx2 (localhost.localdomain [127.0.0.1])	by
	mail110-tx2-R.bigfish.com (Postfix) with ESMTP id 0D89546814C	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 19:56:53 +0000 (UTC)
Received: from TX2EHSMHS014.bigfish.com (unknown [10.9.14.243])	by
	mail110-tx2.bigfish.com (Postfix) with ESMTP id C17357C805A	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 19:56:52 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9DJunGQ019510	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 12:56:49 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9DKBxJV003516	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 15:11:59 -0500 (CDT)
Date: Wed, 13 Oct 2010 14:56:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: <david.hagood@gmail.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101013145647.0f066959@udp111988uds.am.freescale.net>
In-Reply-To: <1c6d107b01e69a0466fd4e4eb4aaf26e.squirrel@localhost>
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
	<1c6d107b01e69a0466fd4e4eb4aaf26e.squirrel@localhost>
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

On Wed, 13 Oct 2010 12:08:16 -0500
<david.hagood@gmail.com> wrote:

> Do you have any suggestions on where to find out what parameters I should
> pass to mpic_assign_isu() to map the interrupts? It's another of those
> charmingly undocumented functions, even in the most recent git pull of the
> mainline kernel.

I'd just rip the whole thing out of the board code, and pass zero in
isu_size to mpic_alloc(), if you can undo whatever is depending on the
remapping.

Otherwise, I'm guessing from the lines that you posted that you want to
add:

mpic_assign_isu(mpic1, 14, res.start + 0x11c00);

-Scott
