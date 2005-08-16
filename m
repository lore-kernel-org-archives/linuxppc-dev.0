Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 31E7C67F5C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 15:52:27 +1000 (EST)
Date: Mon, 15 Aug 2005 22:52:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050815225224.F28706@cox.net>
References: <20050810093735.B22586@cox.net>
	<20050811194307.GW3187@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050811194307.GW3187@smtp.west.cox.net>;
	from trini@kernel.crashing.org on Thu, Aug 11, 2005 at 12:43:07PM
	-0700
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Use todc on Mot PReP platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 12:43:07PM -0700, Tom Rini wrote:
> On Wed, Aug 10, 2005 at 09:37:35AM -0700, Matt Porter wrote:
> 
> > This restores behavior from 2.4 where PReP platforms identified
> > as Motorola would calibrate the decrementer using the RTC. On
> > real Motorola PReP hardware this isn't needed. However, in order
> > to boot a stock 2.6 PReP kernel on qemu (which emulates a Motorola
> > PReP system) it is necessary to allow it to calibrate the decrementer
> > using an emulated RTC.  If the decrementer rate is read from
> > residual data then timing is screwed since a qemu PReP system typically
> > runs much faster than the original hardware.
> > 
> > If anybody has objections to this as the default, let me know. It
> > still works (as did 2.4) on a couple of my Mot PReP boxes and doesn't
> > affect the IBM PReP paths. My goal with this is to be able to run
> > a stock 2.6 defconfig PReP build on qemu.
> 
> So, I like this, and not just because I'm playing with qemu as well.

Why? It has no other redeeming quality except that it makes qemu work.
It's better to use residual data versus todc calibration in real machine
cases since residual data is accurate for this particular value on these
machines. I'm just curious why you would like this patch outside of
its qemu value.

BTW, it's _possible_ that we might eventually modify the open
hackware OF to do a timing loop and dynamically fill in the
residual data time base freq but that's unfamiliar territory and
this is an easy workaround.

> Leigh, can you run this on any 'interesting' PReP you've got that might
> tickle a bug here?  Thanks.

Let me know if there's anything more that needs to be tested. Otherwise,
I plan to send upstream soon.

Thanks,
Matt
