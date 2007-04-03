Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 067CEDDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 10:25:42 +1000 (EST)
Date: Tue, 3 Apr 2007 15:10:02 -0700
From: Brad Boyer <flar@allandria.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070403221002.GA13210@cynthia.pants.nu>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175644642.10567.31.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 07:57:22PM -0400, David Woodhouse wrote:
> > The TTY_MAJOR should have never belonged to 8250.c in the first place.
> > I know it's just my opinion, but I think this major device should be
> > owned by the serial core, and it shouldn't matter what chip drives each
> > individual port. Each hardware driver should just register with the
> > core how many ports it has and should be allocated from the same range.
> 
> Yeah, because that works out really well for Ethernet devices and SCSI
> disks, with different numbers every day of the week according to what
> order we happen to load drivers in. :)

It just leads to the problem ethernet has on BSD/Solaris/etc. You have
to ask yourself "is the ethernet on this system le0 or hme0 or maybe
something else entirely?" in this case. I agree it does solve the issue
of detection order breaking the configuration, but it is less than ideal.
I think the issue of the devices shuffling around is less likely to be
a problem on serial, although we don't have the nice uniqueness of
hardware identifiers that was used to do device renaming in ethernet.

I suppose my opinion on this shows that I didn't come from the x86
side of Linux. The breakdown on this argument seems to have always
been that the x86 people wanted 8250 to own ttyS* and most others
wanted it shared. I know it was that way when m68k tried to merge
in their serial framework that did allow such sharing across any
number of hardware drivers.

	Brad Boyer
	flar@allandria.com
