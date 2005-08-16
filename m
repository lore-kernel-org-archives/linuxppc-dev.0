Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp4.wanadoo.fr (smtp4.wanadoo.fr [193.252.22.27])
	by ozlabs.org (Postfix) with ESMTP id D376667F36
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 17:39:22 +1000 (EST)
Received: from smtp4.wanadoo.fr (mwinf0408 [172.22.135.38])
	by mwinf0410.wanadoo.fr (SMTP Server) with ESMTP id 4A5517401134
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 09:21:16 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0408.wanadoo.fr (SMTP Server) with ESMTP id C5AA11C0018F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 09:21:10 +0200 (CEST)
Date: Tue, 16 Aug 2005 09:19:12 +0200
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050816071912.GA18653@localhost.localdomain>
References: <20050810093735.B22586@cox.net>
	<20050811194307.GW3187@smtp.west.cox.net>
	<20050815225224.F28706@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050815225224.F28706@cox.net>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Use todc on Mot PReP platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 15, 2005 at 10:52:24PM -0700, Matt Porter wrote:
> On Thu, Aug 11, 2005 at 12:43:07PM -0700, Tom Rini wrote:
> > On Wed, Aug 10, 2005 at 09:37:35AM -0700, Matt Porter wrote:
> > 
> > > This restores behavior from 2.4 where PReP platforms identified
> > > as Motorola would calibrate the decrementer using the RTC. On
> > > real Motorola PReP hardware this isn't needed. However, in order
> > > to boot a stock 2.6 PReP kernel on qemu (which emulates a Motorola
> > > PReP system) it is necessary to allow it to calibrate the decrementer
> > > using an emulated RTC.  If the decrementer rate is read from
> > > residual data then timing is screwed since a qemu PReP system typically
> > > runs much faster than the original hardware.
> > > 
> > > If anybody has objections to this as the default, let me know. It
> > > still works (as did 2.4) on a couple of my Mot PReP boxes and doesn't
> > > affect the IBM PReP paths. My goal with this is to be able to run
> > > a stock 2.6 defconfig PReP build on qemu.
> > 
> > So, I like this, and not just because I'm playing with qemu as well.
> 
> Why? It has no other redeeming quality except that it makes qemu work.
> It's better to use residual data versus todc calibration in real machine
> cases since residual data is accurate for this particular value on these
> machines. I'm just curious why you would like this patch outside of
> its qemu value.
> 
> BTW, it's _possible_ that we might eventually modify the open
> hackware OF to do a timing loop and dynamically fill in the
> residual data time base freq but that's unfamiliar territory and
> this is an easy workaround.

What about modifying qemu's OF to emulate a chrp machine instead ?

Friendly,

Sven Luther
